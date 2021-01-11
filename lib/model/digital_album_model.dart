import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';

class DigitalAlbumModel extends LayoutStateModel {
  // DailyRecommend _dailyRecommend;
  //
  var response;
  List get albumList => response.data['albumProducts'];
  loadData(Map<String, dynamic> queryParameters) async {
    setState(LayoutState.LOADING);
    response = await RequestManager.fetchAlbumList(queryParameters);
    if (response.data['code'] == 200) {
      setState(LayoutState.SUCCESS);
    }
  }
}
