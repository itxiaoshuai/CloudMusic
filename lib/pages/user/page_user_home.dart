import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/base/ConstImg.dart';
import 'package:flutter_app/base/utils/utils.dart';
import 'package:flutter_app/data/protocol/playlist_detail.dart';
import 'package:flutter_app/model/play_list_model.dart';
import 'package:flutter_app/pages/main/page_main.dart';
import 'package:flutter_app/pages/playllist/item_music_list_track.dart';
import 'package:flutter_app/provider/layout_state.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/provider/view_state_widget.dart';
import 'package:flutter_app/route/routes.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';
import 'package:flutter_app/widget/flexible_app_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class PageUserHome extends StatefulWidget {
  PageUserHome(
    this.playlistId,
  ) : assert(playlistId != null, 'playlist id，can not be null');
  final int playlistId;

  State<StatefulWidget> createState() => PageUserHomeState();
}

class PageUserHomeState extends State<PageUserHome> {
  PlaylistDetail playlist;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ProviderWidget<PlayListModel>(
        model: PlayListModel(),
        onModelReady: (model) {
          model.loadData(widget.playlistId);
        },
        builder: (context, model, child) {
          debugPrint('---当前状态--> ${model}');
          switch (model.layoutState) {
            case LayoutState.IDLE:
              break;
            case LayoutState.LOADING:
              return ViewStateLoadingWidget();
              break;
          }
          return NestedScrollDemoPage();
//          return CustomWidget(model, widget.playlistId);
        },
      ),
    );
  }
}

class NestedScrollDemoPage extends StatelessWidget {
  final _tabs = <String>['TabA', 'TabB'];
  final colors = <Color>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.yellow,
    Colors.deepPurple
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: _tabs.length,
          child: NestedScrollView(
              headerSliverBuilder: (context, innerScrolled) => <Widget>[
                    SliverOverlapAbsorber(
                      // 传入 handle 值，直接通过 `sliverOverlapAbsorberHandleFor` 获取即可
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
//                  child: SliverAppBar(
//                    pinned: true,
//                    title: Text('NestedScroll Demo'),
//                    expandedHeight: 200.0,
//                    flexibleSpace: FlexibleSpaceBar(background: Image.asset('images/timg.jpg', fit: BoxFit.cover)),
//                    bottom: TabBar(tabs: _tabs.map((tab) => Text(tab, style: TextStyle(fontSize: 18.0))).toList()),
//                    forceElevated: innerScrolled,
//                  ),
                    )
                  ],
              body: TabBarView(
                  children: _tabs
                      // 这边需要通过 Builder 来创建 TabBarView 的内容，否则会报错
                      // NestedScrollView.sliverOverlapAbsorberHandleFor must be called with a context that contains a NestedScrollView.
                      .map((tab) => Builder(
                            builder: (context) => CustomScrollView(
                              // key 保证唯一性
                              key: PageStorageKey<String>(tab),
                              slivers: <Widget>[
                                // 将子部件同 `SliverAppBar` 重叠部分顶出来，否则会被遮挡
                                SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context)),
                                SliverGrid(
                                    delegate: SliverChildBuilderDelegate(
                                        (_, index) =>
                                            Image.asset('images/ali.jpg'),
                                        childCount: 8),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            mainAxisSpacing: 10.0,
                                            crossAxisSpacing: 10.0)),
                                SliverFixedExtentList(
                                    delegate: SliverChildBuilderDelegate(
                                        (_, index) => Container(
                                            child: Text(
                                                '$tab - item${index + 1}',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: colors[index % 6])),
                                            alignment: Alignment.center),
                                        childCount: 15),
                                    itemExtent: 50.0)
                              ],
                            ),
                          ))
                      .toList()))),
    );
  }
}

class UserTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => UserTabPageState();
}

class UserTabPageState extends State<PageUserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
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

/// 播放列表头部
class _PlaylistDetailHeader extends StatelessWidget {
  _PlaylistDetailHeader(this.model, this.id);

  PlayListModel model;
  int id;

  @override
  Widget build(BuildContext context) {
    return FlexibleDetailBar(
//      background: PlayListHeaderBackground(imageUrl: 'https://p1.music.126.net/owwmF9E88Rc_Gjf-XSUU5Q==/109951164132178640.jpg'),
      content: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Text(''),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 0, bottom: 4, right: 15),
        color: Colors.blue,
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(RouteName.USER_HOME);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 56,
                  height: 56,
                  child: Image.network(
                      'https://p4.music.126.net/S8_sVVdNkr84Jcb-CFcjYQ==/109951165150069282.jpg'),
                ),
              ),
            ),
            Text('情深深你大爷'),
            Row(
              children: [
                Text('关注4'),
                Text('粉丝0'),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Text(
                    "Lv.5",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[400], // 底色
                    shape: BoxShape.rectangle, // 默认值也是矩形
                    borderRadius: BorderRadius.circular((20.0)), // 圆角度
                  ),
                ),
                Spacer(),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Text(
                    "+关注",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.rectangle, // 默认值也是矩形
                    borderRadius: BorderRadius.circular((20.0)), // 圆角度
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Text(
                    "发私信",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.rectangle, // 默认值也是矩形
                    borderRadius: BorderRadius.circular((20.0)), // 圆角度
                  ),
                ),
              ],
            ),
          ],
        ),
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

///音乐列表头
class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, top: 0, bottom: 4, right: 15),
      color: Colors.blue,
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(RouteName.USER_HOME);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 56,
                height: 56,
                child: Image.network(
                    'https://p4.music.126.net/S8_sVVdNkr84Jcb-CFcjYQ==/109951165150069282.jpg'),
              ),
            ),
          ),
          Text('情深深你大爷'),
          Row(
            children: [
              Text('关注4'),
              Text('粉丝0'),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                child: Text(
                  "Lv.5",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[400], // 底色
                  shape: BoxShape.rectangle, // 默认值也是矩形
                  borderRadius: BorderRadius.circular((20.0)), // 圆角度
                ),
              ),
              Spacer(),
              Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                child: Text(
                  "+关注",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.rectangle, // 默认值也是矩形
                  borderRadius: BorderRadius.circular((20.0)), // 圆角度
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                child: Text(
                  "发私信",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.rectangle, // 默认值也是矩形
                  borderRadius: BorderRadius.circular((20.0)), // 圆角度
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class CustomWidget extends StatelessWidget {
  CustomWidget(this.model, this.id);

  PlayListModel model;
  int id;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
            title: Text(model.data.name),
            elevation: 0,
            pinned: true,
            expandedHeight: 320.0,
            bottom: _buildListHeader(context),
            flexibleSpace: _PlaylistDetailHeader(model, id),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                onPressed: () {
                  /* ... */
                },
              )
            ]),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Text('xxxxxx'),
              Scaffold(
                appBar: AppBar(),
              ),
              MainPage(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListHeader(BuildContext context) {
    return MusicListHeader();
  }
}
