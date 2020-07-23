import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'api.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = "http://localhost:3000";
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
  onResponse(Response response) {
    final jsonResponse = json.decode(response.data);
    ResponseData respData = ResponseData.fromJson(jsonResponse);
    if (respData.success) {
      debugPrint('${response.data}');
//      response.data = respData.data;
//      debugPrint('${response.data}');
      return http.resolve(response);
    } else {
      if (respData.code == '10001' ||
          respData.code == '10002' ||
          respData.code == '10003') {
        //access_token过期  ,access_token无效，账号存在风险【在其他地方操作登录】,access_token无效
        // 如果cookie过期,需要清除本地存储的登录信息
        // StorageManager.localStorage.deleteItem(UserModel.keyUser);
        throw const UnAuthorizedException(); // 需要登录
      } else {
        debugPrint('---api-NotSuccessException--->resp----->}');
        throw NotSuccessException.fromRespData(respData);
      }
    }
  }
}

class ResponseData extends BaseResponseData {
  bool get success => "200" == code;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    message = '';
    data = json;
  }
}
