import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'api.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  Future<void> init() async {
    debugPrint("Http---->init");
    // options.baseUrl = "http://118.24.63.15:1020";
    options.baseUrl = "http://192.168.0.106:3000";
    // options.baseUrl = "http://172.16.25.80:3000";
    options.followRedirects = false;
    //
    // interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    // Directory tempDir = await getTemporaryDirectory();
    // String tempPath = tempDir.path;
    // CookieJar cj = PersistCookieJar(storage: FileStorage(tempPath));
    interceptors..add(ApiInterceptor());
    // interceptors.add(CookieManager(cj));
  }
}

//添加拦截器
class ApiInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("在请求之前的拦截信息");
    debugPrint('---api-request--->url--> ${options.baseUrl}${options.path}' +
        ' queryParameters: ${options.queryParameters}' +
        ' data: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint("在响应之前的拦截信息");
    // ResponseData respData = ResponseData.fromJson(response.data);
    // if (respData.success) {
    //   //请求成功
    //   super.onResponse(response, handler);
    // } else {
    //   throw NotSuccessException.fromRespData(respData);
    // }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint('$err');
    super.onError(err, handler);
  }
}

class ResponseData extends BaseResponseData {
  bool get success => 200 == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
  }
}
