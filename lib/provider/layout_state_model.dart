import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/net/api.dart';

import 'layout_state.dart';

class LayoutStateModel with ChangeNotifier {
  LayoutState _layoutState;

  LayoutStateModel({LayoutState layoutState})
      : _layoutState = layoutState ?? LayoutState.IDLE;

  LayoutState get layoutState => _layoutState;

  set layoutState(LayoutState layoutState) {
    _layoutState = layoutState;
    notifyListeners();
  }

  void setState(LayoutState state) {
    layoutState = state;
  }

  /// [e]分类Error和Exception两种
  void setError(e, stackTrace, {String message}) {
    ErrorType errorType = ErrorType.DEFAULT_ERROR;
  }

  @override
  String toString() {
    return 'LayoutStateModel{_layoutState: $_layoutState}';
  }
}
