import 'dart:io';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';



class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

/* /*   static Future<File> get getFile async{
    final path=await getFilePath;
    return path('$path/myfile.txt');
  } */

  static Future<File> saveToFile(String data) async{
    final file=await getFile();
    return file.writeAsString(data);
  } */
}

bool filterFormat(str, val) {
  List strParts = str.split("/");
  return strParts[0] == val;
}

Future<String> getFilePath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

/* downloadVideo() async{
  print("hello download");
  PermissionStatus permissionResult = await SimplePermissions.requestPermission(Permission. WriteExternalStorage);

  if ( permissionResult == PermissionStatus.authorized/*   || true */) {
    String dirPath=await getFilePath();
    print(dirPath);
    HttpClient client = new HttpClient();
    client
        .getUrl(Uri.parse("https://i.imgur.com/W4KUBGP.jpg"))
        .then((HttpClientRequest request) {
      print(request);
      return request.close();
    }).then((HttpClientResponse response) {
      print("step 3");
      var dataFlow=response.pipe(new File('$dirPath/logo_pipe.jpg').openWrite());
    });
  }
} */

/* downloadVideo() async {
  print("hello download");
  PermissionStatus permissionResult = await SimplePermissions.requestPermission(
      Permission.WriteExternalStorage);

  if (permissionResult == PermissionStatus.authorized) {
    String dirPath = await getFilePath();
    print(dirPath);
    HttpClient client = new HttpClient();
    var _downloadData = List<int>();
    var fileSave = new File('$dirPath/dogo.jpg');
    client
        .getUrl(Uri.parse(
            "https://i.imgur.com/W4KUBGP.jpg"))
        .then((HttpClientRequest request) {
      return request.close();
    }).then((HttpClientResponse response) {
      response.listen((d) => 
        _downloadData.addAll(d)
      , onDone: () {
        fileSave.writeAsBytes(_downloadData);
      });
    });
  }
} */

Future<void> downloadVideo() async {
    Dio dio = Dio();

    var dirToSave = await getApplicationDocumentsDirectory();

    await dio.download("https://i.imgur.com/W4KUBGP.jpg", "${dirToSave.path}/myImage.jpg",
      onReceiveProgress: (rec, total) {
      print(((rec / total) * 100).toStringAsFixed(0) + "%");
    });

    try {} catch (e) {
      throw e;
    }
    print("done");
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
