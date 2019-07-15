import 'package:flutter/material.dart';
import 'package:flutter_app/pages/find/PageFind.dart';
import 'package:flutter_app/pages/my/PageMy.dart';
import 'package:flutter_app/widget/HomeDrawer.dart';


class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
//        title: TabContainerState(),
        title: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          isScrollable: true,
          tabs: <Widget>[
            Tab(
              text: '我的',
            ),
            Tab(
              text: '发现',
            ),
            Tab(
              text: '朋友',
            ),
            Tab(
              text: '视频',
            ),
          ],
          controller: _tabController,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          MyPage(),
          FindPage(),
          Center(child: Text('朋友')),
          Center(child: Text('视频')),
        ],
      ),
      drawer: HomeDrawer(),
    );
  }
}

