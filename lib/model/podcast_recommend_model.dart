import 'package:cloud_music/data/protocol/radio_hot.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';

class PodcastRecommendModel extends LayoutStateModel {
  // HotRadio _hotRadio;
  //
  List get data => response.data['data']['list'];
  var response;
  loadData() async {
    setState(LayoutState.LOADING);
    response = await RequestManager.fetchRadioRank();
    if (response.data['code'] == 200) {
      setState(LayoutState.SUCCESS);
    }
  }
}
