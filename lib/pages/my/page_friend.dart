import 'package:cloud_music/widget/CustomUnderlineTabIndicator.dart';
import 'package:flutter/material.dart';

class FriendPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController tabController;
  var tabs = <Tab>[];

  @override
  void initState() {
    super.initState();

    tabs = <Tab>[
      Tab(
        text: "推荐 ",
      ),
      Tab(
        text: "关注",
      ),
      Tab(
        text: "粉丝",
      ),
    ];
    this.tabController =
        TabController(length: tabs.length, initialIndex: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //修改颜色
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Container(
          // padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          // color: Colors.grey,
          child: TabBar(
            controller: tabController,
            //可以和TabBarView使用同一个TabController
            tabs: tabs,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: CustomUnderlineTabIndicator(
                insets: EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 15),
                borderSide: BorderSide(
                  width: 5,
                  color: Color(0xff00cdd7),
                )),
            isScrollable: false,
            labelColor: Colors.black,
            labelStyle: TextStyle(),
            unselectedLabelColor: Colors.grey[600],
            unselectedLabelStyle: TextStyle(),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color: Colors.grey,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: TabBarView(
        controller: this.tabController,
        children: <Widget>[
          Text('第一个tab'),
          Text("第二个tab"),
          Text("第三个tab"),
        ],
      ),
    );
  }

  bool get wantKeepAlive => true;
}
