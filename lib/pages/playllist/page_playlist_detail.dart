import 'package:flutter/material.dart';

class PlaylistDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PlayListDetailState();
}

class _PlayListDetailState extends State<PlaylistDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('歌单'),
        actions: <Widget>[
          IconButton(
            icon: new Icon(
              Icons.search,
              color: Colors.white,
            ),
            tooltip: 'Navigation menu',
            onPressed: null, // null禁用按钮
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
      ),
    );
  }
}
