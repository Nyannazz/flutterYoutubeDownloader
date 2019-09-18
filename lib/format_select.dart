import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import './video_name_dialog.dart';
import './sqlLite/database.dart';
import './sqlLite/video_model.dart';

class FormatSelect extends StatefulWidget {
  final List formatList;
  final String videoUrl;
  final String videoName;
  final String thumbnail;

  FormatSelect(
      {Key key, this.thumbnail, this.formatList, this.videoName, this.videoUrl})
      : super(key: key);
  @override
  _FormatSelectState createState() => _FormatSelectState();
}

class _FormatSelectState extends State<FormatSelect> {
  int selectedRow = 0;
  String currentVideoName;

  @override
  void initState() {
    currentVideoName = widget.videoName;
    super.initState();
  }

  void updateSnackBar(scaffoldContext, String message, int snackDuration) {
    scaffoldContext.removeCurrentSnackBar();

    scaffoldContext.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: snackDuration),
    ));
  }

  Future<void> downloadVideo(String targetUrl, String videoName,
      String videoFormat, scaffoldContext, Function callback) async {
    /* get write permission from user */
    PermissionStatus permissionResult =
        await SimplePermissions.requestPermission(
            Permission.WriteExternalStorage);
    if (permissionResult == PermissionStatus.authorized) {
      Dio dio = Dio();

      var dlDir = await DownloadsPathProvider.downloadsDirectory;
      String filePath="${dlDir.path}/$videoName.$videoFormat";

      try {
        updateSnackBar(scaffoldContext, "DOWNLOAD STARTED", 2);
        await dio.download(targetUrl, filePath,
            onReceiveProgress: (rec, total) {
          print(((rec / total) * 100).toStringAsFixed(0) + "%");
        });
      } catch (e) {
        updateSnackBar(scaffoldContext, "DOWNLOAD FAILED", 2);

        throw e;
      }
      print("done");
      // save video in database after download succesfully finished
      callback(filePath);
      updateSnackBar(scaffoldContext, "DOWNLOAD FINISHED", 2);
    }
  }

  void saveVideo(
    String title,
    String videoUrl,
    String dlUrlForFormat,
    String thumbnailPath,
    String filePath,
    String formatSelected,
  ) {
    DBProvider.db.newVideo(Video(
        name: title,
        url: videoUrl,
        downloadUrl: dlUrlForFormat,
        thumbnailPath: thumbnailPath,
        filePath: filePath,
        formatSelected: formatSelected));
  }

  List createRows(
    List inputList,
    String videoName,
    String videoUrl,
    String thumbnail,
    int selected,
    scaffoldContext,
  ) {
    List<DataRow> outputList = [];
    for (int i = 0; i < inputList.length; i++) {
      outputList.add(DataRow(
        /* onSelectChanged: (bool value) {
        print(value);
      }, */
        selected: i == selected,
        cells: <DataCell>[
          DataCell(Text(inputList[i]["type"]), onTap: () {
            setState(() {
              selectedRow = i;
            });
          }),
          DataCell(
              (i == selected
                  ? Center(
                      child: Container(
                        color: Colors.lightBlue,
                        height: 30.0,
                        child: RaisedButton(
                          child: Text("SAVE"),
                          onPressed: () {
                            /* save video in database */
                            saveVideo(
                              videoName,
                              videoUrl,
                              inputList[i]["url"],
                              thumbnail,
                              "",
                              inputList[i]["type"],
                            );
                            updateSnackBar(scaffoldContext, "VIDEO SAVED", 2);
                          },
                        ),
                      ),
                    )
                  : Text(inputList[i]["quality"].toString())), onTap: () {
            print(inputList[i]["url"]);
            setState(() {
              selectedRow = i;
            });
          }),
          DataCell(
              (i == selected
                  ? Center(
                      child: Container(
                        color: Colors.greenAccent,
                        height: 30.0,
                        /* button that opens a dialog to give your download a custom name or just start the download */
                        child: VideoNameDialog(
                            initialContent: currentVideoName,
                            submitForm: (String newName) {
                              downloadVideo(
                                inputList[i]["url"],
                                newName,
                                inputList[i]["type"].split("/")[1],
                                scaffoldContext,
                                (String filePath)=>saveVideo(
                                  videoName,
                                  videoUrl,
                                  inputList[i]["url"],
                                  thumbnail,
                                  filePath,
                                  inputList[i]["type"],
                                ),
                              );
                            }),
                      ),
                    )
                  : Text(inputList[i]["videoOnly"].toString())), onTap: () {
            setState(() {
              selectedRow = i;
            });
          }),
        ],
      ));
    }
    return outputList;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          /* columnSpacing: 50.0, */
          columns: <DataColumn>[
            DataColumn(label: Text("type"), numeric: false),
            DataColumn(label: Text("quality"), numeric: false),
            DataColumn(
              label: Text("only video"),
              numeric: false,
            ),
          ],
          rows: createRows(
            widget.formatList,
            widget.videoName,
            widget.videoUrl,
            widget.thumbnail,
            selectedRow,
            Scaffold.of(context),
          )),
    );
  }
}
