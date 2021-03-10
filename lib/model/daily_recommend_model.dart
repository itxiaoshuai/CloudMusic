import 'package:cloud_music/data/protocol/daily_recommend.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';

class DailyRecommendModel extends LayoutStateModel {
  DailyRecommend _dailyRecommend;

  DailyRecommend get data => _dailyRecommend;
  loadData() async {
    setState(LayoutState.LOADING);
    _dailyRecommend = await RequestManager.fetchRecommend();
    if (_dailyRecommend.code == 200) {
      setState(LayoutState.SUCCESS);
    }
  }
}
