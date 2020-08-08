import 'package:flutter/material.dart';
import 'package:flutter_app/pages/find/PageFind.dart';
import 'package:flutter_app/pages/my/PageMy.dart';
import 'package:flutter_app/pages/playllist/page_playlist_detail.dart';
import 'package:flutter_app/pages/video/VideoPage.dart';
import 'package:flutter_app/widget/HomeDrawer.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4, initialIndex: 1)
      ..addListener(() {
        print('_tabControllerIndex' + _tabController.index.toString());
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/icon_bg_my.png'),
          fit: BoxFit.cover,
        )),
        child: Scaffold(
            backgroundColor:
                _tabController.index == 0 ? Colors.transparent : Colors.white,
            //把scaffold的背景色改成透明
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: null,
                )
              ],
              centerTitle: true,
              backgroundColor:
                  _tabController.index == 0 ? Colors.transparent : Colors.red,
              elevation: 0,
              //appbar的阴影
              title: TabBar(
                labelPadding: EdgeInsets.only(left: 0, right: 0),
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: false,
                labelStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 14),
                indicator: const BoxDecoration(),
                controller: _tabController,
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
              ),
            ),
            drawer: HomeDrawer(),
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                MyPage(),
                FindPage(),
                Center(child: Text('朋友')),
                VideoPage(),
              ],
            )));
  }

  get _drawer => Drawer(
        child: Text('This is Drawer'),
      );
  @override
  bool get wantKeepAlive => true; //必须重写
}
