
import 'package:flutter/material.dart';
import 'package:flutter_app/data/api/apis.dart';

import 'package:flutter_app/data/net/Http.dart';
import 'package:flutter_app/data/protocol/LeaderboardModel.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';


class LeaderBoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State {
  List<LeaderBoardList> _leaderBoardList = [];

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
          delegate: new SliverChildListDelegate(
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
              child: ListItem(
                img: _leaderBoardList[index].coverImgUrl,
                updateFrequency: _leaderBoardList[index].updateFrequency,
              ),
            );
          }, childCount: 6 //50个列表项
                  ),
        ),
        SliverList(
          delegate: new SliverChildListDelegate(
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
          delegate: new SliverChildListDelegate(
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
          delegate: new SliverChildListDelegate(
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
          delegate: new SliverChildListDelegate(
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
      );
}

class ListItem extends StatelessWidget {
  final String text;
  final String img;
  final String updateFrequency;

  ListItem({this.text, this.img, this.updateFrequency});

  //ListView的Item
  Widget buildItem(BuildContext context, int index) => Text(
        'xxxxxx',
        style: TextStyle(fontSize: 18.0, color: Colors.black),
      );

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
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
                  children: [
                    Expanded(
                      child: Container(
                          child: Center(
                        child: Text(
                          '1.木偶人-木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                    ),
                    Expanded(
                      child: Container(
                          child: Center(
                        child: Text(
                          '1.木偶人-木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                    ),
                    Expanded(
                      child: Container(
                          child: Center(
                        child: Text(
                          '1.木偶人-木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦木偶人-薛之谦',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      )),
                    ),
                  ]),
            ),
          ),
          Container(
            color: Colors.green,
          ),

//          ListView.builder(itemCount: 3, itemBuilder: buildItem),
        ],
      ),
//      child: ListItemCustom(),
//      child: Row(
//        children: <Widget>[
//          ListItemCustom(),
////          CachedNetworkImage(
////            fit: BoxFit.fill,
////            imageUrl:
////                'http://p2.music.126.net/BzSxoj6O1LQPlFceDn-LKw==/18681802069355169.jpg',
////            placeholder: (context, url) => ProgressView(),
////            errorWidget: (context, url, error) => new Icon(Icons.error),
////          ),
////          ListView.builder(itemCount: 3, itemBuilder: buildItem),
////          Column(
////            children: <Widget>[
////              ListView.builder(itemCount: 3, itemBuilder: buildItem),
////              Container(
////                  color: Colors.orange,
////                  child: Text(text,
////                      style: TextStyle(
////                        fontSize: 12,
////                      )))
////            ],
////          ),
//        ],
//      ),
    );
  }
}
