import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';
import 'package:cloud_music/data/protocol/follows.dart';

class FriendAttentionModel extends LayoutStateModel {
  Follows _follows;
  Follows get data => _follows;
  loadData(Map<String, dynamic> queryParameters) {
    setState(LayoutState.LOADING);
    RequestManager.fetchFollows(queryParameters)
        .then((value) => handelData(value));
  }

  void handelData(value) {
    print(value);
    _follows = Follows.fromJson(value);
    setState(LayoutState.SUCCESS);
  }
}
