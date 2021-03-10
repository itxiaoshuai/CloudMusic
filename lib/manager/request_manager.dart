/*
请求管理类
 */

import 'dart:convert';

import 'package:cloud_music/data/api/apis.dart';
import 'package:cloud_music/data/protocol/LeaderboardModel.dart';
import 'package:cloud_music/data/protocol/daily_recommend.dart';
import 'package:cloud_music/data/protocol/new_album.dart';
import 'package:cloud_music/data/protocol/radio_hot.dart';
import 'package:cloud_music/data/protocol/user_detail_bean.dart';
import 'package:cloud_music/data/protocol/user_info.dart';
import 'package:cloud_music/data/protocol/yun_task.dart';
import 'package:cloud_music/net/http.dart';
import 'package:cloud_music/data/protocol/lyric.dart';
import 'package:cloud_music/data/protocol/cloud_storage_bean.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Map<String, dynamic> formData = {
      'cookie':
          "__csrf=b15aeab9a6e210089642b95851797fd1; Max-Age=1296010; Expires=Thu, 21 Jan 2021 05:59:25 GMT; Path=/;;MUSIC_U=ba34296e04ecdf04df0d8c22e024f30c82204af2d83c4ebe53c2658d1fa849ab33a649814e309366; Max-Age=1296000; Expires=Thu, 21 Jan 2021 05:59:15 GMT; Path=/;;__remember_me=true; Max-Age=1296000; Expires=Thu, 21 Jan 2021 05:59:15 GMT; Path=/;",
    };
    var response =
        await http.get('/recommend/songs', queryParameters: formData);
    return DailyRecommend.fromJson(response.data);
  }

  //云盘
  static Future<CloudStorageBean> fetchCloud() async {
    var response = await http.get('/user/cloud');
    return CloudStorageBean.fromJson(response.data);
  }

  //云呗任务
  static Future<YunCoinTask> fetchTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formData = {
      'cookie': prefs.get('cookie'),
    };
    var response = await http.get('/yunbei/tasks', queryParameters: formData);
    return YunCoinTask.fromJson(response.data);
  }

  //新碟上架
  static Future<NewAlbum> fetchNewPlate() async {
    var response = await http.get('/album/newest');
    return NewAlbum.fromJson(response.data);
  }

  //电台
  static Future<HotRadio> fetchRadioById(int id) async {
    var response = await http.get('/dj/radio/hot?cateId=${id}');
    return HotRadio.fromJson(response.data);
  }

  //电台 - 最热主播榜
  static Future fetchRadioRank() async {
    var response = await http.get('/dj/toplist/popular?limit=3');
    return response;
  }

  //通知 - 私信
  static Future fetchMsg() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formData = {
      'cookie': prefs.get('cookie'),
    };
    var response = await http.get('/msg/private', queryParameters: formData);
    return response;
  }

  //通知 - 私信
  static Future fetchNotices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formData = {
      'cookie': prefs.get('cookie'),
    };
    var response = await http.get('/msg/notices', queryParameters: formData);
    return response;
  }

  //数字专辑-语种风格馆
  static Future fetchAlbumList(Map<String, dynamic> queryParameters) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // Map<String, dynamic> formData = {
    //   'cookie': prefs.get('cookie'),
    // };
    var response =
        await http.get('/album/list/style', queryParameters: queryParameters);
    return response;
  }

  static Future fetchAlbumDetail(Map<String, dynamic> queryParameters) async {
    var response =
        await http.get('/album/detail', queryParameters: queryParameters);
    return response;
  }

  static Future fetchAlbumComment(Map<String, dynamic> queryParameters) async {
    var response =
        await http.get('/comment/album', queryParameters: queryParameters);
    return response;
  }

  //热搜列表(简略)
  static Future fetchSearchHot() async {
    var response = await http.get('/search/hot/detail');
    return response;
  }

  static Future fetchSearch(Map<String, dynamic> queryParameters) async {
    var response =
        await http.get('/cloudsearch', queryParameters: queryParameters);
    return response;
  }

  static Future fetchUserInfo(Map<String, dynamic> queryParameters) async {
    var response =
        await http.get('/user/detail', queryParameters: queryParameters);
    return UserDetail.fromJsonMap(response.data);
  }

  //获取用户动态
  static Future fetchDynamic(Map<String, dynamic> queryParameters) async {
    var response =
        await http.get('/user/event', queryParameters: queryParameters);
    return response;
  }

  static logoin(String phone, String password) async {
    var result = await http.get(MusicApi.LOGIN,
        queryParameters: {"phone": phone, "password": password});
    if (result != null) {
      print(result);
      int uid = result.data['account']['id'];
      int vipType = result.data['account']['vipType'];
      int gender = result.data['profile']['gender'];
      String backgroundUrl = result.data['profile']['backgroundUrl'];
      String avatarUrl = result.data['profile']['avatarUrl'];
      String nickname = result.data['profile']['nickname'];
      String cookie = result.data['cookie'];
      Map<String, dynamic> userInfoMap = {
        "nickname": nickname,
        "uid": uid,
        "vipType": vipType,
        "gender": gender,
        "backgroundUrl": backgroundUrl,
        "avatarUrl": avatarUrl,
        "cookie": cookie
      };
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("cookie", cookie);
      UserInfo userInfo = UserInfo.fromJson(userInfoMap);
      var info = jsonEncode(userInfoMap);
      save(info.toString());
      print(info.toString());
      return userInfo;
    }
  }

  static save(String info) async {}
}
