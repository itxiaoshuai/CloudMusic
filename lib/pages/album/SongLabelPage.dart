import 'package:flutter/material.dart';
import 'package:cloud_music/base/res/colors.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/net/huyi_android_api.dart';
import 'package:cloud_music/pages/video/VideoList.dart';

import 'SongLabelDetailPage.dart';

class SongLabelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SongLabelPageState();
}

class _SongLabelPageState extends State<SongLabelPage> {
  @override
  void initState() {
    initData();
    super.initState();
  }

  Widget getItemContainer(Sub sub) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        alignment: Alignment.center,
        color: Colors.grey[200],
        child: Text(
          sub.name,
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget getLabelListWidget(List list) {
      return Container(
        margin: EdgeInsets.only(top: 15, bottom: 30),
        child: GridView.builder(
          shrinkWrap: true,
          // 添加
          physics: NeverScrollableScrollPhysics(),
          // 添加
          itemCount: list.length ?? 0,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 横轴元素个数
            mainAxisSpacing: 10.0, // 纵轴间距
            crossAxisSpacing: 10.0, // 横轴间距
            childAspectRatio: 2.2, // 子组件宽高长度比例
          ),
          itemBuilder: (BuildContext context, int index) {
            Sub sub = list[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                      return SongLabelDetailPage(cat: sub.name,);
                    }));
              },
              child: getItemContainer(sub),
            );
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('歌单标签'),
      ),
      body: ListView(
        shrinkWrap: true, // 添加
        padding: EdgeInsets.all(0),
        children: labelList.map((e) {
          return Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(e.title),
                getLabelListWidget(e.list),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Future<void> initData() async {
    var response = await http.get(
      '/playlist/catlist',
    );

    List sub = response.data['sub'];
    labelList.map((e) {
      e.list.clear();
    }).toList();
    sub.map((e) {
      int category = e['category'];
      Sub sub = Sub.fromJson(e);
      labelList[category].list.add(sub);
    }).toList();

    setState(() {});
  }
}

class Label {
  Label({
    this.title,
    this.category,
    this.list,
  });

  String title; //这个参数是分类名称
  int category; //这个适用于网络请求的参数，获取不同分类列表
  List list;
}

List<Label> labelList = <Label>[
  Label(
    title: '语种',
    category: 0,
    list: [],
  ),
  Label(
    title: '风格',
    category: 1,
    list: [],
  ),
  Label(
    title: '场景',
    category: 2,
    list: [],
  ),
  Label(
    title: '情感',
    category: 3,
    list: [],
  ),
  Label(
    title: '主题',
    category: 4,
    list: [],
  ),
];

class Sub {
  bool hot;
  int category;
  String name;

  static Sub fromJson(Map<String, dynamic> map) {
    if (map == null) return null;
    Sub sub = Sub();
    sub.hot = map['hot'];
    sub.category = map['category'];
    sub.name = map['name'];
    return sub;
  }
}
