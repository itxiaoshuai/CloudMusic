import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          ListItemCustom(text: '私人FM'),
          ListItemCustom(text: '最新电台'),
          ListItemCustom(text: 'Sati空间'),
          ListItemCustom(text: '私藏推荐'),
          ListItemCustom(text: '亲子频道'),
          ListItemCustom(text: '古典专区'),
          ListItemCustom(text: '跑步FM'),
          ListItemCustom(text: '小冰电台'),
          ListItemCustom(text: '爵士电台'),
          ListItemCustom(text: '驾驶模式'),
        ],
      ),
    );
  }
}

class ListItemCustom extends StatelessWidget {
  final String text;

  ListItemCustom({this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(//圆形渐变
                color: Colors.white,
                shape: BoxShape.circle,
                gradient: const LinearGradient(colors: [
                  Colors.redAccent,
                  Colors.red,
                ]),
              ),
            ),
            Container(
              height: 8,
            ),
            Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}
