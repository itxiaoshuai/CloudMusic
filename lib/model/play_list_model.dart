import 'package:cloud_music/provider/layout_state_model.dart';
import 'package:cloud_music/data/protocol/playlist.dart';
import 'package:cloud_music/net/http.dart';
import 'package:cloud_music/provider/layout_state.dart';

class PlayListModel extends LayoutStateModel {
  Playlist _playlist;

  Playlist get data => _playlist;

  loadData(int id) async {
    Map<String, dynamic> formData = {'id': id, "s": 8};

    try {
      setState(LayoutState.LOADING);
      var response =
          await http.get('/playlist/detail', queryParameters: formData);
      Playlist playlistDetail = Playlist.fromJson(response.data['playlist']);
      _playlist = playlistDetail;
      setState(LayoutState.SUCCESS);
    } catch (e) {
      print(e);
    }
  }
}
