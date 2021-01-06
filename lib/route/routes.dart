import 'package:cloud_music/pages/album/page_digital_album.dart';
import 'package:cloud_music/pages/drawer/page_yunbei.dart';
import 'package:cloud_music/pages/find/PageDailySpecial.dart';
import 'package:cloud_music/pages/login/page_phone_login.dart';
import 'package:cloud_music/pages/my/page_friend.dart';
import 'package:cloud_music/pages/play_songs/page_play_songs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_music/data/protocol/user_detail_bean.dart';
import 'package:cloud_music/pages/album/comment_page.dart';
import 'package:cloud_music/pages/radio/page_radio_category.dart';
import 'package:cloud_music/pages/user/page_user_detail.dart';
import 'package:cloud_music/pages/user/page_user_home.dart';
import 'package:cloud_music/route/page_route_anim.dart';
import 'package:cloud_music/pages/my/page_cloud_storage.dart';
import 'package:cloud_music/pages/leaderboard/LeaderboardPage.dart';
class RouteName {
  static const String comment = 'comment';
  static const String RADIO_CATEGORY = 'radio_category';
  static const String USER_HOME = 'user_home'; //主页
  static const String PAGE_SONGS = 'page_songs'; //播放页面
  static const String PAGE_FRIEND = 'page_friend'; //我的好友
  static const String PAGE_LOGIN_PHONE = 'page_login_phone'; //手机号登入
  static const String PAGE_CLOUD_STORAGE = 'cloud_storage'; //云盘
  static const String PAGE_CLOUD_COIN = 'cloud_coin'; //云呗
  static const String PAGE_DIGITAL_ALBUM = 'page_digital_album'; //数字专辑
  static const String PAGE_RANKING_LIST = 'ranking_list'; //排行榜
  static const String PAGE_DAILY_RECOMMEND = 'daily_recommend'; //每日推荐
}

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.comment:
        int id = settings.arguments;
        return NoAnimRouteBuilder(CommentPage(id));
      case RouteName.RADIO_CATEGORY:
        return NoAnimRouteBuilder(RadioCategoryPage());
      case RouteName.USER_HOME:
        var userId = settings.arguments;

        return NoAnimRouteBuilder(UserDetailPage(
          userId: userId,
        ));
      case RouteName.PAGE_SONGS:
        return NoAnimRouteBuilder(PlaySongsPage());
      case RouteName.PAGE_FRIEND:
        return NoAnimRouteBuilder(FriendPage());
      case RouteName.PAGE_LOGIN_PHONE:
        return NoAnimRouteBuilder(PhoneLoginPage());
      case RouteName.PAGE_CLOUD_STORAGE:
        return NoAnimRouteBuilder(CloudStoragePage());
      case RouteName.PAGE_CLOUD_COIN:
        return NoAnimRouteBuilder(YunBeiPage());
      case RouteName.PAGE_DIGITAL_ALBUM:
        return NoAnimRouteBuilder(DigitalAlbumPage());
      case RouteName.PAGE_RANKING_LIST:
        return NoAnimRouteBuilder(LeaderBoardPage());
      case RouteName.PAGE_DAILY_RECOMMEND:
        return NoAnimRouteBuilder(PageDailySpecial());
      default:
        return CupertinoPageRoute(
            builder: (_) =>
                Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}

/// Pop路由
class PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;
}
