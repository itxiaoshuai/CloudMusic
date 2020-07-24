import 'package:flutter_app/data/protocol/LeaderboardModel.dart';
import 'package:flutter_app/manager/request_manager.dart';
import 'package:flutter_app/provider/layout_state_refresh_list_model.dart';

class TopListModel extends LayoutStateRefreshListModel {
  @override
  Future<List> loadData() {
    return RequestManager.fetchTopList();
  }
}
