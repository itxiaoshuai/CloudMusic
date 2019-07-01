import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_app/common/dao/EventDao.dart';

class BaseResp<T> {
  T data;

  BaseResp(this.data);

  @override
  String toString() {
    StringBuffer sb = new StringBuffer('{');
    sb.write(",\"data\":\"$data\"");
    sb.write('}');
    return sb.toString();
  }
}

/// 请求方法.
class Method {
  static final String get = "GET";
  static final String post = "POST";
  static final String put = "PUT";
  static final String head = "HEAD";
  static final String delete = "DELETE";
  static final String patch = "PATCH";
}

class Http {
  Dio dio;

  Http({bool loading: true}) {
    dio = Dio();
    setConfig();
    setInterceptor(loading: loading);
  }

  request(String method, String path,
      {data, Options options, CancelToken cancelToken}) async {
    Response response = await dio.request(path,
        data: data,
        options: _checkOptions(method, options),
        cancelToken: cancelToken);
    print("response.data==" + response.data.toString());
    print("response.headers==" + response.headers.toString());
    print("response.request==" + response.request.toString());
    print("response.statusCode==" + response.statusCode.toString());

    String _data;
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      _data = response.data;
      return _data;
    }
    return new Future.error(new DioError(
      response: response,
      message: "statusCode: $response.statusCode, service error",
      type: DioErrorType.RESPONSE,
    ));
  }

  // get 请求封装
  get(url, {options, cancelToken, queryParameters}) async {
    print('get:::url：$url ,queryParameters: $queryParameters');
    Response response;
    try {
      response = await dio.get(
        url,
        cancelToken: cancelToken,
        queryParameters: queryParameters
      );
    } on DioError catch (e) {
      if (CancelToken.isCancel(e)) {
        print('get请求取消! ' + e.message);
      } else {
        print('get请求发生错误：$e');
      }
    }
    return response.data;
  }

  /// check Options.
  Options _checkOptions(method, options) {
    if (options == null) {
      options = new Options();
    }
    options.method = method;
    return options;
  }

  static all(List<Future> list, {bool loading = false}) async {
    if (loading) Loading.show();
    List results = await Future.wait(list);
    if (loading) Loading.hide();
    return results;
  }

  setConfig() {
//    dio.options.baseUrl = "http://192.168.1.124:3000";
    dio.options.baseUrl = "http://106.13.32.37:3000";

    dio.options.connectTimeout = 3000;
    dio.options.receiveTimeout = 5000;
  }

  setInterceptor({bool loading}) {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      if (loading) Loading.show();
      // 在请求被发送之前做一些事情
      return options; //continue
      // 如果你想完成请求并返回一些自定义数据，可以返回一个`Response`对象或返回`dio.resolve(data)`。
      // 这样请求将会被终止，上层then会被调用，then中返回的数据将是你的自定义数据data.
      //
      // 如果你想终止请求并触发一个错误,你可以返回一个`DioError`对象，或返回`dio.reject(errMsg)`，
      // 这样请求将被中止并触发异常，上层catchError会被调用。
    }, onResponse: (Response response) {
      if (loading) Loading.hide();
      // 在返回响应数据之前做一些预处理
      return response; // continue
    }, onError: (DioError e) {
      if (loading) Loading.hide();
      // 当请求失败时做一些预处理
      return e; //continue
    }));
  }
}
