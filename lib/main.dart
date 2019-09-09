import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

import './search_bar.dart';
import './video_view.dart';
import './welcome_screen.dart';
import './video_manager.dart';
import './video_name_dialog.dart';
import './sqlLite/database.dart';
import './sqlLite/video_model.dart';

void main() => runApp(MyApp());

void getVideo(String url, Function callback) {}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool loading = false;
  bool found = false;
  bool error = false;
  final Map response = {};
  Widget videoTab;
  Database videoDB;

  Future<String> getVideo(String videoUrl) async {
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(Uri.encodeFull(
        "http://yt-api.baizuo.online/simpleinfo?videolink=$videoUrl"));
    if (response.statusCode == 200) {
      pagesList[0] =
          VideoView(data: json.decode(response.body), videoUrl: videoUrl);
      setState(() {
        loading = false;
        found = true;
        currentPage = pagesList[0];
      });

      /* videoDB = createConnection().then(() => print("done")); */
    } else {
      pagesList[0] = Text("something went wrong! :(");
      setState(() {
        loading = false;
        found = true;
        error = true;
        currentPage = pagesList[0];
      });
    }
  }

  int navIndex = 0;
  List<Widget> pagesList = [];
  Widget currentPage;
  List videoList = [];

  @override
  void initState() {
    /* init nav */
    Widget wB = VideoNameDialog();
    Widget videoListView = VideoManager();
    videoTab = WelcomeScreen();
    pagesList = [videoTab, videoListView, wB];
    currentPage = pagesList[navIndex];

    /* init videolist from storage */
    DBProvider.db.getAllVideos().then(
          (e) => e.forEach(
            (item) {
              String videoJson = videoToJson(item);
              setState(() {
                videoList.add(videoJson);
              });
            },
          ),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    videoList.forEach((e) => print("\n\n\n"+e));
    print(videoList);
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: SearchBar(
            searchVideo: (data) {
              print(data);
              getVideo(data);
            },
            appName: "CoonTube"),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navIndex,
          onTap: (int index) {
            setState(() {
              navIndex = index;
              currentPage = pagesList[index];
            });
            print(navIndex);
          }, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Messages'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text('Profile'))
          ],
        ),
        body: /* videoTab */ currentPage
        /* SnackBarPage() */,
      ),
    );
  }
}
