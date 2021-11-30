import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  final String title;
  const homePage({required Key key, required this.title}) : super(key: key);

  @override
  _homePageState createState() => _homePageState();
}

class GoodsTab {
  //tab包装类
  late String text;
// GoodList goodList;
}

class _homePageState extends State<homePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List _data_menus = [
    {'title': '菜单一', 'img': ''},
    {'title': '菜单二', 'img': ''},
    {'title': '菜单三', 'img': ''},
    {'title': '菜单四', 'img': ''},
    {'title': '菜单五', 'img': ''},
    {'title': '菜单六', 'img': ''},
    {'title': '菜单七', 'img': ''},
    {'title': '全部', 'img': ''},
  ];

  Key _key_widget_menu_card = Key("_key_widget_menu_card");

  Widget _widget_menu_item(Map v) {
    return Container(
      width: MediaQuery.of(context).size.width / 4 - 4,
      child: new FlatButton(
        onPressed: null,
        child: new Container(
          padding: EdgeInsets.fromLTRB(2, 8, 2, 8),
          child: new Column(
            children: <Widget>[
              new Container(
                margin: const EdgeInsets.only(bottom: 6),
                child: CircleAvatar(
                  radius: 20.0,
                  child: new Icon(Icons.invert_colors, color: Colors.white),
                  backgroundColor: Color(0xFFB88800),
                ),
              ),
              new Container(
                child: new Text(v['title'],
                    style: TextStyle(
                        fontSize: 14.0, backgroundColor: Colors.yellow)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _widget_menu_card() {
    return new SliverToBoxAdapter(
      child: Card(
        child: new Wrap(
          alignment: WrapAlignment.center,
          children: _data_menus.map((v) {
            return _widget_menu_item(v);
          }).toList(),
        ),
      ),
    );
  }

  List myTabs = ["热点", "地方", "直播", "社会"];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              //顶部菜单部分
              _widget_menu_card(),

              //中间悬浮subtitle
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  pinned: true,
                  forceElevated: innerBoxIsScrolled,
                  title: TabBar(
                    isScrollable: true,
                    tabs: myTabs.map((title) {
                      return Tab(text: title ?? "默认");
                    }).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: myTabs.map((title) {
              return Text('xxxxx');
            }).toList(),
          ),
        ),
      ),
    );
  }
}
