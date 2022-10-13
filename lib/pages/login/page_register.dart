import 'package:flutter/material.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';

import 'page_login_with_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String phone;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '手机号登录',
          style: TextStyles.textBoldDark16,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '登录体验更多精彩',
              style: TextStyles.textBoldDark16_0,
            ),
            Gaps.vGap10,
            Text(
              '未注册手机号登录后将自动创建账号',
              style: TextStyles.textGray12,
            ),
            Gaps.vGap30,
            Container(
              // color: Colors.blue,
              child: Row(
                children: <Widget>[
                  Text(
                    '+86',
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: Colors.black87,
                  ),
                  Expanded(
                      child: _inputStyle(
                          TextInputType.number, "请输入手机号码", Icons.phone_android,
                          (account) {
                    this.phone = account;
                  }, false))
                ],
              ),
            ),
            Gaps.line,
            Container(
              margin: EdgeInsets.only(top: 32),
              child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '下一步',
                        style: TextStyle(fontSize: 16,color: Colors.white),
                      )
                    ],
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return LoginWithAuth(); //手机号登入
                    }));
                  },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      backgroundColor: Theme.of(context).primaryColor,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.white),
                      shape: StadiumBorder())),
            ),
            Gaps.vGap30,
            Center(
                child: Material(
              child: InkWell(
                onTap: () {},
                child: Text(
                  '找回账号',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ))
          ],
        ),
        color: Colors.white,
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
}
