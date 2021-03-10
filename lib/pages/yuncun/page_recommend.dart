import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/pages/album/SongLabelPage.dart';
import 'package:cloud_music/pages/playlist/page_category_song_list.dart';
import 'package:cloud_music/pages/yuncun/page_video_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin {
  int limit;
  int offset;

  @override
  void initState() {
    limit = 10;
    offset = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBarContainer = TabBar(
      indicatorSize: TabBarIndicatorSize.label,
      //创建TabBar实例
      isScrollable: true,
      //这个属性是导航栏是否支持滚动，false则会挤在一起了
      unselectedLabelColor: Colors.grey,
      //未选标签标签的颜色(这里定义为灰色)
      labelColor: Colors.red,
      //选中的颜色（黑色）
      indicatorColor: Colors.red,
      //指示器颜色
      indicatorWeight: 2.0,
      //指示器厚度
      tabs: choices.map((Choice choice) {
        //选项卡
        return Tab(
          text: choice.title,
        );
      }).toList(),
    );
    Widget tabContainer = new DefaultTabController(
      length: choices.length,
      initialIndex: 0, //初始索引
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(right: 30),
//                color: Colors.teal.shade700,
                alignment: Alignment.center,
                child: tabBarContainer,
              ),
            ],
          ),
          Gaps.line,
          Expanded(
            child: TabBarView(
              children: choices.map((Choice choice) {
                return VideoListPage(categoryId: choice.categoryId);
              }).toList(),
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      body: tabContainer,
    );
    return super.build(context);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class Choice {
  const Choice({this.title, this.categoryId});

  final String title; //这个参数是分类名称
  final int categoryId; //这个适用于网络请求的参数，获取不同分类列表
}

const List<Choice> choices = const <Choice>[
  const Choice(
    title: '现场 ',
    categoryId: 58100,
  ),
  const Choice(
    title: '翻唱',
    categoryId: 60100,
  ),
  const Choice(
    title: '舞蹈',
    categoryId: 1101,
  ),
  const Choice(
    title: '听BGM',
    categoryId: 58101,
  ),
  const Choice(
    title: 'MV',
    categoryId: 1,
  ),
  const Choice(
    title: '轻音乐',
    categoryId: 1000,
  ),
  const Choice(
    title: '生活',
    categoryId: 2100,
  ),
  const Choice(
    title: '游戏',
    categoryId: 2103,
  ),
  const Choice(
    title: 'ACG音乐',
    categoryId: 57104,
  ),
  const Choice(
    title: '最佳饭制',
    categoryId: 1105,
  ),
];
