import 'package:flutter/material.dart';
import 'package:flutter_app/pages/playllist/background_blur.dart';
import 'package:flutter_app/pages/playllist/item_music_list_track.dart';
import 'package:flutter_app/pages/playllist/page_category_song_list.dart';

class SongListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SongListPageState();
}

class SongListPageState extends State<SongListPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: choices.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          tabs: choices.map((Choice choice) {
            //选项卡
            return new Tab(
              text: choice.title,
            );
          }).toList(),
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: choices.map((Choice choice) {
          return PlaylistCategoryPage(cat: choice.title); //一个属于展示内容的listview
        }).toList(),
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.categoryId});

  final String title; //这个参数是分类名称
  final int categoryId; //这个适用于网络请求的参数，获取不同分类列表
}

const List<Choice> choices = const <Choice>[
  const Choice(
    title: '推荐 ',
    categoryId: 1,
  ),
  const Choice(
    title: '精品',
    categoryId: 2,
  ),
  const Choice(
    title: '华语',
    categoryId: 3,
  ),
  const Choice(
    title: '流行',
    categoryId: 4,
  ),
  const Choice(
    title: '电子',
    categoryId: 5,
  ),
  const Choice(
    title: '诗歌散文',
    categoryId: 6,
  ),
  const Choice(
    title: '古风',
    categoryId: 7,
  ),
  const Choice(
    title: '摇滚',
  ),
];
