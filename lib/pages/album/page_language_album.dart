import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/pages/yuncun/page_video_list.dart';
import 'package:flutter/material.dart';

class LanguageAlbumPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LanguageAlbumPageState();
}

class _LanguageAlbumPageState extends State<LanguageAlbumPage> {
  @override
  Widget build(BuildContext context) {
    Widget tabBarContainer = TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
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
    Widget tabContainer = DefaultTabController(
      length: choices.length,
      initialIndex: 0, //初始索引
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Container(
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
                return Center(child: Text(choice.title),);
              }).toList(),
            ),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('语种风格馆'),
      ),
      body: tabContainer,
    );
  }
}

class Choice {
  const Choice({this.title, this.area});

  final String title; //这个参数是分类名称
  final String area; //这个适用于网络请求的参数，获取不同分类列表
}

const List<Choice> choices = const <Choice>[
  const Choice(
    title: '华语',
    area: 'Z_H',
  ),
  const Choice(
    title: '欧美',
    area: 'E_A',
  ),
  const Choice(
    title: '韩国',
    area: 'KR',
  ),
  const Choice(
    title: '日本',
    area: 'JP',
  ),
];
