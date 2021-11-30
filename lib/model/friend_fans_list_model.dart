import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';
import 'package:cloud_music/data/protocol/fans.dart';
class FriendFansModel extends LayoutStateModel {
  late Fans _follows;
  Fans get data => _follows;
  loadData(Map<String, dynamic> queryParameters) {
    setState(LayoutState.LOADING);
    RequestManager.fetchFans(queryParameters)
        .then((value) => handelData(value));
  }

  void handelData(value) {
    print(value);
    _follows = Fans.fromJson(value);
    setState(LayoutState.SUCCESS);
  }
}
