import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/base/ConstImg.dart';
import 'package:flutter_app/base/res/gaps.dart';
import 'package:flutter_app/data/api/apis.dart';
import 'package:flutter_app/data/protocol/playlist_detail.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
import 'package:flutter_app/pages/find/FutureBuilderPage.dart';
import 'package:flutter_app/pages/leaderboard/LeaderboardPage.dart';
import 'package:flutter_app/pages/playllist/page_playlist_detail.dart';
import 'package:flutter_app/pages/radio/page_radio.dart';
import 'package:flutter_app/pages/user/page_user_detail.dart';
import 'package:flutter_app/widget/base_song_img_item.dart';
import 'package:flutter_app/widget/flexible_app_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';

List widgets = [];

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  PlaylistDetail playlist;
  TabController tabController;

  @override
  void initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
    getSongListRecommend();
  }

  Future getSongListRecommend() async {
    Map<String, dynamic> formData = {
      'limit': 6,
    };
    var response = await Http()
        .get(MusicApi.SONGLISTDRECOMMEND, queryParameters: formData);
    print(response);
    List rows = response.data['result'];
    widgets = rows;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _DetailPage();
  }
}

class _DetailPage extends StatelessWidget {
  var i = 1; //排行榜名次
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: _UserDetailAppBar())
            ];
          },
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: kToolbarHeight + kTextTabBarHeight),
              child: Container(
                color: Colors.yellow,
                child: Column(
                  children: [
                    Container(
//            padding: EdgeInsets.only(left: 15, right: 0),
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Gaps.hGap15,
                          Row(
                            children: widgets.map<Widget>((p) {
                              i++;
                              return Row(
                                children: [
                                  BaseImgItem(
                                    id: p['id'],
                                    width: 120,
                                    playCount: p['playCount'],
                                    img: p['picUrl'],
                                    describe: p['name'],
                                  ),
                                  i == widgets.length + 1
                                      ? Gaps.hGap15
                                      : Gaps.hGap8,
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UserDetailAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 720, height: 1080, allowFontScaling: false);
    return SliverAppBar(
//      leading: GestureDetector(
//        child: Icon(Icons.arrow_back),
//        onTap: () => Navigator.pop(context),
//      ),
      //左侧按钮
      /**
       * 如果没有leading，automaticallyImplyLeading为true，就会默认返回箭头
       * 如果 没有leading 且为false，空间留给title
       * 如果有leading，这个参数就无效了
       */
      automaticallyImplyLeading: false,
      //标题
      centerTitle: false,

      //右侧的内容和点击事件啥的
      elevation: 4,
      //阴影的高度
      forceElevated: false,
      //是否显示阴影
//      backgroundColor: Colors.green,
      //背景颜色
      brightness: Brightness.dark,
      //黑底白字，lignt 白底黑字

      //所有的icon的样式,不仅仅是左侧的，右侧的也会改变
      textTheme: TextTheme(),
      //字体样式
      primary: true,
      // appbar是否显示在屏幕的最上面，为false是显示在最上面，为true就显示在状态栏的下面
      titleSpacing: 16,
      //标题两边的空白区域
      expandedHeight: 330,
      //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
      floating: true,
      //滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
      pinned: true,
      //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
      snap: false,
      bottom: RoundedTabBar(),
      //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
      flexibleSpace: FlexibleDetailBar(
        background: FlexShadowBackground(
          child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://dss2.bdstatic.com/6Ot1bjeh1BF3odCf/it/u=1676744405,540713731&fm=85&app=92&f=PNG?w=121&h=75&s=D385D70204BC4C2D515E34430300E0BB')),
        ),
        content: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          color: Colors.transparent,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//                Spacer(),
                _buildMenu(context),
              ]),
        ),
      ),
    );
  }
}

class PrimaryTabIndicator extends UnderlineTabIndicator {
  PrimaryTabIndicator({Color color: Colors.white})
      : super(
            insets: const EdgeInsets.only(bottom: 4),
            borderSide: BorderSide(color: color, width: 2.0));
}

///网易云音乐风格的TabBar
class RoundedTabBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      child: Material(
//        color: Theme.of(context).scaffoldBackgroundColor,
        child: Container(
            height: 50,
            color: Colors.white,
            child: Row(
              children: [
                Text('我的音乐'),
                Spacer(),
                Icon(Icons.keyboard_arrow_right)
              ],
            )),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}

_buildMenu(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 15, bottom: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: videoCategoryList.map((e) {
        return VerticalItem(
          image: e.img,
          text: e.title,
        );
      }).toList(),
    ),
  );
}

class VerticalItem extends StatelessWidget {
  final String text;
  final String image;

  VerticalItem({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image,
          color: Colors.black,
          width: 20,
        ),
        Container(
            margin: EdgeInsets.only(top: 5), //上边距
            child: Text(text,
                style: TextStyle(
                  fontSize: 12,
                )))
      ],
    );
  }
}

class Menu {
  const Menu({this.title, this.img, this.path});

  final String title;
  final String img;
  final String path;
}

const List<Menu> videoCategoryList = const <Menu>[
  const Menu(
    title: '本地音乐 ',
    img: 'images/album/album_share.png',
    path: '',
  ),
  const Menu(
    title: '下载管理 ',
    img: 'images/album/album_download.png',
    path: '',
  ),
  const Menu(
    title: '我的电台 ',
    img: 'images/find/t_dragonball_icn_radio.png',
    path: '',
  ),
  const Menu(
    title: '我的收藏 ',
    img: 'images/album/album_share.png',
    path: '',
  ),
  const Menu(
    title: '关注新歌 ',
    img: 'images/album/album_share.png',
    path: '',
  ),
];
