/*
请求管理类
 */
import 'package:flutter/material.dart';
import 'package:flutter_app/data/protocol/LeaderboardModel.dart';
import 'package:flutter_app/net/huyi_android_api.dart';

class RequestManager {
  //获取榜单数据
  static Future<List<LeaderBoardList>> fetchTopList() async {
    var response = await http.get('/toplist/detail');
    var user = LeaderBoardModel.fromJson(response.data);
    List<LeaderBoardList> list = user.list;
    return list;
  }
}
