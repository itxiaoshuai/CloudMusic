import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/protocol/user_detail_bean.dart';
import 'package:flutter_app/pages/album/comment_page.dart';
import 'package:flutter_app/pages/radio/page_radio_category.dart';
import 'package:flutter_app/pages/user/page_user_detail.dart';
import 'package:flutter_app/pages/user/page_user_home.dart';
import 'package:flutter_app/route/page_route_anim.dart';

class RouteName {
  static const String comment = 'comment';
  static const String RADIO_CATEGORY = 'radio_category';
  static const String USER_HOME = 'user_home'; //主页
}

class Router {
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
      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
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
