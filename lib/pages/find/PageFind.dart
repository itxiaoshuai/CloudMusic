import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/ConstImg.dart';
import 'package:flutter_app/data/api/apis.dart';
import 'package:flutter_app/data/net/Http.dart';
import 'package:flutter_app/data/protocol/banner_model.dart';
import 'package:flutter_app/pages/find/widget/FindBanner.dart';
import 'package:flutter_app/pages/find/widget/SpinKitWaveType.dart';
import 'package:flutter_app/pages/leaderboard/LeaderboardPage.dart';
import 'package:flutter_app/pages/login/LoginMainPage.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'FutureBuilderPage.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FindPageState();
}

class _FindPageState extends State {
  final StreamController<int> _BannerstreamController = StreamController<int>();
  List<Banners> _bannerData = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    getHttp();
    getSongListRecommend();
    super.initState();
  }

  Future getHttp() async {
//    var response = await Http().get("/banner");
    var response =
        await Http().get("http://www.mocky.io/v2/5cee0154300000592c6e9825");
    print(response);
    List<Banners> banners = BannerModel.fromJson(response).banners;
    print(banners.length);
    _bannerData = banners;
    if (banners != null && mounted) {
      setState(() {
        _bannerData = banners;
      });
    }
  }

  Future getSongListRecommend() async {
    var response = await Http().get(MusicApi.SONGLISTDRECOMMEND);

    print(response);
  }

  Future _gerData() async {
    var response = await Http().get(MusicApi.SONGLISTDRECOMMEND);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getHttp();
      },
      child: CustomScrollView(slivers: _listWidget(context)),
    );
  }

  _listWidget(BuildContext context) {
    List<Widget> list = <Widget>[
      FindBanner(bannerData: _bannerData),
      _buildMenu(context),
      Text('xxxxxxxxxxxxxxxxxxxxx'),
//      SliverList(
//        delegate: SliverChildListDelegate([
//          Container(
//            child: FutureBuilder(
//              builder: _buildFuture,
//              future:
//                  _gerData(), // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
//            ),
//          ),
//        ]),
//      ),
    ];

    return list;
  }
}

///snapshot就是_calculation在时间轴上执行过程的状态快照
Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
  switch (snapshot.connectionState) {
    case ConnectionState.none:
      print('还没有开始网络请求');
      return Text('还没有开始网络请求');
    case ConnectionState.active:
      print('active');
      return Text('ConnectionState.active');
    case ConnectionState.waiting:
      print('waiting');
      return Center(child: SpinKitWave(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.red : Colors.green,
            ),
          );
        },
      ));
    case ConnectionState.done:
      print('done');
      if (snapshot.hasError) return Text('Error: ${snapshot.error}');
//      return SpinKitWave(
//        itemBuilder: (_, int index) {
//          return DecoratedBox(
//            decoration: BoxDecoration(
//              color: index.isEven ? Colors.red : Colors.green,
//            ),
//          );
//        },
//      );
//      return _createListView(context, snapshot);
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 4.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: Text('grid item $index'),
            );
          },
          childCount: 20,
        ),
      );
    default:
      return null;
  }
}

Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
  List songlist = snapshot.data['result'];
  return SliverGrid(
    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200.0,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 4.0,
    ),
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Container(
          alignment: Alignment.center,
          color: Colors.teal[100 * (index % 9)],
          child: Text('grid item $index'),
        );
      },
      childCount: 20,
    ),
  );
//  return Container(
//    padding: const EdgeInsets.all(8.0),
//    child: GridView.builder(
//        itemCount: songlist.length,
//        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
//        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//            //横轴元素个数
//            crossAxisCount: 3,
//            //子组件宽高长度比例
//            childAspectRatio: 1.0),
//        itemBuilder: (BuildContext context, int index) {
//          //Widget Function(BuildContext context, int index)
//          return ListItemCustom(
//            img: songlist[index]['picUrl'],
//          );
//        }),
//  );
}

_buildMenu(BuildContext context) {
  Widget widget = SliverList(
    delegate: SliverChildListDelegate([
      Container(
        padding: EdgeInsets.only(top: 15, bottom: 15),
//            color: Colors.green,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
            children: [
              InkWell(
                child: ListItem(
                    image: "images/find/t_dragonball_icn_daily.png",
                    text: "每日推荐"),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return FutureBuilderPage();
                  }));
                },
              ),
              InkWell(
                child: ListItem(
                    image: "images/find/t_dragonball_icn_playlist.png",
                    text: "歌单"),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return LoginMainPage();
                  }));
                },
              ),
              InkWell(
                child: ListItem(
                    image: "images/find/t_dragonball_icn_rank.png",
                    text: "排行榜"),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return LeaderBoardPage();
                  }));
                },
              ),
              InkWell(
                child: ListItem(
                    image: "images/find/t_dragonball_icn_radio.png",
                    text: "电台"),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return LoginMainPage();
                  }));
                },
              ),
              InkWell(
                child: ListItem(
                    image: "images/find/t_dragonball_icn_look.png", text: "直播"),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return LoginMainPage();
                  }));
                },
              ),
            ]),
      ),
      Divider(height: 1),
    ]),
  );
  return widget;
}

class ListItem extends StatelessWidget {
  final String text;
  final String image;

  ListItem({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 40.0,
          decoration: BoxDecoration(
            //圆形渐变
            color: Colors.white,
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: [
              Colors.redAccent,
              Colors.redAccent,
              Colors.red,
            ]),
          ),
          child: Image.asset(
            image,
            color: Colors.white,
            width: 50,
          ),
        ),
        Container(
            margin: EdgeInsets.only(top: 5), //上边距
            child: Text(text,
                style: TextStyle(
                  fontSize: 12,
                )))
      ],
    );
  }
}
