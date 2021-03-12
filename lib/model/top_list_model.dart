import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state_refresh_list_model.dart';

class TopListModel extends LayoutStateRefreshListModel {
  @override
  Future<List> loadData() {
    return RequestManager.fetchTopList();
  }
}
