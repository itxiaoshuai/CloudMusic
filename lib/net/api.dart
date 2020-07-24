import 'dart:convert';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';

// 必须是顶层函数
_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

abstract class BaseHttp extends DioForNative {
  BaseHttp() {
    /// 初始化 加入app通用处理
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
    interceptors..add(HeaderInterceptor());
    init();
  }

  void init();
}

//添加常用Header
class HeaderInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    options.connectTimeout = 1000 * 45;
    options.receiveTimeout = 1000 * 45;

//    var appVersion = await PlatformUtils.getAppVersion();
//    var version = Map()
//      ..addAll({
//        'appVerison': appVersion,
//      });
//    options.headers['version'] = version;
//    options.headers['platform'] = Platform.operatingSystem;
    return options;
  }
}
