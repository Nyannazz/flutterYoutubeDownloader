import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'dart:convert';

import './search_bar.dart';
import './video_view.dart';
import './welcome_screen.dart';
import './video_manager.dart';
import './video_name_dialog.dart';
import './state_provider.dart';

void main() => runApp(MyApp());

void getVideo(String url, Function callback) {}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool loading = false;
  bool found = false;
  bool error = false;
  Widget videoTab;
  Database videoDB;
  Map videoData;
  String newVideoUrl;

  Future<String> getVideo(String videoUrl) async {
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(Uri.encodeFull(
        "http://yt-api.baizuo.online/simpleinfo?videolink=$videoUrl"));
    if (response.statusCode == 200) {
      videoData = json.decode(response.body);
      pagesList[0] = VideoView(data: videoData, videoUrl: videoUrl);
      setState(() {
        loading = false;
        found = true;
        currentPage = pagesList[0];
        newVideoUrl = videoUrl;
      });
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
  Widget videoListView;

  @override
  void initState() {
    /* init nav */
    Widget wB = VideoNameDialog();

    videoTab = WelcomeScreen();
    videoListView = VideoManager(getVideo: getVideo);
    pagesList = [videoTab, videoListView, wB];
    currentPage = pagesList[navIndex];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: StateProvider(
        videoData: videoData,
        getVideo: getVideo,
        videoUrl: newVideoUrl,
        child: Scaffold(
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
                icon: Icon(Icons.person),
                title: Text('Profile'),
              )
            ],
          ),
          body: currentPage,
        ),
      ),
    );
  }
}
