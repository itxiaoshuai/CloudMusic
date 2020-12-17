import 'package:flutter/material.dart';
import 'package:flutter_app/base/res/gaps.dart';
import 'package:flutter_app/base/res/styles.dart';
import 'package:flutter_app/data/protocol/user_info.dart';
import 'package:flutter_app/data/repository/music_repository.dart';
import 'package:flutter_app/pages/main/page_main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String phone;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手机号登录'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '登录体验更多精彩',
              style: TextStyles.textBoldDark16,
            ),
            Text(
              '未注册手机号登录后将自动创建账号',
              style: TextStyles.textGray14,
            ),
            Gaps.vGap12,
            Container(
              // color: Colors.blue,
              child: Row(
                children: <Widget>[
                  Text('+86'),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.black26,
                  ),
                  Expanded(
                      child: _inputStyle(
                          TextInputType.number, "+86 请输入手机号码", Icons.phone_android,
                              (account) {
                            this.phone = account;
                          }, false))
                ],
              ),
            ),
            Gaps.line,
            Container(
              margin: EdgeInsets.only(top: 32),
              child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '下一步',
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
                onPressed: () {
                  _getUserInfo(phone, password);
                },
                shape: StadiumBorder(),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.only(top: 12, bottom: 12),
              ),
            )
          ],
        ),
      ),
    );
  }

  _inputStyle(inputType, hintText, iconData, onChanged, obscureText) {
    return TextField(
      keyboardType: inputType,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black26),
        // enabledBorder:
        //     UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
      ),
      obscureText: obscureText,
      cursorColor: Theme.of(context).primaryColor,
      autofocus: true,
      style: TextStyle(color: Colors.black87),
      onChanged: onChanged,
    );
  }

  _getUserInfo(String phone, String password) async {
    UserInfo userInfo = await MusicRepository.logoin(phone, password);
    if (userInfo != null) {
      Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
        builder: (BuildContext context) {
          return MainPage();
        },
      ), (route) => route == null);
    }
  }
}
