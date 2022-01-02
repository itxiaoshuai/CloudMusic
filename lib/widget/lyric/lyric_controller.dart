import 'dart:async';

import 'package:flutter/cupertino.dart';

class LyricController extends ChangeNotifier {
  //当前进度
  Duration _progress = Duration();

  set progress(Duration value) {
    _progress = value;
    notifyListeners();
  }

  Duration get progress => _progress;

  //滑动保持器
  late Timer draggingTimer;

  //滑动保持时间
  late Duration draggingTimerDuration;

  bool _isDragging = false;

  get isDragging => _isDragging;

  set isDragging(value) {
    _isDragging = value;
    notifyListeners();
  }

  late Duration draggingProgress;

  late Function draggingComplete;

  late double draggingOffset;

  //启用动画
  late TickerProvider vsync;

  //动画控制器
  late AnimationController animationController;

  //动画 存放上一次偏移量
  double previousRowOffset = 0;

  int oldLine = 0;
  int draggingLine = 0;
  LyricController({required this.vsync});

}
