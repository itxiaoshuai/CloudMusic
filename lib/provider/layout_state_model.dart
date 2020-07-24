import 'package:flutter/material.dart';

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

  @override
  String toString() {
    return 'LayoutStateModel{_layoutState: $_layoutState}';
  }
}
