import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app/data/api/apis.dart';
import 'package:flutter_app/data/net/Http.dart';
import 'package:flutter_app/data/protocol/playlist_detail.dart';
import 'package:flutter_app/data/protocol/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MusicRepository {
  ///根据歌单id获取歌单详情，包括歌曲
  static Future<PlaylistDetail> playlistDetail(int id) async {
    final response = await Http().get(
      MusicApi.SONGLISTDETAILS,
      queryParameters: {"id": id},
    );
    print('response====$response');
    PlaylistDetail playlist = PlaylistDetail.fromJson(response["playlist"]);
    print('playlist====$playlist');
    var name = playlist.name;
    print('name====$name');
    return playlist;
  }

  /// 获取歌曲
  static logoin(String phone, String password) async {
    var result = await Http().get(MusicApi.LOGIN,
        queryParameters: {"phone": phone, "password": password});
    print(result.toString());
    if (result != null) {
      int uid = result['account']['id'];
      int vipType = result['account']['vipType'];
      int gender = result['profile']['gender'];
      String backgroundUrl = result['profile']['backgroundUrl'];
      String avatarUrl = result['profile']['avatarUrl'];
      String nickname = result['profile']['nickname'];

      Map<String, dynamic> userInfoMap = {
        "nickname": nickname,
        "uid": uid,
        "vipType": vipType,
        "gender": gender,
        "backgroundUrl": backgroundUrl,
        "avatarUrl": avatarUrl
      };
      UserInfo userInfo = UserInfo.fromJson(userInfoMap);

      var info = jsonEncode(userInfoMap);
      save(info.toString());
      print(info.toString());
      return userInfo;
    }
  }

  static save(String info) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userInfo", info);
  }
}
