import 'dart:io';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';




bool filterFormat(str, val) {
  List strParts = str.split("/");
  return strParts[0] == val;
}

Future<String> getFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}



Future<void> downloadVideo() async {
  PermissionStatus permissionResult = await SimplePermissions.requestPermission(
      Permission.WriteExternalStorage);
  if (permissionResult == PermissionStatus.authorized) {
    Dio dio = Dio();

    /* var dirToSave = await getApplicationDocumentsDirectory();
    var dirLol=await getExternalStorageDirectory(); */
    var dlDir = await DownloadsPathProvider.downloadsDirectory;
    /* Future<Directory> downloadsDirectory = DownloadsPathProvider.downloadsDirectory; */

    try {
      await dio
          .download("https://i.imgur.com/W4KUBGP.jpg", "${dlDir.path}/dogo.jpg",
              onReceiveProgress: (rec, total) {
        print(((rec / total) * 100).toStringAsFixed(0) + "%");
      });
    } catch (e) {
      throw e;
    }
    print("done");
  }
}

List<Widget> createFormatList(arr) {
  List<Widget> formatList = [];
  for (Map item in arr) {
    formatList
        .add(Align(alignment: Alignment.centerLeft, child: Text(item["type"])));
    formatList.add(
        Align(alignment: Alignment.centerLeft, child: Text(item["quality"])));
    formatList.add(Center(
        child: Container(
            height: 30.0,
            child: RaisedButton(
                onPressed: () {
                  downloadVideo();
                },
                child: Text("DOWNLOAD")))));
  }

  return formatList;
}

class FormatSelect extends StatelessWidget {
  final List formats;
  FormatSelect([this.formats = const []]);

  @override
  Widget build(BuildContext context) {
    final List audioFormats =
        formats.where((item) => filterFormat(item["type"], "audio")).toList();
    final List videoFormats =
        formats.where((item) => filterFormat(item["type"], "video")).toList();
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Card(
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.ondemand_video, color: Colors.deepPurple)),
                Tab(icon: Icon(Icons.audiotrack, color: Colors.deepPurple)),
              ],
            ),
          ),
          Expanded(
              child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: TabBarView(
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                        children: createFormatList(videoFormats)),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                        children: createFormatList(audioFormats)),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
