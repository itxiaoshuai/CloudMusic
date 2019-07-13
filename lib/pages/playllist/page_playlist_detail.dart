import 'package:flutter/material.dart';
import 'package:flutter_app/data/api/apis.dart';
import 'package:flutter_app/data/net/Http.dart';
import 'package:flutter_app/data/protocol/LeaderboardDetailModel.dart';
import 'package:flutter_app/data/protocol/playlist_detail.dart';
import 'package:flutter_app/data/repository/music_repository.dart';
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
  PlaylistDetail playlist;

  @override
  void initState() {
//    var playlistDetail = MusicRepository.playlistDetail(widget.playlistId);
////    if (playlistDetail != null) {
////      setState(() {
////        playlist = playlistDetail as PlaylistDetail;
////        print('response====$playlistDetail');
////
////      });
////    }
//    getSongListDetail(widget.playlistId);
    super.initState();
  }

  Future getSongListDetail(int id) async {
    var response = await Http().get(
      MusicApi.SONGLISTDETAILS,
      queryParameters: {"id": id},
    );
    PlaylistDetail playlist = PlaylistDetail.fromJson(response["playlist"]);
    if (playlist != null) {
      setState(() {
        this.playlist = playlist;
      });
    }
  }

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
        body: Container(
          color: Colors.orange,
          child: _PlaylistDetailHeader(playlist),
        ));
  }
}

class PlaylistBody extends StatefulWidget {
  @override
  _PlaylistBodyState createState() => _PlaylistBodyState();
}

class _PlaylistBodyState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

/// 播放列表头部
class _PlaylistDetailHeader extends StatelessWidget {
  _PlaylistDetailHeader(
    this.playlistDetail,
  );

  final PlaylistDetail playlistDetail;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 4, right: 15),
      color: Colors.redAccent,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ListItemCustom(
                width: 124,
                height: 124,
                img: playlistDetail == null ? "" : playlistDetail.coverImgUrl,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      playlistDetail == null ? "" : playlistDetail.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 0, top: 4, bottom: 4, right: 0),
                      child: InkWell(
                        onTap: () => {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 0, top: 6, bottom: 6, right: 0),
//                            color: Colors.blue,
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      playlistDetail.creator.avatarUrl),
                                  backgroundColor: Colors.black,
                                  radius: 15.0,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(left: 6)),
                              Text(
                                playlistDetail == null
                                    ? ""
                                    : playlistDetail.creator.nickname,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Theme.of(context).primaryIconTheme.color,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ListItem(
                  image: "images/album/album_comment.png",
                  text: playlistDetail == null
                      ? ""
                      : playlistDetail.commentCount.toString(),
                ),
                ListItem(
                  image: "images/album/album_share.png",
                  text: playlistDetail == null
                      ? ""
                      : playlistDetail.shareCount.toString(),
                ),
                ListItem(image: "images/album/album_download.png", text: "下载"),
                ListItem(
                    image: "images/album/album_multiple_selection.png",
                    text: "多选"),
              ],
            ),
          ),
        ],
      ),
    );
  }
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

///歌单列表头部
class MusicListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
