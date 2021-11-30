import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';

class MessageModel extends LayoutStateModel {
  // HotRadio _hotRadio;

  var response;
  var responseNotices;

  List get data => response.data['msgs'];

  List get notices => responseNotices.data['notices'];

  loadData() async {
    setState(LayoutState.LOADING);

    response = await RequestManager.fetchMsg();
    if (response.data['code'] == 200) {
      setState(LayoutState.SUCCESS);
    }
  }

  loadNoticeData() async {
    setState(LayoutState.LOADING);

    responseNotices = await RequestManager.fetchNotices();

    if (responseNotices.data['code'] == 200) {
      setState(LayoutState.SUCCESS);
    }
  }
}
