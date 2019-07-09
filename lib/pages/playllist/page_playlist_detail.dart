import 'package:flutter/material.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';

class PlaylistDetailPage extends StatefulWidget {
  PlaylistDetailPage(
    this.playlistId,
  ) : assert(playlistId != null, 'playlist id，can not be null');
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
      body: PlaylistDetailHeader(
        background: Text('xxxxxxxxxxxxxxxxxxxxxx'),
      ),
    );
  }
}

/// 播放列表头部
class PlaylistDetailHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        background, //背景
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ListItemCustom(
                  img: '',
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '700首流行经典老歌[80/90/00后KTV正藏版]',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '700首流行经典老歌[80/90/00后KTV正藏版]',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              "http://img8.zol.com.cn/bbs/upload/23765/23764201.jpg"),
                          backgroundColor: Colors.black,
                          radius: 10.0,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ListItem(image: "images/album/album_comment.png", text: "156"),
                ListItem(image: "images/album/album_share.png", text: "185"),
                ListItem(image: "images/album/album_download.png", text: "下载"),
                ListItem(
                    image: "images/album/album_multiple_selection.png",
                    text: "多选"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  const PlaylistDetailHeader({Key key, @required this.background})
      : super(key: key);

  final Widget background; //背景
}

class ListItem extends StatelessWidget {
  final String text;
  final String image;

  ListItem({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image,
          color: Colors.black,
          width: 25,
        ),
        Container(
            margin: EdgeInsets.only(top: 5), //上边距
            child: Text(text,
                style: TextStyle(
                  fontSize: 12,
                )))
      ],
    );
  }
}
