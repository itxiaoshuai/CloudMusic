import 'package:flutter/material.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
import 'package:flutter_app/pages/video/VideoList.dart';

class VideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List _videoCategoryList = [];
  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    var response = await http.get(
      '/video/group/list',
    );
    print(response.data);
    List rows = response.data['data'];
    _videoCategoryList = rows;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _videoCategoryList.length,
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
                  tabs: _videoCategoryList.map((p) {
                    //选项卡
                    return Tab(
                      text: p['name'],
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: _videoCategoryList.map((p) {
            return VideoList(id: p['id']); //一个属于展示内容的listview
          }).toList(),
        ),
      ),
    );
  }
}

class Video {
  const Video({this.title, this.categoryId});

  final String title; //这个参数是分类名称
  final int categoryId; //这个适用于网络请求的参数，获取不同分类列表
}
