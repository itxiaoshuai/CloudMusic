import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';

class CommentModel extends LayoutStateModel {
  // HotRadio _hotRadio;

  var response;
  var responseComments;

  List get data => response.data['msgs'];

  List get comments => responseComments.data['comments'];

  loadData() async {
    setState(LayoutState.LOADING);

    response = await RequestManager.fetchMsg();
    if (response.data['code'] == 200) {
      setState(LayoutState.SUCCESS);
    }
  }

  loadNoticeData() async {
    setState(LayoutState.LOADING);

    responseComments = await RequestManager.fetchComment();

    if (responseComments.data['code'] == 200) {
      setState(LayoutState.SUCCESS);
    }
  }
}
