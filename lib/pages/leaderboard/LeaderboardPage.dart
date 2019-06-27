import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/CommonLoading.dart';
import 'package:flutter_app/data/net/Http.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';
import 'package:flutter_app/widget/item/Item.dart';

class LeaderBoardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State {
  @override
  void initState() {
    getHttp();
    super.initState();
  }

  Future getHttp() async {
    var response = await Http().get("/toplist");
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('排行榜'),
        ),
//        body: ShopPageFragment());
        body: ListView.builder(itemCount: 1, itemBuilder: buildItem));
  }

  //ListView的Item
  Widget buildItem(BuildContext context, int index) => ListItem();
}

class ListItem extends StatelessWidget {
  final String text;

  ListItem({this.text});

  //ListView的Item
  Widget buildItem(BuildContext context, int index) => Text(
        'xxxxxx',
        style: TextStyle(fontSize: 18.0, color: Colors.black),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.redAccent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListItemCustom(),
          Expanded(
            child: Center(

              child: Container(
                color: Colors.cyan,
                height: 100,
                child: ListView.builder(itemCount: 3, itemBuilder: buildItem),
              ),
//
            ),
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
