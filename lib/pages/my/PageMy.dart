import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/base/ConstImg.dart';
import 'package:flutter_app/base/utils/utils.dart';
import 'package:flutter_app/data/protocol/playlist_detail.dart';
import 'package:flutter_app/model/play_list_model.dart';
import 'package:flutter_app/pages/find/FutureBuilderPage.dart';
import 'package:flutter_app/pages/leaderboard/LeaderboardPage.dart';
import 'package:flutter_app/pages/playllist/item_music_list_track.dart';
import 'package:flutter_app/pages/radio/page_radio.dart';
import 'package:flutter_app/pages/user/page_user_detail.dart';
import 'package:flutter_app/provider/layout_state.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/provider/view_state_widget.dart';
import 'package:flutter_app/route/routes.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';
import 'package:flutter_app/widget/flexible_app_bar.dart';

import '../page_songlist.dart';

class MyPage extends StatefulWidget {
  MyPage(
    this.playlistId,
  ) : assert(playlistId != null, 'playlist id，can not be null');
  final int playlistId;

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  PlaylistDetail playlist;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, //把appbar的背景色改成透明
      body: CustomScrollView(
        slivers: <Widget>[
//          SliverAppBar(
//            backgroundColor: Colors.transparent, //把appbar的背景色改成透明
//            pinned: true,
//            elevation: 0,
//            expandedHeight: 250,
//            flexibleSpace: FlexibleSpaceBar(
////              title: Text('Sliver-sticky效果'),
////              background: Image.network(
////                'http://img1.mukewang.com/5c18cf540001ac8206000338.jpg',
////                fit: BoxFit.cover,
////              ),
//                ),
//          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyTabBarDelegate(
              child: TabBar(
                labelColor: Colors.black,
                controller: this.tabController,
                tabs: <Widget>[
                  Tab(text: 'Home'),
                  Tab(text: 'Profile'),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: this.tabController,
              children: <Widget>[
                ListView(
                  children: [
                    Column(
                      children: [
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                        Center(child: Text('Content of Home')),
                        Center(child: Text('Content of Profile')),
                      ],
                    ),
                  ],
                ),
                Center(child: Text('Content of Home')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
          color: Colors.yellow,
        ),
      ),
    );
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

///播放列表头部背景
class PlayListHeaderBackground extends StatelessWidget {
  final String imageUrl;

  const PlayListHeaderBackground({Key key, @required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(color: Colors.black.withOpacity(0.1)),
        )
      ],
    );
  }
}

_buildMenu(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 15, bottom: 15),
//            color: Colors.green,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
        children: [
          InkWell(
            child: VerticalItem(
                image: "images/find/t_dragonball_icn_daily.png", text: "每日推荐"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return NestedScrollDemoPage();
              }));
            },
          ),
          InkWell(
            child: VerticalItem(
                image: "images/find/t_dragonball_icn_playlist.png", text: "歌单"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return SongListPage();
              }));
            },
          ),
          InkWell(
            child: VerticalItem(
                image: "images/find/t_dragonball_icn_rank.png", text: "排行榜"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return LeaderBoardPage();
              }));
            },
          ),
          InkWell(
            child: VerticalItem(
                image: "images/find/t_dragonball_icn_radio.png", text: "电台"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return RadioPage();
              }));
            },
          ),
          InkWell(
            child: VerticalItem(
                image: "images/find/t_dragonball_icn_look.png", text: "直播"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return UserDetailPage();
              }));
            },
          ),
        ]),
  );
}

Widget _getContainer(String test, String textSecond, IconData icon) {
  return Container(
    color: Colors.blue,

//      ListTile
    child: ListTile(
//       显示在title之前
      leading: Icon(icon),

      title: Container(
        color: Colors.yellowAccent,
        alignment: Alignment.bottomLeft,
        child: Row(
          children: <Widget>[
            Container(
              color: Colors.red,
              alignment: Alignment.bottomLeft,
              child: Text(test),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              alignment: Alignment.bottomLeft,
              child: Text(textSecond, style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    ),
  );
}

class HorizontalItem extends StatelessWidget {
  final String text;

  HorizontalItem({this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                //圆形渐变
                color: Colors.white,
                shape: BoxShape.circle,
                gradient: const LinearGradient(colors: [
                  Colors.redAccent,
                  Colors.red,
                ]),
              ),
            ),
            Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

class VerticalItem extends StatelessWidget {
  final String text;
  final String image;

  VerticalItem({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image,
          color: Colors.black,
          width: 20,
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
