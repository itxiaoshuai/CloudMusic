import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app/data/protocol/LeaderboardModel.dart';
import 'package:flutter_app/model/top_list_model.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
import 'package:flutter_app/pages/playllist/page_playlist_detail.dart';
import 'package:flutter_app/provider/provider_widget.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';
import 'package:provider/provider.dart';

import 'LeaderboardDetailPage.dart';

class LeaderBoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State {
  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
//    Response response;
//    Dio dio = Dio();
//    response =
//        dio.get('http://interface3.music.163.com/eapi/search/localsong/upload')
//            as Response;
//
//    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
//    Stream<void> stream = response.asStream();
//    print(stream);
//
//    print(response.asStream());
    Response response;
    Dio dio = new Dio();
    await dio
        .get(
          "http://interface3.music.163.com/eapi/search/localsong/upload",
        )
        .asStream()
        .listen((data) {
      print(data.headers);
      print(data.redirects);
    }, onError: (error) {
      print("流发生错误");
    }, onDone: () {
      print("流已完成");
    }, cancelOnError: false);
  }

  Future<String> getData() async {
    await Future.delayed(Duration(seconds: 3));
    return '当前时间为：${DateTime.now()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('排行榜'),
      ),
      body: ProviderWidget<TopListModel>(
          model: TopListModel(),
          onModelReady: (model) {
            model.initData();
          },
          builder: (context, model, child) {
            debugPrint('---当前状态--> ${model}');
            return CustomScrollView(
              slivers: _listWidget(context, model),
            );
          }),
    );
  }

  _listWidget(BuildContext context, TopListModel model) {
    List<Widget> widget;
    if (model.list.length > 0) {
      widget = <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                child: Text(
                  '官方榜',
                  style: TextStyle(fontSize: 16),
                ),
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 10),
              ),
            ],
          ),
        ),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            LeaderBoardList item = model.list[index];
            return Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PlaylistDetailPage(model.list[index].id);
                  }));
                },
                child: ListItem(
                  img: item.coverImgUrl,
                  updateFrequency: item.updateFrequency,
                  id: item.id,
                  tracks: item.tracks,
                ),
              ),
            );
          }, childCount: 4 //50个列表项
                  ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                child: Text(
                  '推荐榜',
                  style: TextStyle(fontSize: 16),
                ),
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 10),
              ),
            ],
          ),
        ),
        _buildRecommend(context, model),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                child: Text(
                  '全球榜',
                  style: TextStyle(fontSize: 16),
                ),
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 10),
              ),
            ],
          ),
        ),
        _buildGlobalList(context, model),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                child: Text(
                  '更多榜单',
                  style: TextStyle(fontSize: 16),
                ),
                margin: EdgeInsets.only(left: 15, top: 15, bottom: 10),
              ),
            ],
          ),
        ),
        _buildMoreList(context, model),
        SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              Container(
                margin: EdgeInsets.only(top: 50, bottom: 10),
              ),
            ],
          ),
        ),
      ];
    } else {
      widget = <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              height: 1,
              color: Colors.redAccent,
            ),
          ]),
        )
      ];
    }

    return widget;
  }

  _buildRecommend(BuildContext context, TopListModel model) {
    Widget widget;
    if (model.list.length > 12) {
      List list = model.list.sublist(6, 12);
      widget = SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //Grid按两列显示
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              LeaderBoardList item = list[index];
              return Container(
                child: ListItemCustom(
                  img: item.coverImgUrl,
                  updateFrequency: item.updateFrequency,
                ),
              );
            },
            childCount: list.length,
          ),
        ),
      );
    } else {
      List list = model.list.sublist(6, model.list.length);
      widget = SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //Grid按两列显示
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              LeaderBoardList item = list[index];
              return Container(
                child: ListItemCustom(
                  img: item.coverImgUrl,
                  updateFrequency: item.updateFrequency,
                ),
              );
            },
            childCount: list.length,
          ),
        ),
      );
    }

    return widget;
  }

  _buildGlobalList(BuildContext context, TopListModel model) {
    Widget widget;
    if (model.list.length > 18) {
      List list = model.list.sublist(12, 18);
      widget = SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //Grid按两列显示
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              LeaderBoardList item = list[index];
              return Container(
                child: ListItemCustom(
                  img: item.coverImgUrl,
                  updateFrequency: item.updateFrequency,
                ),
              );
            },
            childCount: list.length,
          ),
        ),
      );
    } else {
      List list = model.list.sublist(12, model.list.length);
      widget = SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //Grid按两列显示
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              LeaderBoardList item = list[index];
              return Container(
                child: ListItemCustom(
                  img: item.coverImgUrl,
                  updateFrequency: item.updateFrequency,
                ),
              );
            },
            childCount: list.length,
          ),
        ),
      );
    }

    return widget;
  }

  _buildMoreList(BuildContext context, TopListModel model) {
    Widget widget;
    if (model.list.length > 18) {
      List list = model.list.sublist(18, model.list.length);
      widget = SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //Grid按两列显示
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              LeaderBoardList item = list[index];
              return Container(
                child: ListItemCustom(
                  img: item.coverImgUrl,
                  updateFrequency: item.updateFrequency,
                ),
              );
            },
            childCount: list.length,
          ),
        ),
      );
    }

    return widget;
  }
}

class ListItem extends StatefulWidget {
  final String text;
  final String img;
  final String updateFrequency;
  final int id;
  final List<Track> tracks;

  ListItem({this.text, this.img, this.updateFrequency, this.id, this.tracks});

  @override
  _ListItemState createState() => _ListItemState(
      text: text,
      img: img,
      updateFrequency: updateFrequency,
      id: id,
      tracks: tracks);
}

class _ListItemState extends State<ListItem> {
  final String text;
  final String img;
  final String updateFrequency;
  final int id;
  final List<Track> tracks;

  _ListItemState(
      {this.text, this.img, this.updateFrequency, this.id, this.tracks});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: 15,
          ),
          ListItemCustom(
            img: img,
            updateFrequency: updateFrequency,
          ),
          _buildTopThreeSongs(context),
          Container(
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  _buildTopThreeSongs(BuildContext context) {
    Widget widget;
    var i = 1; //排行榜名次
    widget = Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: tracks.map((t) {
            return Expanded(
              child: Container(
                  child: Center(
                child: Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Text(
                    '${i++}.${t.first} - ${t.second}',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )),
            );
          }).toList(),
        ),
      ),
    );

    return widget;
  }
}
