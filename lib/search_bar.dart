import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final String appName;
  final Function searchVideo;
  SearchBar({this.appName, this.searchVideo});

  //final Function searchVideo;

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchBarState extends State<SearchBar> {
  Icon searchIcon = Icon(Icons.search);
  Widget appBarTitle;
  @override
  void initState() {
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: this.appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: searchIcon,
          tooltip: 'search video',
          onPressed: () {
            setState(() {
              if (this.searchIcon.icon == Icons.search) {
                this.searchIcon = Icon(Icons.close);
                this.appBarTitle = TextField(
                  onSubmitted: (text){
                    widget.searchVideo(text);
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: 'Enter Youtube URL...',
                      hintStyle: TextStyle(color: Colors.white)),
                );
              } else {
                this.searchIcon = Icon(Icons.search);
                this.appBarTitle = Text(widget.appName);
              }
            });
          },
        )
      ],
    );
  }
}
