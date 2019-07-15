import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/base/ConstImg.dart';
import 'package:flutter_app/base/StringResource.dart';
import 'package:flutter_app/pages/login/page_phone_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../WebViewPage.dart';

bool visible = true;

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
              top: 150,
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
                            height: 40,
                            padding: EdgeInsets.only(left: 45, right: 45),
                            child: RaisedButton(
                              onPressed: () {
                                if (visible) {
                                  Fluttertoast.showToast(
                                      msg:
                                          "请先勾选同意\"" "用户协议\"" "和\"" "隐私政策\"" "",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIos: 1,
                                      textColor: Colors.white);
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return PhoneLoginPage();//手机号登入
                                  }));
                                }
                              },
                              color: Colors.white,
                              child: Text(
                                ConstStringResource.login,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.redAccent),
                              ),
                              shape: RoundedRectangleBorder(
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
                    UserAgreementItemState(),
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
class UserAgreementItemState extends StatefulWidget {
  @override
  _UserAgreementItemState createState() => _UserAgreementItemState();
}

class _UserAgreementItemState extends State<UserAgreementItemState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
//      color: Colors.cyan,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                visible = !visible;
                setState(() {});
              },
              child: Container(
                  margin: EdgeInsets.all(5),
                  child: Offstage(
                    offstage: visible,
                    child: Image.asset(
                      ConstImgResource.commonCheck,
                      color: Colors.white54,
                    ),
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

  final TapGestureRecognizer serviceRecognizer = TapGestureRecognizer();
  final TapGestureRecognizer privacyRecognizer = TapGestureRecognizer();

  void initState() {
    super.initState();
    serviceRecognizer.onTap = () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return WebViewPage(
          "http://music.163.com/html/web2/service.html",
          title: "网易云音乐服务条款",
        );
      }));
    };
    privacyRecognizer.onTap = () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return WebViewPage(
          "http://corp.163.com/gb/legal.html",
          title: "NetEase,Inc",
        );
      }));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RichText(
          text: TextSpan(
            text: '同意',
            style: TextStyle(fontSize: 9.0, color: Colors.white70),
            children: <TextSpan>[
              TextSpan(
                  text: '《用户协议》',
                  style: TextStyle(fontSize: 10.0, color: Colors.white),
                  recognizer: serviceRecognizer),
              TextSpan(
                text: '和',
                style: TextStyle(fontSize: 9.0, color: Colors.white70),
              ),
              TextSpan(
                text: '《隐私政策》',
                style: TextStyle(fontSize: 10.0, color: Colors.white),
                recognizer: privacyRecognizer,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
