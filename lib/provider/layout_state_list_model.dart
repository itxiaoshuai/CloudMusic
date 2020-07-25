import 'package:flutter_app/provider/layout_state.dart';

import 'layout_state_model.dart';

/// 基于
abstract class LayoutStateListModel<T> extends LayoutStateModel {
  // 加载数据
  Future<List<T>> loadData(Map<String, dynamic> formData);

  onCompleted(List<T> data) {}

  /// 页面数据
  List<T> list = [];

  /// 第一次进入页面loading skeleton

  initData(Map<String, dynamic> formData) async {
    setState(LayoutState.LOADING);
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    await refresh(init: true, formData: formData);
  }

  // 下拉刷新
  refresh({bool init = false, Map<String, dynamic> formData}) async {
    try {
      List<T> data = await loadData(formData);
      if (data.isEmpty) {
        list.clear();
        setState(LayoutState.EMPTY);
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        setState(LayoutState.SUCCESS);
      }
    } catch (e, s) {
      if (init) list.clear();
      print(e);
      print('zzzzzzzzzzzzzzzzzzzzzz');
      setError(e, s);
    }
  }
}
