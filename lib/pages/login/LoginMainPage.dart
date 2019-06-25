import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/ConstImg.dart';
import 'package:flutter_app/base/StringResource.dart';
import '../WebViewPage.dart';

class LoginMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffff3300),
      body: Center(
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              top: 100,
              child: Image.asset(

                ConstImgResource.login,
                width: 68,
                height: 68,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 45,
                            padding: EdgeInsets.only(left: 45, right: 45),
                            child: new RaisedButton(
                              onPressed: () {},
                              color: Colors.white,
                              child: new Text(
                                ConstStringResource.login,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.redAccent),
                              ),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25.0)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 20,
                    ),
                    AuthorizedLoginItem(),
                    UserAgreementItem(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 授权登入模块
class AuthorizedLoginItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50),
      height: 45.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            ConstImgResource.wx,
            width: 30,
            height: 30,
          ),
          Image.asset(
            ConstImgResource.qq,
            width: 30,
            height: 30,
          ),
          Image.asset(
            ConstImgResource.weibo,
            width: 30,
            height: 30,
          ),
          Image.asset(
            ConstImgResource.wangyi,
            width: 30,
            height: 30,
          )
        ],
      ),
    );
  }
}

//用户协议模块
class UserAgreementItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
//      color: Colors.cyan,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Image.asset(
                  ConstImgResource.commonCheck,
                  color: Colors.white54,
                ),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    //圆角
                    Radius.circular(2.0),
                  ),
                  border: Border.all(
                      width: 0.5,
                      style: BorderStyle.solid,
                      color: Colors.white54),
                )),
            Container(
              width: 3,
            ),
            SwitchCheckBoxState(),
          ],
        ),
      ),
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
        return WebViewPage(
          "http://music.163.com/html/web2/service.html",
          title: "网易云音乐服务条款",
        );
      }));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
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
