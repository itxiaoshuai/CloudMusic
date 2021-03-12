import 'dart:io';
import 'package:cloud_music/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'base/route.dart';
import 'manager/provider_manager.dart';

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
    return OKToast(
      child: MultiProvider(
        providers: providers,
        child: ScreenUtilInit(
          designSize: Size(720, 1080),
          allowFontScaling: false,
          builder: () {
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
          },
        ),
      ),
    );
  }
}

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<SubtitleEntry> _subtitleList = [];
//
//   @override
//   void initState() {
//     loadData();
//     super.initState();
//   }
//
//   loadData() async {
//     var jsonStr =
//     await DefaultAssetBundle.of(context).loadString('assets/subtitle.txt');
//     var list = jsonStr.split(RegExp('\n'));
//     list.forEach((f) {
//       if (f.isNotEmpty) {
//         var r = f.split(RegExp(' '));
//         if (r.length >= 2) {
//           _subtitleList.add(SubtitleEntry(r[0], r[1]));
//         }
//       }
//     });
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('弹幕'),
//       ),
//       body: Stack(
//         children: <Widget>[
//           Positioned.fill(
//               child: Image.asset(
//                 'assets/imgs/background.png',
//                 fit: BoxFit.cover,
//               )),
//           Positioned.fill(
//               child: Subtitle(
//                 _subtitleList,
//                 diameterRatio: 2,
//                 selectedTextStyle: TextStyle(color: Colors.white, fontSize: 18),
//                 unSelectedTextStyle: TextStyle(
//                   color: Colors.black.withOpacity(.6),
//                 ),
//                 itemExtent: 45,
//               ))
//         ],
//       ),
//     );
//   }
// }
