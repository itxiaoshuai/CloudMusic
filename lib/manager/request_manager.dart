/*
请求管理类
 */
import 'package:flutter/material.dart';
import 'package:flutter_app/data/protocol/LeaderboardModel.dart';
import 'package:flutter_app/data/protocol/playlist_detail.dart';
import 'package:flutter_app/net/huyi_android_api.dart';

class RequestManager {
  //获取榜单数据
  static Future<List<LeaderBoardList>> fetchTopList() async {
    var response = await http.get('/toplist/detail');
    var user = LeaderBoardModel.fromJson(response.data);
    List<LeaderBoardList> list = user.list;
    return list;
  }

  //获取榜单详情
  static Future fetchPlayList(int id) async {
    Map<String, dynamic> formData = {
      'id': id,
    };
    var response =
        await http.get('/playlist/detail', queryParameters: formData);
    return response.data;
  }

  //获取歌单评论
  static Future fetchCommentList(Map<String, dynamic> queryParameters) async {
    var response =
        await http.get('/comment/playlist', queryParameters: queryParameters);
    return response.data;
  }
}
