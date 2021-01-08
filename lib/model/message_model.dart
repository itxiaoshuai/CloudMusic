import 'package:cloud_music/data/protocol/radio_hot.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageModel extends LayoutStateModel {
  HotRadio _hotRadio;

  var response;
  List get data => response.data['msgs'];
  loadData() async {
    setState(LayoutState.LOADING);

    response = await RequestManager.fetchMsg();
    if (response.data['code'] == 200) {
      setState(LayoutState.SUCCESS);
    }
  }
}
