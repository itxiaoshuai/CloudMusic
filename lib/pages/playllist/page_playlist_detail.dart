import 'package:flutter/material.dart';

class PlaylistDetailPage extends StatefulWidget {
  PlaylistDetailPage(this.playlistId, )
      : assert(playlistId != null,'playlist id，can not be null');
  final int playlistId;

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

/// 播放列表头部
class PlaylistDetailHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        background, //背景
      ],
    );
  }

  const PlaylistDetailHeader({Key key, @required this.background})
      : super(key: key);

  final Widget background; //背景
}
