import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = "http://118.24.63.15:1020";
    Map headers = new Map();
    headers['Cookie'] =
        "ba34296e04ecdf04df0d8c22e024f30c95f36294cb7ee79c61e4fae6b7f8bb4c33a649814e309366";
    options.headers = headers;
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

  @override
  Future onResponse(Response response) {
//    debugPrint('${response.data}');
    ResponseData respData = ResponseData.fromJson(response.data);
    if (respData.success) {
      //请求成功
      return super.onResponse(response);
    } else {
      throw NotSuccessException.fromRespData(respData);
    }
  }

  @override
  Future onError(DioError err) {
    debugPrint('${err}');
    return super.onError(err);
  }
}

class ResponseData extends BaseResponseData {
  bool get success => 200 == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }
}
