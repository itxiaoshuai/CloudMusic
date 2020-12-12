import 'package:flutter/material.dart';
import 'package:flutter_app/pages/find/PageFind.dart';
import 'package:flutter_app/pages/my/MyApp.dart';
import 'package:flutter_app/pages/my/PageMy.dart';
import 'package:flutter_app/pages/my/StickyDemo.dart';
import 'package:flutter_app/pages/playllist/page_playlist_detail.dart';
import 'package:flutter_app/pages/video/VideoPage.dart';
import 'package:flutter_app/widget/HomeDrawer.dart';

import 'ChildItemView.dart';

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

  //当前显示页面的
  int currentIndex = 0;

  //底部导航栏显示的内容
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      activeIcon: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              //圆形渐变
              color: Colors.white,
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.redAccent,
                    Colors.redAccent,
                    Colors.white,
                  ]),
            ),
            child: Image.asset(
              'images/t_actionbar_discover_selected.png',
              width: 50,
            ),
          ),
        ],
      ),
      icon: Image.asset(
        'images/t_actionbar_discover_selected.png',
        color: Colors.grey[400],
        width: 50,
      ),
      label: "发现",
    ),
    BottomNavigationBarItem(
      activeIcon: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              //圆形渐变
              color: Colors.white,
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.redAccent,
                    Colors.redAccent,
                    Colors.white,
                  ]),
            ),
            child: Image.asset(
              'images/t_actionbar_music_selected.png',
              width: 50,
            ),
          ),
        ],
      ),
      icon: Image.asset(
        'images/t_actionbar_music_selected.png',
        color: Colors.grey[400],
        width: 50,
      ),
      label: "播客",
    ),
    BottomNavigationBarItem(
      activeIcon: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              //圆形渐变
              color: Colors.white,
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.redAccent,
                    Colors.redAccent,
                    Colors.white,
                  ]),
            ),
            child: Image.asset(
              'images/t_actionbar_music_selected.png',
              width: 50,
            ),
          ),
        ],
      ),
      icon: Image.asset(
        'images/t_actionbar_music_selected.png',
        color: Colors.grey[400],
        width: 50,
      ),
      label: "我的",
    ),
    BottomNavigationBarItem(
      activeIcon: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              //圆形渐变
              color: Colors.white,
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.redAccent,
                    Colors.redAccent,
                    Colors.white,
                  ]),
            ),
            child: Image.asset(
              'images/t_actionbar_music_selected.png',
              width: 50,
            ),
          ),
        ],
      ),
      icon: Image.asset(
        'images/t_actionbar_music_selected.png',
        color: Colors.grey[400],
        width: 50,
      ),
      label: "K歌",
    ),
    BottomNavigationBarItem(
      activeIcon: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              //圆形渐变
              color: Colors.white,
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Colors.redAccent,
                    Colors.redAccent,
                    Colors.white,
                  ]),
            ),
            child: Image.asset(
              'images/t_actionbar_friends_selected.png',
              width: 50,
            ),
          ),
        ],
      ),
      icon: Image.asset(
        'images/t_actionbar_friends_selected.png',
        color: Colors.grey[400],
        width: 50,
      ),
      label: "云村",
    ),
  ];

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }

  //点击导航项是要显示的页面
  final pages = [
    FindPage(),
    StickyDemo(),
    MyPage(),
    MyApp(),
    VideoPage(),
  ];

  Widget buildBottomTabScaffold() {
    return Scaffold(
      appBar: AppBar(),
      drawer: HomeDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        //所以一般都是使用fixed模式，此时，导航栏的图标和标题颜色会使用fixedColor指定的颜色，
        // 如果没有指定fixedColor，则使用默认的主题色primaryColor
        type: BottomNavigationBarType.fixed,
        //底部菜单点击回调
        onTap: (index) {
          _changePage(index);
        },
      ),
      //对应的页面
      body: pages[currentIndex],
    );
  }

  @override
  Widget build(BuildContext context) {
    //构建页面
    return buildBottomTabScaffold();
    // return super.build(context);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //       decoration: BoxDecoration(
  //           image: DecorationImage(
  //         image: AssetImage('images/icon_bg_my.png'),
  //         fit: BoxFit.cover,
  //       )),
  //       child: Scaffold(
  //           backgroundColor:
  //               _tabController.index == 0 ? Colors.transparent : Colors.white,
  //           //把scaffold的背景色改成透明
  //           appBar: AppBar(
  //             actions: <Widget>[
  //               IconButton(
  //                 icon: Icon(
  //                   Icons.search,
  //                   color: Colors.white,
  //                 ),
  //                 onPressed: null,
  //               )
  //             ],
  //             centerTitle: true,
  //             backgroundColor:
  //                 _tabController.index == 0 ? Colors.transparent : Colors.red,
  //             elevation: 0,
  //             //appbar的阴影
  //             title: TabBar(
  //               labelPadding: EdgeInsets.only(left: 0, right: 0),
  //               indicatorSize: TabBarIndicatorSize.tab,
  //               isScrollable: false,
  //               labelStyle:
  //                   TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //               unselectedLabelStyle: TextStyle(fontSize: 14),
  //               indicator: const BoxDecoration(),
  //               controller: _tabController,
  //               tabs: <Widget>[
  //                 Tab(
  //                   text: '我的',
  //                 ),
  //                 Tab(
  //                   text: '发现',
  //                 ),
  //                 Tab(
  //                   text: '朋友',
  //                 ),
  //                 Tab(
  //                   text: '视频',
  //                 ),
  //               ],
  //             ),
  //           ),
  //           drawer: HomeDrawer(),
  //           body: TabBarView(
  //             controller: _tabController,
  //             children: <Widget>[
  //               MyPage(),
  //               FindPage(),
  //               Center(child: Text('朋友')),
  //               VideoPage(),
  //             ],
  //           )));
  // }

  @override
  bool get wantKeepAlive => true; //必须重写
}
