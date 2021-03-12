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

    // var appVersion = await PlatformUtils.getAppVersion();
    // var version = Map()
    //   ..addAll({
    //     'appVerison': appVersion,
    //   });
    options.headers['Cookie'] =
        'NMTID=00O3WNr1ylHHtxelE_asskuaU9I3boAAAF2mPvfOQ; __remember_me=true; MUSIC_U=ba34296e04ecdf04df0d8c22e024f30c9536eedc12f37711e562c8307e594de433a649814e309366; __csrf=5446fa62605fb155f09a89410963cdbd';
    return options;
  }
}

/// 接口的code没有返回为true的异常
class NotSuccessException implements Exception {
  String message;

  NotSuccessException.fromRespData(BaseResponseData respData) {}

  @override
  String toString() {
    return 'NotExpectedException{respData: $message}';
  }
}

/// 子类需要重写
abstract class BaseResponseData {
  int code = 200;

  bool get success;

  BaseResponseData({
    this.code,
  });

  @override
  String toString() {
    return 'BaseRespData{code: $code, }';
  }
}

/// 用于未登录等权限不够,需要跳转授权页面
class UnAuthorizedException implements Exception {
  const UnAuthorizedException();

  @override
  String toString() => 'UnAuthorizedException';
}
