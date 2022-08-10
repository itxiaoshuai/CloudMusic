import 'dart:convert';

import 'package:cloud_music/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/data/protocol/user_info.dart';
import 'package:cloud_music/pages/login/LoginMainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'item/DrawerListItem.dart';

class HomeDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State {
  UserInfo userInfo = UserInfo();

  @override
  void initState() {
    //黑色
//    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
    _getLocalUser();
  }

  _getLocalUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userInfoStr = pref.getString('userInfo');

    if (userInfoStr != null) {
      setState(() {
        userInfo = UserInfo.fromJson(jsonDecode(userInfoStr));
        print(userInfo.toString());
      });
    }
  }

  _buildDrawerVIP(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          //圆形渐变
          color: Color(0xFF999999),
          shape: BoxShape.rectangle,
        ),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '开通黑胶VIP',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text('立享超17项专属特权',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Colors.grey[100],
                                        fontWeight: FontWeight.w100,
                                        fontSize: 10)),
                            Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 20,
                              color: Colors.grey[400],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Container(
                      padding:
                          EdgeInsets.only(top: 2, bottom: 2, left: 6, right: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 0.5),
                        shape: BoxShape.rectangle,
                        // 默认值也是矩形
                        borderRadius: BorderRadius.circular((20.0)), // 圆角度
                      ),
                      margin: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        '会员中心',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontSize: 12),
                      ),
                    )
                  ],
                ),
              ],
            ),
            Gaps.vGap4,
            Gaps.line,
            Gaps.vGap4,
            Row(
              children: [
                Text('黑胶VIP仅5元！ 每天低至0.16...',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.grey[100],
                        fontWeight: FontWeight.w100,
                        fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildMusicLike(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Column(
        children: [
          DrawerListItem(
            image: "images/drawer_music.png",
            text: "我的消息",
            route: RouteName.PAGE_MESSAGE,
          ),
          Gaps.line,
          DrawerListItem(
            image: "images/cloud_center.png",
            text: "云贝中心",
            route: RouteName.PAGE_CLOUD_COIN,
          ),
        ],
      ),
    );
  }

  _buildMusicService(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Container(
          child: Column(
            children: [
              DrawerListItem(image: "images/ticket.png", text: "云村有票"),
              DrawerListItem(image: "images/shopping_cart.png", text: "商城"),
              DrawerListItem(image: "images/game.png", text: "游戏专区"),
              DrawerListItem(image: "images/pocket_ringtone.png", text: "口袋彩铃"),
            ],
          ),
        ));
  }

  _buildMusicOther(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Container(
          child: Column(
            children: [
              DrawerListItem(
                image: "images/setting.png",
                text: "设置",
                route: RouteName.PAGE_SETTING,
              ),
              DrawerListItem(image: "images/night_mode.png", text: "夜间模式"),
              DrawerListItem(image: "images/timing.png", text: "定时关闭"),
              DrawerListItem(image: "images/drawer_skin.png", text: "个性装扮"),
              DrawerListItem(image: "images/ticket.png", text: "边听边存"),
              DrawerListItem(
                  image: "images/music_free_flow.png", text: "在线听歌免流量"),
              DrawerListItem(image: "images/game.png", text: "音乐黑名单"),
              DrawerListItem(image: "images/bodyguard.png", text: "青少年模式"),
              DrawerListItem(image: "images/alarm.png", text: "音乐闹钟"),
            ],
          ),
        ));
  }

  _buildDrawerBottom(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Container(
          child: Column(
            children: [
              DrawerListItem(image: "images/order.png", text: "我的订单"),
              DrawerListItem(image: "images/coupon.png", text: "优惠券"),
              DrawerListItem(image: "images/help.png", text: "帮助与反馈"),
              DrawerListItem(image: "images/drawer_skin.png", text: "分享网易云音乐"),
              DrawerListItem(image: "images/about.png", text: "关于"),
            ],
          ),
        ));
  }

  _buildDrawerBottomButton(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: Container(
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 10),
                height: 45.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        '关于云音乐',
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
//    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Drawer(
      child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            elevation: 0,
            //去掉阴影
            backgroundColor: Colors.grey[100],
            automaticallyImplyLeading: false,
            title: Container(
              child: DrawerAppBar(),
            ),
            centerTitle: false,
            actions: <Widget>[
              IconButton(
                icon: Image.asset(
                  'images/icon_qr.png',
                  width: 24,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                    ),
                    child: ListView(
                      children: [
                        _buildDrawerVIP(context),
                        Gaps.vGap10,
                        _buildMusicLike(context),
                        Gaps.vGap10,
                        _buildMusicService(context),
                        Gaps.vGap10,
                        _buildMusicOther(context),
                        Gaps.vGap10,
                        _buildDrawerBottom(context),
                        Gaps.vGap10,
                        _buildDrawerBottomButton(context),
                        Gaps.vGap30,
                        // DrawerTopLogin(),
                      ],
                    )),
              ),
              // DrawerBottom(),
            ],
          )),
    );
  }
}

class DrawerAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return LoginMainPage(); //手机号登入
        }));
      },
      child: Container(
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              child: Icon(
                Icons.person_outline_outlined,
                size: 20,
                color: Colors.black,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2), // 边色与边宽度
                color: Colors.redAccent[50], // 底色
                //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                shape: BoxShape.circle, // 默认值也是矩形
                // borderRadius: new BorderRadius.circular((20.0)), // 圆角度
              ),
            ),
            Gaps.hGap10,
            Text('立即登录',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                )),
            Icon(
              Icons.arrow_forward_ios,
              size: 10,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
    return Container(
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            child: Icon(
              Icons.person_outline_outlined,
              size: 20,
              color: Colors.black,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2), // 边色与边宽度
              color: Colors.redAccent[50], // 底色
              //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
              shape: BoxShape.circle, // 默认值也是矩形
              // borderRadius: new BorderRadius.circular((20.0)), // 圆角度
            ),
          ),
          Gaps.hGap10,
          Text('立即登录',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              )),
          Icon(
            Icons.arrow_forward_ios,
            size: 10,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}

//横向排列的item
class DrawerListItemHorizontal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
          children: [
            ListItem(image: "images/drawer_message.png", text: "我的消息"),
            ListItem(image: "images/drawer_friend.png", text: "我的好友"),
            ListItem(image: "images/drawer_skin.png", text: "个性皮肤"),
            ListItem(image: "images/drawer_music.png", text: "听歌识曲"),
          ]),
    );
  }
}

class ListItem extends StatelessWidget {
  final String text;
  final String image;

  ListItem({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image,
          color: Theme.of(context).primaryColor,
          width: 25,
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

class LoginHead extends StatelessWidget {
  final UserInfo userInfo;

  LoginHead({
    required this.userInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200]!.withOpacity(0.8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 50, left: 15),
            child: InkWell(
              child: CircleAvatar(
                backgroundImage: NetworkImage(userInfo.avatarUrl!),
                backgroundColor: Colors.black,
                radius: 30.0,
              ),
              onTap: () {},
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 15, left: 15, bottom: 50),
              child: Row(
                children: <Widget>[
                  Text(
                    userInfo.nickname!,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

//登入部分
class DrawerTopLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      child: Material(
        color: Colors.white,
        elevation: 0,
        child: Column(
          children: [
            Gaps.vGap30,
            Text(
              '手机电脑多端同步,尽享海量高品质音乐',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
            Gaps.vGap15,
            Container(
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return LoginMainPage(); //手机号登入
                  }));
                },
                color: Colors.red,
                padding: EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  "立即登录",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                //一个边框，适合体育场形状的边框（两端有半圆的框），适用于它所应用的小部件的矩形
              ),
            ),
            Gaps.vGap15,
            DrawerListItemHorizontal(),
            Gaps.vGap15,
            Container(
              margin:
                  const EdgeInsets.only(top: 0, bottom: 0, left: 15, right: 15),
              child: Center(
                child: Divider(
                  height: 0.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UnLoginHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _login() {
      print("点击了登入按钮");
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return LoginMainPage();
      }));
    }

    return Container(
        color: Colors.grey[200]!.withOpacity(0.8),
        child: Container(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '手机电脑多端同步,尽享海量高品质音乐',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    )
                  ]),
              Container(
                margin: EdgeInsets.only(top: 14, bottom: 50),
                child: OutlinedButton(
                  onPressed: _login,

                  // padding: EdgeInsets.only(left: 45, right: 45),
                  child: Text(
                    "立即登录",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  // shape: StadiumBorder(
                  //   side: BorderSide(width: 16.0, color: Colors.grey),
                  // ),

                  //一个边框，适合体育场形状的边框（两端有半圆的框），适用于它所应用的小部件的矩形
                  // borderSide: BorderSide(color: Colors.grey), //默认边框颜色
                ),
              )
            ],
          ),
        ));
  }
}
