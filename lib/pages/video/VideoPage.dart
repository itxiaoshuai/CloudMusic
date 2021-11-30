import 'package:flutter/material.dart';
import 'package:cloud_music/pages/video/VideoList.dart';

class VideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: videoCategoryList.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Expanded(
                child: TabBar(
                  isScrollable: true, //如果多个按钮可以滑动
//                  indicatorColor: Colors.yellow, //指示器颜色
                  labelColor: Theme.of(context).accentColor, //指示器文字颜色
                  unselectedLabelColor: Colors.black, //未选中的指示器文字颜色
                  indicatorSize: TabBarIndicatorSize.label, //指示器长度
                  tabs: videoCategoryList.map((Video video) {
                    //选项卡
                    return Tab(
                      text: video.title,
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: videoCategoryList.map((Video choice) {
            return VideoList(id: choice.categoryId); //一个属于展示内容的listview
          }).toList(),
        ),
      ),
    );
  }
}

class Video {
   const Video({required this.title, required this.categoryId});

   final String title; //这个参数是分类名称
   final int categoryId; //这个适用于网络请求的参数，获取不同分类列表
}

const List<Video> videoCategoryList = const <Video>[
  const Video(
    title: '推荐 ',
    categoryId: 1,
  ),
  const Video(
    title: 'LOOK直播',
    categoryId: 2,
  ),
  const Video(
    title: '乐堡开躁',
    categoryId: 3,
  ),
  const Video(
    title: '现场',
    categoryId: 4,
  ),
  const Video(
    title: '翻唱',
    categoryId: 5,
  ),
  const Video(
    title: '舞蹈',
    categoryId: 6,
  ),
  const Video(
    title: '听BGM',
    categoryId: 7,
  ),
  const Video(
    title: '官方',
    categoryId: 8,
  ),
  const Video(
    title: '榜单来了',
    categoryId: 9,
  ),
  const Video(
    title: '广场',
    categoryId: 10,
  ),
  const Video(
    title: 'MV',
    categoryId: 11,
  ),
  const Video(
    title: '生活',
    categoryId: 12,
  ),
  const Video(
    title: '游戏',
    categoryId: 13,
  ),
  const Video(
    title: 'ACG音乐',
    categoryId: 14,
  ),
  const Video(
    title: '最佳饭制',
    categoryId: 14,
  ),
];
