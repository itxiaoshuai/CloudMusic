import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'item/DrawerListItem.dart';

class HomeDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Head(),
          DrawerListItemHorizontal(),
          DrawerListItem(image: "images/ticket.png", text: "演出"),
          DrawerListItem(image: "images/shopping_cart.png", text: "商城"),
          DrawerListItem(image: "images/location.png", text: "附近的人"),
          DrawerListItem(image: "images/timing.png", text: "定时停止播放"),
          DrawerListItem(image: "images/alarm.png", text: "音乐闹铃"),
          DrawerListItem(image: "images/music_free_flow.png", text: "在线听歌免流量"),
          DrawerListItem(image: "images/game.png", text: "游戏推荐"),
          DrawerListItem(image: "images/coupon.png", text: "优惠券"),
          DrawerListItem(image: "images/broadcast.png", text: "我要开播"),
        ],
      ),
    );
  }
}

//横向排列的item
class DrawerListItemHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
          children: [
            ListItem(image: "images/drawer_message.png", text: "我的消息"),
            ListItem(image: "images/drawer_friend.png", text: "我的好友"),
            ListItem(image: "images/drawer_skin.png", text: "个性皮肤"),
            ListItem(image: "images/drawer_music.png", text: "听歌识曲"),
          ]),
    );
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
          width: 25,
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

class Head extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _log() {
      print("点击了边线按钮");
    }

    return Container(
        child: Container(
      padding: EdgeInsets.only(top: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(
              '登录网易云音乐',
              style: TextStyle(color: Colors.black, fontSize: 12),
            )
          ]),
          Container(margin: EdgeInsets.all(2)), //文字之间添加 margin
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text(
              '手机电脑多端同步,尽享海量高品质音乐',
              style: TextStyle(color: Colors.black, fontSize: 12),
            )
          ]),
          Container(
            margin: EdgeInsets.only(top: 14),
            child: OutlineButton(
              onPressed: _log,

              padding: EdgeInsets.only(left: 45, right: 45),
              child: Text(
                "立即登录",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              shape: StadiumBorder(
                side: BorderSide(width: 16.0, color: Colors.grey),
              ),
              //一个边框，适合体育场形状的边框（两端有半圆的框），适用于它所应用的小部件的矩形
              borderSide: BorderSide(color: Colors.grey), //默认边框颜色
            ),
          )
        ],
      ),
    ));
  }
}
