import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';

class DigitalAlbumModel extends LayoutStateModel {
  // DailyRecommend _dailyRecommend;
  //
  var response;
  var responseAlbumDetail;
  var responseAlbumComment;
  List get albumList => response.data['albumProducts'];

  get albumDetail => responseAlbumDetail.data;

  String descr = "";
  loadData(Map<String, dynamic> queryParameters) async {
    setState(LayoutState.LOADING);
    response = await RequestManager.fetchAlbumList(queryParameters);
    if (response.data['code'] == 200) {
      setState(LayoutState.SUCCESS);
    }
  }

  loadAlbumDetail(Map<String, dynamic> queryParameters) async {
    setState(LayoutState.LOADING);
    responseAlbumDetail =
    await RequestManager.fetchAlbumDetail(queryParameters);
    if (responseAlbumDetail.data['code'] == 200) {
      List list = responseAlbumDetail.data['product']['descr'];

      list.forEach((element) {
        descr = descr + element['resource'];
      });
      setState(LayoutState.SUCCESS);
    }
  }

  loadAlbumComment(Map<String, dynamic> queryParameters) async {
    setState(LayoutState.LOADING);
    responseAlbumComment =
    await RequestManager.fetchAlbumComment(queryParameters);
    if (responseAlbumComment.data['code'] == 200) {
      setState(LayoutState.SUCCESS);
    }
  }
}
