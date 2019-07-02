import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/api/apis.dart';

import 'package:flutter_app/data/net/Http.dart';
import 'package:flutter_app/data/protocol/LeaderboardDetailModel.dart';
import 'package:flutter_app/data/protocol/LeaderboardModel.dart';
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
    var response = await Http().get(MusicApi.TOPLIST);

    var user = LeaderBoardModel.fromJson(response);
    List<LeaderBoardList> list = user.list;
    print(list);
    if (list != null && mounted) {
      setState(() {
        _leaderBoardList = list;

        if (_leaderBoardList.length >= 6) {
          tracks =  List<int>();
          _leaderBoardList.sublist(0, 6).forEach((v) {
            tracks.add(v.id);
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
          delegate:  SliverChildListDelegate(
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
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ChoiceSongSheetPage();
                  }));
                },
                child: ListItem(
                  img: _leaderBoardList[index].coverImgUrl,
                  updateFrequency: _leaderBoardList[index].updateFrequency,
                  id: _leaderBoardList[index].id,
                ),
              ),
            );
          }, childCount: 6 //50个列表项
                  ),
        ),
        SliverList(
          delegate:  SliverChildListDelegate(
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
          delegate:  SliverChildListDelegate(
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
          delegate:  SliverChildListDelegate(
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
          delegate:  SliverChildListDelegate(
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

  //ListView的Item
  Widget buildItem(BuildContext context, int index) => ListItem(
        img: _leaderBoardList[index].coverImgUrl,
        updateFrequency: _leaderBoardList[index].updateFrequency,
        id: _leaderBoardList[index].id,
      );
}

class ListItem extends StatefulWidget {
  final String text;
  final String img;
  final String updateFrequency;
  final int id;

  ListItem({this.text, this.img, this.updateFrequency, this.id});

  @override
  _ListItemState createState() => _ListItemState(
      text: text, img: img, updateFrequency: updateFrequency, id: id);
}

class _ListItemState extends State {
  final String text;
  final String img;
  final String updateFrequency;
  final int id;

  final List<String> _listTitle = [];

  _ListItemState({this.text, this.img, this.updateFrequency, this.id});

  @override
  void initState() {
    var v = _listTitle.length;

    print('_listTitle.length.length$v');
    if (v == 18) {
      return;
    }
    if (id > 0) {
      getSongListDetail(id);
    }
    super.initState();
  }

  ///http://106.13.32.37:3000/playlist/detail?id=19723756

  Future getSongListDetail(int id) async {
    var response = await Http().get(
      MusicApi.SONGLISTDETAILS,
      queryParameters: {"id": id},
    );
    print('response====$response');
    LeaderBoardDetailModel songListDetail =
        LeaderBoardDetailModel.fromJson(response);

    var playlist = songListDetail.playlist;

    List<Tracks> tracks = playlist.tracks;

    tracks.sublist(0, 3).forEach((id) {
      var name = id.name;
      List<Ar> authors = id.ar;
      var authorName;
      authors.forEach((author) {
        authorName = author.name;
      });
      var title = name + '_' + authorName;
      print('title====$title');

      _listTitle.add(title);
    });
    if (_listTitle != null && mounted) {
      setState(() {
        print('_listTitle====$_listTitle');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      height: 100,
//      color: Colors.redAccent,
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

  ///展示前三首音乐
  _buildTopThreeSongs(BuildContext context) {
    Widget widget;
    var length = _listTitle.length;
    print('_listTitle.length$length');
    if (_listTitle.length >= 3) {
      widget = Expanded(
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
              children: [
                Expanded(
                  child: Container(
//                      color: Colors.green,
                      child: Center(
                    child:  Align(
                      alignment: FractionalOffset.centerLeft,
                      child: Text(
                        '1.' + _listTitle[0],
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )),
                ),
                Expanded(
                  child: Container(
                      child: Center(
                    child:  Align(
                      alignment: FractionalOffset.centerLeft,
                      child: Text(
                        '2.' + _listTitle[1],
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )),
                ),
                Expanded(
                  child: Container(
                      child: Center(
                    child:  Align(
                      alignment: FractionalOffset.centerLeft,
                      child: Text(
                        '3.' + _listTitle[2],
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )),
                ),
              ]),
        ),
      );
    } else {
      print('_listTitle.lengthxxxxxxxxxx$length');
      widget = Container(
        height: 0,
      );
    }

    return widget;
  }
}
