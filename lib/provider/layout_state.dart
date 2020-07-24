import 'package:flutter/cupertino.dart';

//页面加载状态
enum LayoutState {
  IDLE,
  LOADING, //加载中
  EMPTY, //无数据
  ERROR, //加载失败
  UNAUTHORIZED, //未登录
  SUCCESS, //加载完成
}

/// 错误类型
enum ErrorType {
  DEFAULT_ERROR,
  NETWORK_ERROR,
}
