import 'package:flutter/material.dart';

class FindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
          children: [
            ListItem(image: "images/find/t_dragonball_icn_look.png", text: "每日推荐"),
            ListItem(image: "images/find/t_dragonball_icn_playlist.png", text: "歌单"),
            ListItem(image: "images/find/t_dragonball_icn_rank.png", text: "排行榜"),
            ListItem(image: "images/find/t_dragonball_icn_radio.png", text: "电台"),
            ListItem(image: "images/find/t_dragonball_icn_look.png", text: "直播"),
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
