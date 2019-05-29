import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/net/Http.dart';
import 'package:flutter_app/data/protocol/banner_model.dart';
import 'package:flutter_app/pages/find/widget/FindBanner.dart';
import 'package:flutter_app/pages/find/widget/SwiperAndMenu.dart';

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

    /// 获取轮播图
//    String result = Http(loading: false).request(Method.get, '/banner');
//    if (result != null) {
//      print('xxxxxxxxxxxxxxxxxx');
//      print(result);
//      print('zzzzzzzzzzzzzzzzzzzzz');
//
//    }
  }

//  void getHttp() async {
//    try {
//      print("zzzzzzzzzzzzzzzzzzzzzzzzzz");
//      Response response = await Dio().get("http://192.168.0.100:3000/banner");
//      print(response);
//    } catch (e) {
//      print(e);
//    }
//  }

  @override
  Widget build(BuildContext context) {
    int _counter = 0;
    return RefreshIndicator(
      onRefresh: () async {
        getHttp();
      },
      child: CustomScrollView(slivers: _listWidget()),
//      child: FindBanner(bannerData: _bannerData),
    );
//    return ListView(
//      children: <Widget>[
//        Container(
//          height: 500,
//          child: FindBanner(),
//        )
////        FindBanner(),
//        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
//            children: [
//              ListItem(
//                  image: "images/find/t_dragonball_icn_look.png", text: "每日推荐"),
//              ListItem(
//                  image: "images/find/t_dragonball_icn_playlist.png",
//                  text: "歌单"),
//              ListItem(
//                  image: "images/find/t_dragonball_icn_rank.png", text: "排行榜"),
//              ListItem(
//                  image: "images/find/t_dragonball_icn_radio.png", text: "电台"),
//              ListItem(
//                  image: "images/find/t_dragonball_icn_look.png", text: "直播"),
//            ]),
//      ],
//    );
  }

  _listWidget() {
    List<Widget> list = <Widget>[
      FindBanner(bannerData: _bannerData),
    ];

//    if (_songSheet.length != 0 &&
//        _newsong.length != 0 &&
//        _djprogram.length != 0) {
//
//    } else {
//      list.add(SliverList(
//        delegate: SliverChildListDelegate([
//          const Text('D'),
//        ]),
//      ));
//    }

    return list;
  }
}

class ListItem extends StatelessWidget {
  final String text;
  final String image;

  ListItem({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image,
          color: Colors.red,
          width: 50,
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
