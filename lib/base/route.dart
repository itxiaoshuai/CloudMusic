import 'package:cloud_music/pages/leaderboard/LeaderboardPage.dart';
import 'package:cloud_music/pages/login/LoginMainPage.dart';
import 'package:cloud_music/pages/main/page_main.dart';
import 'package:flutter/material.dart';


const ROUTE_MAIN = "/";
const ROUTE_LOGIN = "/login";
const ROUTE_LEADERBOARD = "/leaderboard";

///app routers
final Map<String, WidgetBuilder> routes = {
  ROUTE_MAIN: (context) => MainPage(), //首页
  ROUTE_LOGIN: (context) => LoginMainPage(), //登入页
  ROUTE_LEADERBOARD: (context) => LeaderBoardPage(), //排行榜
};
