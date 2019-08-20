import 'package:flutter/material.dart';

class Videos extends StatelessWidget {
  final List<String> videos;
  
  Videos(this.videos);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: videos
          .map(
            (element) => Card(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/panda.jpg'),
                  Text('Youtube Video')
                ],
              ),
            ),
          )
          .toList(),
    );
  }
  
}