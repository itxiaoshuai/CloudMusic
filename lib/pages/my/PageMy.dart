import 'dart:ui';

import 'package:cloud_music/base/CommonLoading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/base/ConstImg.dart';
import 'package:cloud_music/base/res/colors.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/data/api/apis.dart';
import 'package:cloud_music/data/protocol/playlist.dart';
import 'package:cloud_music/net/http.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:cloud_music/widget/HomeDrawer.dart';
import 'package:cloud_music/widget/base_song_img_item.dart';
import 'package:cloud_music/widget/flexible_app_bar.dart';
import 'package:cloud_music/widget/item/menu_item.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:cloud_music/widget/RoundUnderlineTabIndicator.dart';
import 'package:cloud_music/widget/CustomRRecTabIndicator.dart';
import 'package:cloud_music/widget/CustomUnderlineTabIndicator.dart';
import '../../r.dart';
import 'package:cached_network_image/cached_network_image.dart';

List widgets = [];

class MyPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Playlist playlist;
  TabController tabController;
  var tabs = <Tab>[];
  List<Playlist> mListData = [];
  List<Playlist> mCreatedListData = [];
  List<Playlist> mSubscribedListData = [];

  @override
  void initState() {
    super.initState();

    getSongListRecommend();
    initData();
    tabs = <Tab>[
      Tab(
        text: "创建歌单 ",
      ),
      Tab(
        text: "收藏歌单",
      ),
    ];
    this.tabController = TabController(length: tabs.length, vsync: this);
  }

  Future<void> initData() async {
    Map<String, dynamic> formData = {
      'uid': 1521312765,
    };
    var response = await http.get('/user/playlist', queryParameters: formData);

//    playlistDetail = PlaylistDetail.fromJson(response.data['playlist']);
    mListData = (response.data["playlist"] as List)
        .cast<Map>()
        .map((e) => Playlist.fromJson(e))
        .toList();

    print(mListData.length);
    mListData.forEach((item) {
      if(item.subscribed){
        mSubscribedListData.add(item);
      }else{
        mCreatedListData.add(item);
      }
    });
    setState(() {});
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

  //底部导航栏显示的内容
  final List<Widget> bottomNavItems = [
    MenuItem(image: "images/find/t_dragonball_icn_daily.png", text: "本地/下载"),
    MenuItem(
      image: "images/find/t_dragonball_icn_daily.png",
      text: "云盘",
      route: RouteName.PAGE_CLOUD_STORAGE,
    ),
    MenuItem(
      image: "images/find/t_dragonball_icn_daily.png",
      text: "已购",
    ),
    MenuItem(image: "images/find/t_dragonball_icn_daily.png", text: "最近播放"),
    MenuItem(
      image: "images/find/t_dragonball_icn_daily.png",
      text: "我的好友",
      route: RouteName.PAGE_FRIEND,
    ),
    MenuItem(image: "images/find/t_dragonball_icn_daily.png", text: "收藏和赞"),
    MenuItem(image: "images/find/t_dragonball_icn_daily.png", text: "我的播客"),
  ];

  _buildMenu(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        // 底色
        //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
        shape: BoxShape.rectangle,
        // 默认值也是矩形
        borderRadius: BorderRadius.circular((8.0)), // 圆角度
      ),
      child: GridView.count(
        shrinkWrap: true,
        //水平子Widget之间间距
        crossAxisSpacing: 10.0,
        //垂直子Widget之间间距
        //GridView内边距
        //一行的Widget数量
        crossAxisCount: 4,
        //子Widget列表
        children: bottomNavItems,
      ),
    );
  }

  _buildHead(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      child: Row(
        children: [
          Gaps.hGap28,
          Container(
            height: 50,
            width: 50,
            child: Icon(
              Icons.person_outline_outlined,
              size: 30,
            ),
            decoration: new BoxDecoration(
              border: new Border.all(color: Colors.white, width: 2), // 边色与边宽度
              color: Colors.redAccent[50], // 底色
              //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
              shape: BoxShape.circle, // 默认值也是矩形
              // borderRadius: new BorderRadius.circular((20.0)), // 圆角度
            ),
          ),
          Gaps.hGap15,
          Text('立即登录',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Icon(
            Icons.arrow_forward_ios,
            size: 15,
          )
        ],
      ),
    );
  }

  _buildMusicLike(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        // 底色
        //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
        shape: BoxShape.rectangle,
        // 默认值也是矩形
        borderRadius: BorderRadius.circular((8.0)), // 圆角度
      ),
      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Row(
        children: [
          Container(
              width: 50,
              height: 50,
              child: Icon(
                Icons.ac_unit_outlined,
                size: 30,
                color: Colors.grey[50],
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
                // 底色
                shape: BoxShape.rectangle,
                // 默认值也是矩形
                borderRadius: BorderRadius.circular((8.0)), // 圆角度
              )),
          Gaps.hGap10,
          Column(
            //左对齐
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('我喜欢的音乐'),
              Text('0首'),
            ],
          )
        ],
      ),
    );
  }

  _buildTable(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
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
    );
  }

  _buildBottomListWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // 底色
            //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
            shape: BoxShape.rectangle,
            // 默认值也是矩形
            borderRadius: BorderRadius.circular((8.0)), // 圆角度
          ),
          margin: EdgeInsets.only(left: 15, right: 15),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //左对齐
                  children: [
                    Text('创建歌单'),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.more_vert,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gaps.vGap15,
                Container(
//                  color: color,
                  child: Column(
                    children: mCreatedListData.map((e) {
                      return Container(
                        height: 60,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Center(
                                child: Container(
                              width: 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: e.coverImgUrl,
                                  placeholder: (context, url) => ProgressView(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            )),
                            Expanded(
                              child: Container(
//                                color: Colors.amberAccent,
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 8),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
                                    children: [
                                      Expanded(
                                        child: Container(
//                      color: Colors.green,
                                            child: Center(
                                          child: Align(
                                            alignment:
                                                FractionalOffset.centerLeft,
                                            child: Text(
                                              e.name,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )),
                                      ),
                                      Expanded(
                                        child: Container(
//                                            color: Colors.green,
                                            child: Center(
                                          child: Align(
                                            alignment:
                                                FractionalOffset.centerLeft,
                                            child: Text(
                                              '${e.trackCount}首',
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.grey[600]),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )),
                                      ),
                                    ]),
                              ),
                            ),
                            Material(
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.more_vert,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  children: [
                    Container(
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.grey,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          // 底色
                          //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                          shape: BoxShape.rectangle,
                          // 默认值也是矩形
                          borderRadius: BorderRadius.circular((8.0)), // 圆角度
                        )),
                    Text('导入外部歌曲'),
                  ],
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            // 底色
            //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
            shape: BoxShape.rectangle,
            // 默认值也是矩形
            borderRadius: BorderRadius.circular((8.0)), // 圆角度
          ),
          margin: EdgeInsets.only(left: 15, right: 15, top: 10),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //左对齐
                  children: [
                    Text('收藏歌单'),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.more_vert,
                            size: 30,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Gaps.vGap15,
                Container(
//                  color: color,
                  child: mSubscribedListData.length>0?Column(
                    children: mSubscribedListData.map((e) {
                      return Container(
                        height: 60,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Center(
                                child: Container(
                                  width: 40,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      imageUrl: e.coverImgUrl,
                                      placeholder: (context, url) => ProgressView(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                )),
                            Expanded(
                              child: Container(
//                                color: Colors.amberAccent,
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 8),
                                child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
                                    children: [
                                      Expanded(
                                        child: Container(
//                      color: Colors.green,
                                            child: Center(
                                              child: Align(
                                                alignment:
                                                FractionalOffset.centerLeft,
                                                child: Text(
                                                  e.name,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )),
                                      ),
                                      Expanded(
                                        child: Container(
//                                            color: Colors.green,
                                            child: Center(
                                              child: Align(
                                                alignment:
                                                FractionalOffset.centerLeft,
                                                child: Text(
                                                  '${e.trackCount}首,by ${e.creator.nickname}',
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      color: Colors.grey[600]),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )),
                                      ),
                                    ]),
                              ),
                            ),
                            Material(
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.more_vert,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ):   Text('暂无收藏歌曲'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHead(context),
            _buildMenu(context),
            _buildMusicLike(context),
            _buildTable(context),
            _buildBottomListWidget(context),
            // _DetailPage(),
          ],
        ),
      ),
    );

    return super.build(context);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return _DetailPage();
  // }

  @override
  bool get wantKeepAlive => true;
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
          image: 'images/album/album_download.png',
          text: 'R.mipmap.dailySpecial',
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
