import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget implements PreferredSizeWidget {
  final String appName;
  final Function searchVideo;
  SearchBar({String this.appName,Function this.searchVideo});

  //final Function searchVideo;

  @override
  State<StatefulWidget> createState() {
    return _SearchBarState();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchBarState extends State<SearchBar> {
  Icon searchIcon = Icon(Icons.search);
  Widget appBarTitle;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: appBarTitle=Text(widget.appName),
      actions: <Widget>[
        IconButton(
          icon: searchIcon,
          tooltip: 'search video',
          onPressed: () {
            setState(() {
              if (this.searchIcon.icon == Icons.search) {
                this.searchIcon = Icon(Icons.close);
                this.appBarTitle = TextField(
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

class $appName {
}
