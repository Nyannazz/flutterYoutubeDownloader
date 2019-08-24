import 'package:flutter/material.dart';

class ImageTab extends StatelessWidget{
  final String srcUrl;
  ImageTab(this.srcUrl);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Image.network(srcUrl,
            fit: BoxFit.contain),
          ),
        ],
      ),
    );
  }
}