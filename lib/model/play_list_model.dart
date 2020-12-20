import 'package:flutter_app/data/protocol/playlist.dart';
import 'package:flutter_app/net/http.dart';
import 'package:flutter_app/provider/layout_state.dart';
import 'package:flutter_app/provider/layout_state_model.dart';

class PlayListModel extends LayoutStateModel {
  Playlist _playlist;

  Playlist get data => _playlist;

  loadData(int id) async {
    Map<String, dynamic> formData = {'id': id, "s": 8};

    try {
      setState(LayoutState.LOADING);
      var response =
          await http.get('/playlist/detail', queryParameters: formData);
      Playlist playlistDetail =
      Playlist.fromJson(response.data['playlist']);
      _playlist = playlistDetail;
      setState(LayoutState.SUCCESS);
    } catch (e, s) {}
  }
}
