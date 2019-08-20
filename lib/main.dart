import 'package:flutter/material.dart';

import './video_manager.dart';
import './search_bar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: SearchBar(searchVideo: (){},appName: "CoonTube"),
        body: VideoManager(),
      ),
    );
  }
}
