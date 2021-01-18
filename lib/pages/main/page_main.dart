import 'package:flutter/material.dart';
import 'package:cloud_music/pages/find/PageFind.dart';
import 'package:cloud_music/pages/my/CurvePage.dart';
import 'package:cloud_music/pages/my/DrawingPage.dart';
import 'package:cloud_music/pages/my/MyApp.dart';
import 'package:cloud_music/pages/my/PageMy.dart';
import 'package:cloud_music/pages/my/StickyDemo.dart';
import 'package:cloud_music/pages/playlist/page_playlist_detail.dart';
import 'package:cloud_music/pages/podcast/PagePodcast.dart';
import 'package:cloud_music/pages/video/VideoPage.dart';
import 'package:cloud_music/widget/HomeDrawer.dart';
import 'ChildItemView.dart';
import 'package:cloud_music/pages/yuncun/page_yuncun.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  PageController _controller;
  int _currentIndex = 0;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  //点击导航项是要显示的页面
  final _pages = [
    FindPage(), //发现
    PagePodcast(), //播客
    MyPage(),
    MyScrv(),
    YunCunPage(),
  ];

  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildBottomTabScaffold() {
    return Scaffold(
      //这里设置
      backgroundColor: Colors.grey[100],

      drawer: HomeDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: _currentIndex,
        //所以一般都是使用fixed模式，此时，导航栏的图标和标题颜色会使用fixedColor指定的颜色，
        // 如果没有指定fixedColor，则使用默认的主题色primaryColor
        type: BottomNavigationBarType.fixed,
        //底部菜单点击回调
        onTap: onTap,
      ),
      //对应的页面
      // body: pages[currentIndex],
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        itemCount: _pages.length,
        itemBuilder: (context, index) {
          return _pages[index];
        },
        onPageChanged: _pageChange,
      ),
    );
  }

  void _pageChange(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void onTap(int index) {
    _controller.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    //构建页面
    return buildBottomTabScaffold();
    return super.build(context);
  }

  @override
  bool get wantKeepAlive => true; //必须重写
}
