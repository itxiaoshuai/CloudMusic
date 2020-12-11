import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/base/ConstImg.dart';
import 'package:flutter_app/base/res/gaps.dart';
import 'package:flutter_app/base/res/styles.dart';
import 'package:flutter_app/data/api/apis.dart';
import 'package:flutter_app/data/protocol/playlist_detail.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
import 'package:flutter_app/widget/base_song_img_item.dart';
import 'package:flutter_app/widget/flexible_app_bar.dart';
import 'package:flutter_screenutil/screenutil.dart';

List widgets = [];

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
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

  @override
  bool get wantKeepAlive => true;
}

class _DetailPage extends StatelessWidget {
  var i = 1; //排行榜名次
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: _UserDetailAppBar())
              ];
            },
            body: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        height: 50,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Text('我的音乐'),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right)
                          ],
                        )),
                    Container(
                      color: Colors.cyan,
                      height: 140,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                  height: 140,
                                  width: 104,
                                  color: Colors.deepOrangeAccent,
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          top: 40,
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'images/album/album_download.png',
                                                width: 24,
                                                height: 24,
                                                color: Colors.black,
                                              ),
                                              Gaps.vGap5,
                                              Text(
                                                '我喜欢的音乐',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                            ],
                                          )),
//                                  Text('我喜欢的音乐'),
//                                  Text('我喜欢的音乐'),
                                    ],
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                  height: 140,
                                  width: 104,
                                  color: const Color(0xffE5E5E5),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          top: 40,
                                          child: Column(
                                            children: <Widget>[
                                              Image.asset(
                                                'images/album/album_download.png',
                                                width: 24,
                                                height: 24,
                                                color: Colors.black,
                                              ),
                                              Gaps.vGap5,
                                              Text(
                                                '推歌精选',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                              ),
                                              Gaps.vGap24,
                                              Text(
                                                '云贝助力好歌',
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 10),
                                              ),
                                            ],
                                          )),
//                                  Text('我喜欢的音乐'),
//                                  Text('我喜欢的音乐'),
                                    ],
                                  )),
                            ),
                          ),
                          ImgItem(),
                          ImgItem(),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        height: 50,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Text('最近播放'),
                            Spacer(),
                            Text(
                              '更多',
                              style: TextStyles.textGray10,
                            ),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.grey,
                            )
                          ],
                        )),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class ImgItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          height: 140,
          width: 104,
          color: Colors.deepOrangeAccent,
          child: Text('xxx'),
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
      backgroundColor: Colors.transparent,
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
      expandedHeight: 170,
      //默认高度是状态栏和导航栏的高度，如果有滚动视差的话，要大于前两者的高度
      floating: false,
      //滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
      pinned: false,
      //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
      snap: false,
//      bottom: RoundedTabBar(),
      //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
      flexibleSpace: FlexibleDetailBar(
        background: Container(
          color: Colors.transparent,
        ),
//        background: FlexShadowBackground(
//          child: Image(
//              fit: BoxFit.cover,
//              image: NetworkImage(
//                  'https://dss2.bdstatic.com/6Ot1bjeh1BF3odCf/it/u=1676744405,540713731&fm=85&app=92&f=PNG?w=121&h=75&s=D385D70204BC4C2D515E34430300E0BB')),
//        ),
        content: Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          color: Colors.transparent,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Gaps.vGap24,
                Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 56,
                          height: 56,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    Gaps.hGap10,
                    Expanded(
                      child: Text('登录立享手机电脑多端同步'),
                    ),
                    Gaps.hGap10,
                    Container(
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 0, bottom: 0),
                      child: Text(
                        '立即登录',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle, // 默认值也是矩形
                        borderRadius: BorderRadius.circular((30.0)), // 圆角度
                        border: Border.all(color: Colors.grey, width: 0.5),
                      ),
                    ),
                  ],
                ),
                Spacer(),
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
          color: Colors.white,
          width: 20,
          height: 30,
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
    img: 'images/音乐.png',
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
    img: 'images/setting.png',
    path: '',
  ),
  const Menu(
    title: '关注新歌 ',
    img: 'images/album/album_share.png',
    path: '',
  ),
];
