import 'package:flutter/material.dart';

class FormatSelect extends StatelessWidget {
  final List formats;
  FormatSelect([this.formats = const []]);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Expanded(
        child: Column(
          children: [
            Card(
              child: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.audiotrack, color: Colors.deepPurple)),
                  Tab(
                      icon:
                          Icon(Icons.ondemand_video, color: Colors.deepPurple)),
                ],
              ),
            ),
            Expanded(
                child: Card(
              child: TabBarView(
                children: [
                  Icon(Icons.audiotrack, color: Colors.deepPurple),
                  ListView(
                    children: <Widget>[],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
