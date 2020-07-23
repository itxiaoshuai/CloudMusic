import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/api/apis.dart';

import 'package:flutter_app/data/net/Http.dart';
import 'package:flutter_app/data/protocol/LeaderboardDetailModel.dart';
import 'package:flutter_app/data/protocol/LeaderboardModel.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
import 'package:flutter_app/pages/playllist/page_playlist_detail.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';

import 'LeaderboardDetailPage.dart';

class LeaderBoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State {
  List<LeaderBoardList> _leaderBoardList = [];
  List<int> tracks = [];

  @override
  void initState() {
    getHttp();
    super.initState();
  }

  Future getHttp() async {
    var dio = Dio();
    var response = await dio.get("http://118.24.63.15:1020/toplist/detail");
    print(response);

    var user = LeaderBoardModel.fromJson(response.data);
    List<LeaderBoardList> list = user.list;
    print(list);
    if (list != null && mounted) {
      setState(() {
        _leaderBoardList = list;

        if (_leaderBoardList.length >= 6) {
          tracks = List<int>();
          _leaderBoardList.sublist(0, 6).forEach((v) {
//            tracks.add(v.id);
          });
        }
        print('tracks====$tracks');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('排行榜'),
      ),
      body: CustomScrollView(
        slivers: _listWidget(context),
      ),
    );
  }

  _listWidget(BuildContext context) {
    List<Widget> list;
    if (_leaderBoardList.length > 0) {
      list = <Widget>[
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
            //创建列表项
            return Container(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PlaylistDetailPage(_leaderBoardList[index].id);
                  }));
                },
                child: ListItem(
                  img: _leaderBoardList[index].coverImgUrl,
                  updateFrequency: _leaderBoardList[index].updateFrequency,
                  id: _leaderBoardList[index].id,
                  tracks: _leaderBoardList[index].tracks,
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
        _buildRecommend(context),
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
        _buildGlobalList(context),
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
        _buildMoreList(context),
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
      list = <Widget>[
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

    return list;
  }

  _buildRecommend(BuildContext context) {
    Widget widget;
    if (_leaderBoardList.length > 12) {
      List<LeaderBoardList> list = _leaderBoardList.sublist(6, 12);

      widget = SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //Grid按两列显示
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              //创建子widget
              return Container(
                child: ListItemCustom(
                  img: list[index].coverImgUrl,
                  updateFrequency: list[index].updateFrequency,
                ),
              );
            },
            childCount: list.length,
          ),
        ),
      );
    } else {
      List<LeaderBoardList> list =
          _leaderBoardList.sublist(6, _leaderBoardList.length);

      widget = SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //Grid按两列显示
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              //创建子widget
              return Container(
                child: ListItemCustom(
                  img: list[index].coverImgUrl,
                  updateFrequency: list[index].updateFrequency,
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

  _buildGlobalList(BuildContext context) {
    Widget widget;
    if (_leaderBoardList.length > 18) {
      List<LeaderBoardList> list = _leaderBoardList.sublist(12, 18);

      widget = SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //Grid按两列显示
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              //创建子widget
              return Container(
                child: ListItemCustom(
                  img: list[index].coverImgUrl,
                  updateFrequency: list[index].updateFrequency,
                ),
              );
            },
            childCount: list.length,
          ),
        ),
      );
    } else {
      List<LeaderBoardList> list =
          _leaderBoardList.sublist(12, _leaderBoardList.length);

      widget = SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //Grid按两列显示
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              //创建子widget
              return Container(
                child: ListItemCustom(
                  img: list[index].coverImgUrl,
                  updateFrequency: list[index].updateFrequency,
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

  _buildMoreList(BuildContext context) {
    Widget widget;
    if (_leaderBoardList.length > 18) {
      List<LeaderBoardList> list =
          _leaderBoardList.sublist(18, _leaderBoardList.length);

      widget = SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //Grid按两列显示
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              //创建子widget
              return Container(
                child: ListItemCustom(
                  img: list[index].coverImgUrl,
                  updateFrequency: list[index].updateFrequency,
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
