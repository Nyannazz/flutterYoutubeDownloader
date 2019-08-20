import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<String> _videos = ['Red Panda'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('CoonTube'),
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child:
                    RaisedButton(onPressed: () {
                      setState(() {
                       _videos.add('cat video');
                        
                      });
                    }, 
                    child: Text('Add Product')),
              ),
              Column(
                children: _videos
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
              ),
            ],
          )),
    );
  }
}
