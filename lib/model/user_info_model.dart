import 'package:cloud_music/data/protocol/user_detail_bean.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';

class UserInfoModel extends LayoutStateModel {
  late UserDetail _userDetail;
  UserDetail get data => _userDetail;
  loadData(int id) async {
    Map<String, dynamic> formData = {'uid': id};
    setState(LayoutState.LOADING);
    _userDetail = await RequestManager.fetchUserInfo(formData);
    if (_userDetail.code == 200) {
      setState(LayoutState.SUCCESS);
    }
  }
}