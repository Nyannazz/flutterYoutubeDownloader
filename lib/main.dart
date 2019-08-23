import 'package:flutter/material.dart';
import 'package:async/async.dart' as async;
import 'package:http/http.dart' as http;
import 'dart:convert';

import './video_manager.dart';
import './search_bar.dart';

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
  final Map appState = {
    'loading': false,
    'error': false,
    'found': false,
    'response': {},
  };

  Future<String> getVideo() async {
    setState(() {
      appState["loading"] = true;
    });
    http.Response response = await http.get(Uri.encodeFull(
        "http://82.165.121.77:5000/simpleinfo?videolink=https://www.youtube.com/watch?v=Kk3hKNNSHqY"));
    print(response.body);
    setState(() {
      appState["loading"] = false;
      appState["found"] = true;
      appState["response"] = json.decode(response.body);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
              print(appState);
              getVideo();
            },
            appName: "CoonTube"),
        body: appState['loading']
            ? VideoManager("asd")
            : Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                            ((appState["response"].containsKey("title"))
                                ? appState["response"]["title"]
                                : "waiting"),
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.green)),
                      ),
                      if (appState['found'])
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Image.network(
                                    appState["response"]["thumbnail"],
                                    /* width: 100.0,
                                height: 100.0, */
                                    fit: BoxFit.contain),
                              ),
                            ],
                          ),
                        ),
                      Card(
                          child: DefaultTabController(
                        length: 2,
                        child: Row(
                          children: <Widget>[
                            TabBar(
                              tabs: [
                                Tab(
                                    icon: Icon(Icons.search,
                                        color: Colors.deepPurple)),
                                Tab(
                                    icon: Icon(Icons.directions_transit,
                                        color: Colors.deepPurple)),
                              ],
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
