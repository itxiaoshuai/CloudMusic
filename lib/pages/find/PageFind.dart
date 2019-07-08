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
    _gerData();
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
//      child: CustomScrollView(slivers: _listWidget(context)),
      child: ListView(
        children: <Widget>[
          FindBanner(bannerData: _bannerData),
          _buildMenu(context),
          Divider(
            height: 1,
            color: Colors.grey[300],
          ),
          _Header("推荐歌单", () {}),
          FutureBuilder(
            builder: _buildFuture,
            future: _gerData(), // 用户定义的需要异步执行的代码，类型为Future<String>或者null的变量或函数
          ),
        ],
      ),
    );
  }
}

List<int> getDataList(int count) {
  List<int> list = [];
  for (int i = 0; i < count; i++) {
    list.add(i);
  }
  return list;
}

List<Widget> getWidgetList(List list) {
  return getDataList(list.length)
      .map((item) => getItemContainer(list[item]['picUrl']))
      .toList();
}

Widget getItemContainer(String picUrl) {
  return ListItemCustom(img: picUrl);
}

class _Header extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
//      padding: EdgeInsets.only(top: 10, bottom: 10),
      margin: EdgeInsets.only(top: 20, bottom: 6),
      child: Stack(
        children: <Widget>[
          Positioned(
              child: Container(
            margin: EdgeInsets.only(
              left: 10,
            ),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .subhead
                  .copyWith(fontWeight: FontWeight.w800,fontSize: 18),
            ),
          )),
          Positioned(
              right: 15,
              child: Container(
                padding: EdgeInsets.only(top:2,bottom: 2,left: 6,right: 6),
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.grey, width: 0.5),
                  // 边色与边宽度

                  // 底色
                  //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                  shape: BoxShape.rectangle,
                  // 默认值也是矩形
                  borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                ),
                margin: EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  '歌单广场',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontWeight: FontWeight.w800, fontSize: 14),
                ),
              )),
        ],
      ),
//      child: Row(
//        mainAxisAlignment:   MainAxisAlignment.end,
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Padding(padding: EdgeInsets.only(left: 8)),
//          Text(
//            text,
//            style: Theme.of(context)
//                .textTheme
//                .subhead
//                .copyWith(fontWeight: FontWeight.w800),
//          ),
//          Icon(Icons.chevron_right),
//        ],
//      ),
    );
  }

  _Header(this.text, this.onTap);
}

Widget _createListView(BuildContext context, AsyncSnapshot snapshot) {
  List<Map> songlist = (snapshot.data["result"] as List).cast();
  return Container(
    padding: const EdgeInsets.all(8.0),
    child: GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
//      children: getWidgetList(songlist),
      children: songlist.map<Widget>((p) {
        return ListItemCustom(img: p['picUrl'],album: p,);
      }).toList(),
    ),
  );
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
      return _createListView(context, snapshot);

    default:
      return null;
  }
}

_buildMenu(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 15, bottom: 15),
//            color: Colors.green,
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
        children: [
          InkWell(
            child: ListItem(
                image: "images/find/t_dragonball_icn_daily.png", text: "每日推荐"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return FutureBuilderPage();
              }));
            },
          ),
          InkWell(
            child: ListItem(
                image: "images/find/t_dragonball_icn_playlist.png", text: "歌单"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return LoginMainPage();
              }));
            },
          ),
          InkWell(
            child: ListItem(
                image: "images/find/t_dragonball_icn_rank.png", text: "排行榜"),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return LeaderBoardPage();
              }));
            },
          ),
          InkWell(
            child: ListItem(
                image: "images/find/t_dragonball_icn_radio.png", text: "电台"),
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
  );
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
