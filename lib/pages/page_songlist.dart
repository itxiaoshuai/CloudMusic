import 'package:flutter/material.dart';
import 'package:flutter_app/pages/playllist/background_blur.dart';
import 'package:flutter_app/pages/playllist/item_music_list_track.dart';

class SongListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomWidget();
    return BackgroundBlur(
      child: Scaffold(backgroundColor: Colors.transparent, body: Text('xx')),
      coverPic:
          'http://p2.music.126.net/2XWY_6zJ9vAsnXIRCYQeiw==/109951164208685267.jpg',
    );
  }
}

class CustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            backgroundColor: Colors.blue,
            title: Text('歌单'),
            elevation: 0,
            pinned: true,
            floating: false,
            snap: false,
            expandedHeight: 240.0,
            bottom: _buildListHeader(context),
//            flexibleSpace: _PlaylistDetailHeader(widget.playlist),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.more),
                tooltip: 'Add new entry',
                onPressed: () {
                  /* ... */
                },
              ),
              IconButton(
                icon: const Icon(Icons.add_circle),
                tooltip: 'Add new entry',
                onPressed: () {
                  /* ... */
                },
              ),
            ]),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            //创建列表项
            return Material(
              child: new InkWell(
                onTap: () {
                  print(
                      '###########################点击了##################################');
                },
                child: new Container(
                  height: 60,
                  //不要在这里设置背景色，否则会遮挡水波纹效果,如果设置的话尽量设置Material下面的color来实现背景色
                  margin: EdgeInsets.all(0.0),
                  child: TrackItem(index: index + 1),
                ),
              ),
              color: Colors.white,
            );
          }, childCount: 50 //50个列表项
                  ),
        ),
      ],
    );
  }

  Widget _buildListHeader(BuildContext context) {
    return MusicListHeader();
  }
}

///音乐列表头
class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Material(
        color: Colors.white,
        elevation: 0,
        child: InkWell(
          child: SizedBox.fromSize(
            size: preferredSize,
            child: Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 16)),
                Icon(
                  Icons.play_circle_outline,
                  color: Theme.of(context).iconTheme.color,
                ),
                Padding(padding: EdgeInsets.only(left: 4)),
                Text(
                  "播放全部",
                  style: Theme.of(context).textTheme.body1,
                ),
                Padding(padding: EdgeInsets.only(left: 2)),
                Text(
                  "(共首)",
                  style: Theme.of(context).textTheme.caption,
                ),
                Spacer(),
              ]..removeWhere((v) => v == null),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
