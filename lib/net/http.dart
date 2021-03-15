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
    // options.baseUrl = "http://118.24.63.15:1020";
    options.baseUrl = "http://192.168.191.2:3000";
    // options.baseUrl = "http://172.16.25.80:3000";
    options.followRedirects = false;

    interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cj = PersistCookieJar(dir: tempPath);
    interceptors..add(ApiInterceptor());
    interceptors.add(CookieManager(cj));
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  onRequest(RequestOptions options) async {
    // if (!options.path.contains(MusicApi.LOGIN)) {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   Map<String, dynamic> formData = {
    //     'cookie': prefs.get('cookie'),
    //   };
    //   options.queryParameters = formData;
    // }

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
