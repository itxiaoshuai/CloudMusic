/*
请求管理类
 */

import 'package:cloud_music/data/protocol/LeaderboardModel.dart';
import 'package:cloud_music/data/protocol/daily_recommend.dart';
import 'package:cloud_music/net/http.dart';
import 'package:cloud_music/data/protocol/lyric.dart';

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

  // Music
  static Future<String> getMusicURL(
      Map<String, dynamic> queryParameters) async {
    var response =
        await http.get('/song/url', queryParameters: queryParameters);
    return response.data['data'][0]["url"];
  }

  // 歌词
  static Future<LyricData> getLyricData(
      Map<String, dynamic> queryParameters) async {
    var response = await http.get('/lyric', queryParameters: queryParameters);
    return LyricData.fromJson(response.data);
    ;
  }

  //获取用户关注列表
  static Future fetchFollows(Map<String, dynamic> queryParameters) async {
    var response =
        await http.get('/user/follows', queryParameters: queryParameters);
    return response.data;
  }

  //获获取用户粉丝列表
  static Future fetchFans(Map<String, dynamic> queryParameters) async {
    var response =
        await http.get('/user/followeds', queryParameters: queryParameters);
    return response.data;
  }

  //每日推荐
  static Future<DailyRecommend> fetchRecommend() async {
    var response = await http.get('/recommend/songs');
    return DailyRecommend.fromJson(response.data);
  }
}
