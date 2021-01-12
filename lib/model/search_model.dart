import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';
import 'package:cloud_music/data/protocol/cloud_storage_bean.dart';

class SearchModel extends LayoutStateModel {
  var response;
  var responseSearchHot;

  List get searchHotList => responseSearchHot.data['data'];
  var responseResult;

  List get searchResultList => responseResult.data['result']['songs'];

  //热门搜索
  loadSearchHot() async {
    setState(LayoutState.LOADING);

    responseSearchHot = await RequestManager.fetchSearchHot();
    if (responseSearchHot.data['code'] == 200) {
      setState(LayoutState.SUCCESS);
    }
  }

  loadSearch(Map<String, dynamic> queryParameters) async {
    setState(LayoutState.LOADING);

    responseResult = await RequestManager.fetchSearch(queryParameters);
    if (responseResult.data['code'] == 200) {
      setState(LayoutState.SUCCESS);
    }
  }
}
