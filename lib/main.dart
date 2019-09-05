import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './search_bar.dart';
import './video_view.dart';
import './welcome_screen.dart';
import './video_manager.dart';

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
  final Map response = {};
  Widget videoTab;

  Future<String> getVideo() async {
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(Uri.encodeFull(
        "http://yt-api.baizuo.online/simpleinfo?videolink=https://www.youtube.com/watch?v=yIVqIAv11Gg"));
    print(response.body);
    pagesList[0] = VideoView(json.decode(response.body));
    setState(() {
      loading = false;
      found = true;
      currentPage = pagesList[0];
    });
  }

  int navIndex = 0;
  List<Widget> pagesList = [];
  Widget currentPage;
  List<Map> videoList = [];

  @override
  void initState() {
    /* init nav */
    Widget wA = Text("widget 2");
    Widget wB = Text("widget 3");
    Widget videoListView=VideoManager();
    videoTab = WelcomeScreen();
    pagesList = [videoTab, videoListView, wB];
    currentPage = pagesList[navIndex];

    /* init videolist from storage */
    videoList=[];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: Scaffold(
        appBar: SearchBar(
            searchVideo: (data) {
              print(data);
              getVideo();
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
