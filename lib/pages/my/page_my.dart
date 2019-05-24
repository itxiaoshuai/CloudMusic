import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: ListView(
        children: <Widget>[
          Container(
            height: 100,
            color: Colors.cyan,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                HorizontalItem(text: '私人FM'),
                HorizontalItem(text: '最新电台'),
                HorizontalItem(text: 'Sati空间'),
                HorizontalItem(text: '私藏推荐'),
                HorizontalItem(text: '亲子频道'),
                HorizontalItem(text: '古典专区'),
                HorizontalItem(text: '跑步FM'),
                HorizontalItem(text: '小冰电台'),
                HorizontalItem(text: '爵士电台'),
                HorizontalItem(text: '驾驶模式'),
              ],
            ),
          ),
//          VerticalItem(image: "images/ticket.png", text: "演出"),
//          VerticalItem(image: "images/ticket.png", text: "演出"),
//          VerticalItem(image: "images/ticket.png", text: "演出"),
//          VerticalItem(image: "images/ticket.png", text: "演出"),
//          VerticalItem(image: "images/ticket.png", text: "演出"),
//          VerticalItem(image: "images/ticket.png", text: "演出"),
          _getContainer('本地音乐', '(11)', Icons.music_note),
          _getContainer('最近播放', '(7)', Icons.local_play),
          _getContainer('下载管理', '(0)', Icons.file_download),
          _getContainer('我的电台', '(0)', Icons.radio),
          _getContainer('我的收藏', '(0)', Icons.collections_bookmark),
        ],
      ),
    );
  }
}

Widget _getContainer(String test, String textSecond, IconData icon) {
  return Container(
    color: Colors.blue,

//      ListTile
    child: ListTile(
//       显示在title之前
      leading: Icon(icon),

      title: Container(
        color: Colors.yellowAccent,
        alignment: Alignment.bottomLeft,
        child: Row(
          children: <Widget>[
            Container(
              color: Colors.red,
              alignment: Alignment.bottomLeft,
              child: Text(test),
            ),
            Container(
              margin: EdgeInsets.all(8.0),
              color: Colors.yellow,
              alignment: Alignment.bottomLeft,
              child: Text(textSecond, style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    ),
  );
}

class HorizontalItem extends StatelessWidget {
  final String text;

  HorizontalItem({this.text});

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
              decoration: BoxDecoration(
                //圆形渐变
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

class VerticalItem extends StatelessWidget {
  final String text;
  final String image;

  VerticalItem({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 45.0,
      child: Row(
        children: <Widget>[
          Image.asset(
            image,
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(
              text,
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
