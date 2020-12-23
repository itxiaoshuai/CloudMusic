import 'dart:io';
import 'package:cloud_music/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base/route.dart';

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
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
      onGenerateRoute: Routers.generateRoute,
      theme: ThemeData(
        backgroundColor: Colors.grey[100],
        primarySwatch: Colors.red,
      ),
    );
  }
}
