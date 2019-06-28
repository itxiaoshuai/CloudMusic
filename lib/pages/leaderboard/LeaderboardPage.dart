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
        body: ListView.builder(itemCount: 4, itemBuilder: buildItem));
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
      margin: EdgeInsets.only(top: 5,bottom: 5),
      height: 100,
//      color: Colors.redAccent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: 15,
          ),
          ListItemCustom(),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10,right: 10),

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
