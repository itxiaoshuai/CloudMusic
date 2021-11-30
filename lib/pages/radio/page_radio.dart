import 'package:flutter/material.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:cloud_music/widget/item/menu_item.dart';

class RadioPage extends StatefulWidget {

  RadioPageState createState() => RadioPageState();
}

class RadioPageState extends State<RadioPage> {
  _buildMenu(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
//            color: Colors.green,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
          children: [
            MenuItem(
              image: "images/find/t_dragonball_icn_daily.png",
              text: "电台分类",
              route: RouteName.RADIO_CATEGORY,
            ),
            MenuItem(
                image: "images/find/t_dragonball_icn_daily.png", text: "电台排行"),
            MenuItem(
                image: "images/find/t_dragonball_icn_daily.png", text: "付费精品"),
            MenuItem(
                image: "images/find/t_dragonball_icn_daily.png", text: "主播学院"),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('电台'),
      ),
      body: ListView(
        children: <Widget>[
          _buildMenu(context),
        ],
      ),
    );
  }
}
