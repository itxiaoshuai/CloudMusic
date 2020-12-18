
import 'package:cloud_music/data/protocol/playlist_detail.dart';
import 'package:cloud_music/net/huyi_android_api.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';
import 'package:dio/dio.dart';


class PlayListModel extends LayoutStateModel {
  PlaylistDetail _playlistDetail;

  PlaylistDetail get data => _playlistDetail;

  loadData(int id) async {
    Map<String, dynamic> formData = {
      'id': id,
      "s": 8,
      "cookie":
          "ba34296e04ecdf04df0d8c22e024f30c95f36294cb7ee79c61e4fae6b7f8bb4c33a649814e309366",
    };

    try {
      setState(LayoutState.LOADING);

      Map headers = new Map();
      headers['Cookie'] =
          "ba34296e04ecdf04df0d8c22e024f30c95f36294cb7ee79c61e4fae6b7f8bb4c33a649814e309366";
      Options options = Options(headers: headers);
      var response = await http.get('/playlist/detail',
          queryParameters: formData, options: options);
      response.data['playlist']['tracks'].forEach((v) {
        print('xxxxxxxxxxxxxtracks${v['name']}');
      });
      response.data['playlist']['trackIds'].forEach((v) {
        print('xxxxxxxxxxxxxtracks${v['id']}');
      });
      PlaylistDetail playlistDetail =
          PlaylistDetail.fromJson(response.data['playlist']['tracks']);
      _playlistDetail = playlistDetail;
      setState(LayoutState.SUCCESS);
    } catch (e, s) {}
  }
}
