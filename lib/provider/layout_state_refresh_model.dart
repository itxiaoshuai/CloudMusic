import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'layout_state_model.dart';

//没有加载更多的列表刷新页面
abstract class LayoutStateRefreshModel<T> extends LayoutStateModel {
  // 加载数据
  Future<T> loadData();

  onCompleted(T data) {}

  /// 第一次进入页面loading skeleton
  initData() async {
    await refresh(init: true);
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  // 下拉刷新
  refresh({bool init = false}) async {
    try {
      T data = await loadData();
      if (data == null) {
//        setEmpty();
      } else {
        onCompleted(data);
//        setIdle();
      }
    } catch (e, s) {
//      setError(e, s);
    }
  }
}
