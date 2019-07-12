import 'package:flutter_app/data/api/apis.dart';
import 'package:flutter_app/data/net/Http.dart';
import 'package:flutter_app/data/protocol/playlist_detail.dart';

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
}
