import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';
import 'package:cloud_music/data/protocol/cloud_storage_bean.dart';
class CloudListModel extends LayoutStateModel {
  CloudStorageBean _cloudStorageBean;

  CloudStorageBean get data => _cloudStorageBean;
  loadData(Map<String, dynamic> queryParameters) async {
    setState(LayoutState.LOADING);

    _cloudStorageBean = await RequestManager.fetchCloud();
    if (_cloudStorageBean.code == 200) {
      setState(LayoutState.SUCCESS);
    }
  }
}