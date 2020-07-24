import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = "http://118.24.63.15:1020";
    interceptors..add(ApiInterceptor());
//       cookie持久化 异步
//      ..add(CookieManager(
//          PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
  }
}

/// 玩Android API
class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}' +
        ' data: ${options.data}');
//    final jsonResponse = json.decode(options.data);
//    debugPrint(jsonResponse);
    return options;
  }
}
