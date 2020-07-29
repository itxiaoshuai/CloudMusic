import 'package:flutter_app/data/protocol/playlist_detail.dart';
import 'package:flutter_app/manager/request_manager.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
import 'package:flutter_app/provider/layout_state.dart';
import 'package:flutter_app/provider/layout_state_model.dart';

class PlayListModel extends LayoutStateModel {
  PlaylistDetail _playlistDetail;

  PlaylistDetail get data => _playlistDetail;

  loadData(int id) async {
    Map<String, dynamic> formData = {'id': id, "s": 8};

    try {
      setState(LayoutState.LOADING);
      var response =
          await http.get('/playlist/detail', queryParameters: formData);
      PlaylistDetail playlistDetail =
          PlaylistDetail.fromJson(response.data['playlist']);
      _playlistDetail = playlistDetail;
      setState(LayoutState.SUCCESS);
    } catch (e, s) {}
  }
}
