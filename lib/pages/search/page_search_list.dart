import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/pages/search/page_search_single_song.dart';
import 'package:cloud_music/pages/search/page_search_song_list.dart';
import 'package:cloud_music/pages/search/page_search_video_list.dart';
import 'package:cloud_music/pages/yuncun/page_video_list.dart';
import 'package:cloud_music/widget/CustomUnderlineTabIndicator.dart';
import 'package:flutter/material.dart';

import '../../r.dart';

class SearchListPage extends StatefulWidget {
  SearchListPageState createState() => SearchListPageState();
}

class SearchListPageState extends State<SearchListPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4, initialIndex: 1)
      ..addListener(() {
        print('_tabControllerIndex' + _tabController.index.toString());
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    Widget tabBarContainer = TabBar(
      indicator: CustomUnderlineTabIndicator(
          insets: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 15),
          borderSide: BorderSide(
            width: 5,
            color: Color(0xff00cdd7),
          )),
      indicatorSize: TabBarIndicatorSize.label,
      //创建TabBar实例
      isScrollable: true,
      //这个属性是导航栏是否支持滚动，false则会挤在一起了
      unselectedLabelColor: Colors.grey,
      //未选标签标签的颜色(这里定义为灰色)
      labelColor: Colors.black,
      //选中的颜色（黑色）
      indicatorColor: Colors.black,
      //指示器颜色
      indicatorWeight: 2.0,
      labelStyle: R.style.textBoldDark14,
      unselectedLabelStyle: R.style.textGray14,
      //指示器厚度
      tabs: choices.map((Choice choice) {
        //选项卡
        return Tab(
          text: choice.title,
        );
      }).toList(),
    );
    Widget tabContainer = DefaultTabController(
      length: choices.length,
      initialIndex: 0, //初始索引
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
                // padding: EdgeInsets.only(right: 30),
//                color: Colors.teal.shade700,
                alignment: Alignment.center,
                child: tabBarContainer,
              ),
            ],
          ),
          Gaps.line,
          Expanded(
            child: TabBarView(
              children: [
                SearchSingleSongPage(),
                SearchSongListPage(),
                SearchSongListPage(),
                SearchVideoListPage(),
                SearchSingleSongPage(),
                SearchSingleSongPage(),
                SearchSingleSongPage(),
                SearchSingleSongPage(),
                SearchSingleSongPage(),
                SearchSingleSongPage(),
                SearchSingleSongPage(),
              ],
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: tabContainer,
    );
    return super.build(context);
  }
}

class Choice {
  const Choice({this.title, this.categoryId});

  final String title; //这个参数是分类名称
  final int categoryId; //这个适用于网络请求的参数，获取不同分类列表
}

const List<Choice> choices = const <Choice>[
  const Choice(
    title: '综合 ',
    categoryId: 58100,
  ),
  const Choice(
    title: '单曲',
    categoryId: 60100,
  ),
  const Choice(
    title: '歌单',
    categoryId: 1101,
  ),
  const Choice(
    title: '视频',
    categoryId: 58101,
  ),
  const Choice(
    title: '声音',
    categoryId: 1,
  ),
  const Choice(
    title: '播单',
    categoryId: 1000,
  ),
  const Choice(
    title: '生活',
    categoryId: 2100,
  ),
  const Choice(
    title: '云圈',
    categoryId: 2103,
  ),
  const Choice(
    title: '歌手',
    categoryId: 57104,
  ),
  const Choice(
    title: '专辑',
    categoryId: 1105,
  ),
  const Choice(
    title: '用户',
    categoryId: 1105,
  ),
];
