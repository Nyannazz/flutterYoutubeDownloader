import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';

class FormatSelect extends StatefulWidget {
  final List formatList;
  FormatSelect(this.formatList);
  @override
  _FormatSelectState createState() => _FormatSelectState();
}

class _FormatSelectState extends State<FormatSelect> {
  int selectedRow = 0;

  void updateSnackBar(scaffoldContext, String message, int snackDuration) {
    scaffoldContext.removeCurrentSnackBar();

    scaffoldContext.showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: snackDuration),
    ));
  }

  Future<void> downloadVideo(String url, scaffoldContext) async {
    PermissionStatus permissionResult =
        await SimplePermissions.requestPermission(
            Permission.WriteExternalStorage);
    if (permissionResult == PermissionStatus.authorized) {
      Dio dio = Dio();

      var dlDir = await DownloadsPathProvider.downloadsDirectory;

      try {
        updateSnackBar(scaffoldContext, "DOWNLOAD STARTED", 2);
        await dio.download(
            "https://i.imgur.com/W4KUBGP.jpg", "${dlDir.path}/dogo.jpg",
            onReceiveProgress: (rec, total) {
          print(((rec / total) * 100).toStringAsFixed(0) + "%");
        });
      } catch (e) {
        throw e;
      }
      print("done");
      updateSnackBar(scaffoldContext, "DOWNLOAD FINISHED", 2);
      /* snackBarCallBack("DOWNLOAD FINISHED", 2); */
    }
  }

  List createRows(List inputList, int selected, scaffoldContext) {
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
                            /* snackBarCallBack("VIDEO SAVED", 2); */
                            updateSnackBar(scaffoldContext, "VIDEO SAVED", 2);
                          },
                        ),
                      ),
                    )
                  : Text(inputList[i]["quality"].toString())), onTap: () {
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
                        child: RaisedButton(
                          child: Text("DL"),
                          onPressed: () {
                            downloadVideo("asd", scaffoldContext);
                          },
                        ),
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
          rows: createRows(widget.formatList, selectedRow, Scaffold.of(context))),
    );
  }
}
