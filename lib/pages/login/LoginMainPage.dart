import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../WebViewPage.dart';

class LoginMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SwitchCheckBoxState(),

//      color: Colors.red,
//      child: Center(
//        child: Container(
//          child: Column(
//            children: <Widget>[
//              //
//              Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: <Widget>[
//                  Image.asset(
//                    'images/wx.png',
//                    width: 30,
//                    height: 30,
//                  ),
//                  Image.asset(
//                    'images/qq.png',
//                    width: 30,
//                    height: 30,
//                  ),
//                  Image.asset(
//                    'images/weibo.png',
//                    width: 30,
//                    height: 30,
//                  ),
//                  Image.asset(
//                    'images/wangyi.png',
//                    width: 30,
//                    height: 30,
//                  )
//                ],
//              ),
//            ],
//          ),
//          width: 200,
//          color: Colors.cyan,
//        ),
//      ),
//      body: Stack(
//        children: <Widget>[
//          Container(
//            color: Colors.red,
//          ),
//          Positioned(
//              bottom: 0,
//              child: Center(
//                  child: Container(
//                color: Colors.blue,
//                width: 600,
//                height: 150,
//
//
//              ))),
//        ],
//      ),
    );
  }
}

class SwitchCheckBoxState extends StatefulWidget {
  @override
  _SwitchCheckBoxState createState() => _SwitchCheckBoxState();
}

class _SwitchCheckBoxState extends State<SwitchCheckBoxState> {
  bool isCheck = false;

  final TapGestureRecognizer recognizer = TapGestureRecognizer();

  void initState() {
    super.initState();
    recognizer.onTap = () {
//      Fluttertoast.showToast(
//          msg: "This is Center Short Toast",
//          toastLength: Toast.LENGTH_SHORT,
//          gravity: ToastGravity.CENTER,
//          timeInSecForIos: 1,
//          backgroundColor: Colors.red,
//          textColor: Colors.white,
//          fontSize: 16.0);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return WebViewPage("http://music.163.com/html/web2/service.html",title: "网易云音乐服务条款",);
      }));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Checkbox(
          value: this.isCheck,
          activeColor: Colors.blue,
          onChanged: (bool val) {
            // val 是布尔值
            setState(() {
              this.isCheck = !this.isCheck;
            });
          },
        ),
        new RichText(
          text: new TextSpan(
            text: '同意',
            style: new TextStyle(fontSize: 9.0, color: Colors.white70),
            children: <TextSpan>[
              new TextSpan(
                  text: '《用户协议》',
                  style: new TextStyle(fontSize: 10.0, color: Colors.white),
                  recognizer: recognizer),
              new TextSpan(
                  text: '和',
                  style: new TextStyle(fontSize: 9.0, color: Colors.white70),
                  recognizer: recognizer),
              new TextSpan(
                text: '《隐私协议》',
                style: new TextStyle(fontSize: 10.0, color: Colors.white),
                recognizer: recognizer,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
