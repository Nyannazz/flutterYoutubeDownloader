/* import 'dart:io'; */
import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import './format_select.dart';

bool filterFormat(str, val) {
  List strParts = str.split("/");
  return strParts[0] == val;
}

class FormatTabs extends StatelessWidget {
  final List formats;
  FormatTabs([this.formats = const []]);

  List<Widget> createFormatList(arr, snackBarCallBack) {
    List<Widget> formatList = [];
    for (Map item in arr) {
      formatList.add(
          Align(alignment: Alignment.centerLeft, child: Text(item["type"])));
      formatList.add(
          Align(alignment: Alignment.centerLeft, child: Text(item["quality"])));
      formatList.add(Center(
          child: Container(
              height: 30.0,
              child: RaisedButton(
                  onPressed: () {
                    downloadVideo(snackBarCallBack);
                  },
                  child: Text("DOWNLOAD")))));
    }

    return formatList;
  }

  Future<void> downloadVideo(snackBarCallBack) async {
    PermissionStatus permissionResult =
        await SimplePermissions.requestPermission(
            Permission.WriteExternalStorage);
    if (permissionResult == PermissionStatus.authorized) {
      Dio dio = Dio();

      /* var dirToSave = await getApplicationDocumentsDirectory();
    var dirLol=await getExternalStorageDirectory(); */
      var dlDir = await DownloadsPathProvider.downloadsDirectory;
      /* Future<Directory> downloadsDirectory = DownloadsPathProvider.downloadsDirectory; */

      try {
        await dio.download(
            "https://i.imgur.com/W4KUBGP.jpg", "${dlDir.path}/dogo.jpg",
            onReceiveProgress: (rec, total) {
          print(((rec / total) * 100).toStringAsFixed(0) + "%");
        });
      } catch (e) {
        throw e;
      }
      print("done");
      snackBarCallBack();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List audioFormats =
        formats.where((item) => filterFormat(item["type"], "audio")).toList();
    final List videoFormats =
        formats.where((item) => filterFormat(item["type"], "video")).toList();
    return Card(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Card(
              child: TabBar(
                tabs: [
                  Tab(
                      icon:
                          Icon(Icons.ondemand_video, color: Colors.deepPurple)),
                  Tab(icon: Icon(Icons.audiotrack, color: Colors.deepPurple)),
                ],
              ),
            ),
            Expanded(
                child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: TabBarView(
                children: [
                  FormatSelect(videoFormats),
                  FormatSelect(audioFormats),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
