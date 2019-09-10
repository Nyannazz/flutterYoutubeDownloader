import 'package:flutter/material.dart';
import './video_item.dart';

class VideoListTab extends StatelessWidget {
  final List videoList;
  const VideoListTab({Key key, this.videoList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: 
          videoList.map((item)=>
            VideoItem(video: item)
          ).toList(),
        
      ),
    );
  }
}
