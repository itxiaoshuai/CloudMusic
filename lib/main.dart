import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/base/route.dart';
import 'package:flutter_app/route/routes.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: routes,
      onGenerateRoute: Routers.generateRoute,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor:Colors.white,//如果要把顶部导航栏和状态栏的颜色修改成黑色或者白色，需要用到这个属性
        backgroundColor: Colors.grey[100],
        primarySwatch: Colors.red,
      ),
    );
  }
}
