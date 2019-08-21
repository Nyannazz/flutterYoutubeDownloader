
import 'package:flutter/material.dart';

import './video_manager.dart';
import './search_bar.dart';

void main() => runApp(MyApp());


void getVideo(String url, Function callback){

}

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final Map appState={
    'loading':false,
    'error':false,
    'response': {
      
    },
    };
  
  @override 
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: Scaffold(
        appBar: SearchBar(
          searchVideo: (data){
            print(data);
            print(appState);
          },
          appName: "CoonTube"),
        body: VideoManager("asd"),
      ),
    );
  }
}
