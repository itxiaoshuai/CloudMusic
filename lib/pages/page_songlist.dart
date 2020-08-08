import 'package:flutter/material.dart';
import 'package:flutter_app/base/res/gaps.dart';
import 'package:flutter_app/pages/playllist/background_blur.dart';
import 'package:flutter_app/pages/playllist/item_music_list_track.dart';
import 'package:flutter_app/pages/playllist/page_category_song_list.dart';

import 'album/SongLabelPage.dart';

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
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                child: InkWell(
                  child: Image.asset(
                    'images/icon_label_song1.png',
                    color: Colors.grey,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SongLabelPage();
                    }));
                  },
                ),
              ),
            ],
          ),
          Gaps.line,
          Expanded(
            child: TabBarView(
              children: choices.map((Choice choice) {
                return PlaylistCategoryPage(cat: choice.title);
                ; //一个属于展示内容的listview
              }).toList(),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
//      backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
      appBar: AppBar(
        centerTitle: false,
        titleSpacing: 0,
        automaticallyImplyLeading: true,
        title: Text('歌单广场'),
      ),
//      TabBar(
//        indicatorSize: TabBarIndicatorSize.tab,
//        isScrollable: true,
//        tabs: choices.map((Choice choice) {
//          //选项卡
//          return new Tab(
//            text: choice.title,
//          );
//        }).toList(),
//        controller: _tabController,
//      )
//      TabBarView(
//        controller: _tabController,
//        children: choices.map((Choice choice) {
//          return PlaylistCategoryPage(cat: choice.title); //一个属于展示内容的listview
//        }).toList(),
//      )
      body: tabContainer,
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
    title: '官方',
    categoryId: 2,
  ),
  const Choice(
    title: '精品',
    categoryId: 3,
  ),
  const Choice(
    title: '华语',
    categoryId: 4,
  ),
  const Choice(
    title: '流行',
    categoryId: 5,
  ),
  const Choice(
    title: '轻音乐',
    categoryId: 6,
  ),
  const Choice(
    title: '摇滚',
    categoryId: 7,
  ),
  const Choice(
    title: '民谣',
  ),
];
