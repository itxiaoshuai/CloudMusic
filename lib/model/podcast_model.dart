import 'package:cloud_music/data/protocol/radio_hot.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:cloud_music/provider/layout_state_model.dart';

class PodcastModel extends LayoutStateModel {
  HotRadio _hotRadio;

  List<DjRadios> get data => _hotRadio.djRadios.sublist(0,6);
  loadData(int id) async {
    setState(LayoutState.LOADING);
    _hotRadio = await RequestManager.fetchRadioById(id);
    if (_hotRadio.code == 200) {
      setState(LayoutState.SUCCESS);
    }
  }
}
