import 'layout_state_model.dart';

/// 基于
abstract class ViewStateListModel<T> extends LayoutStateModel {
  // 加载数据
  Future<List<T>> loadData();

  onCompleted(List<T> data) {}
}
