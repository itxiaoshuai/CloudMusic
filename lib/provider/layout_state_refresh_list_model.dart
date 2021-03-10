import 'package:flutter/material.dart';
import 'package:cloud_music/provider/layout_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'layout_state_model.dart';

//没有加载更多的列表刷新页面
abstract class LayoutStateRefreshListModel<T> extends LayoutStateModel {
  // 加载数据
  Future<List<T>> loadData();

  onCompleted(List<T> data) {}

  /// 页面数据
  List<T> list = [];

  /// 第一次进入页面loading skeleton
  initData() async {
    await refresh(init: true);
  }

  // 下拉刷新
  refresh({bool init = false}) async {
    try {
      List<T> data = await loadData();
      if (data.isEmpty) {
        list.clear();
      } else {
        onCompleted(data);
        list.clear();
        list.addAll(data);
        setState(LayoutState.SUCCESS);
      }
    } catch (e, s) {
      //加载出错清空数据
      if (init) list.clear();
    }
  }
}
