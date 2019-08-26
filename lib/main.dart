import 'package:flutter/material.dart';
import 'package:async/async.dart' as async;
import 'package:http/http.dart' as http;
import 'dart:convert';
import './video_manager.dart';
import './search_bar.dart';
import './video_view.dart';
import './snack_bar.dart';

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
  Widget videoTab = Text("wating");

  Future<String> getVideo() async {
    setState(() {
      loading = true;
    });
    http.Response response = await http.get(Uri.encodeFull(
        "http://82.165.121.77:5000/simpleinfo?videolink=https://www.youtube.com/watch?v=Kk3hKNNSHqY"));
    print(response.body);
    setState(() {
      loading = false;
      found = true;
      /* response = json.decode(response.body); */
      videoTab = VideoView(json.decode(response.body));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* _tabController = TabController(length: 2); */
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
            currentIndex: 0, // this will be set when a new tab is tapped
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
          body: /* videoTab */
              SnackBarPage(),),
    );
  }
}
