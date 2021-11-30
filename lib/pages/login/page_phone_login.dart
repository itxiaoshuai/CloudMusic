
import 'package:cloud_music/manager/request_manager.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/data/protocol/user_info.dart';
import 'package:cloud_music/pages/main/page_main.dart';

class PhoneLoginPage extends StatefulWidget {
  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  late String phone;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('手机号登录'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 40),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: _inputStyle(
                  TextInputType.number, "+86 请输入手机号码", Icons.phone_android,
                  (account) {
                this.phone = account;
              }, false),
            ),
            _inputStyle(TextInputType.text, "请输入密码", Icons.lock_outline,
                (password) {
              this.password = password;
            }, true),
            Container(
              margin: EdgeInsets.only(top: 32),
              child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '登录',
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
        prefixIcon: Icon(
          iconData,
          color: Colors.black26,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black26),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
      ),
      obscureText: obscureText,
      cursorColor: Theme.of(context).primaryColor,
      autofocus: true,
      style: TextStyle(color: Colors.black87),
      onChanged: onChanged,
    );
  }

  _getUserInfo(String phone, String password) async {

    UserInfo userInfo = await RequestManager.logoin(phone, password);
    if (userInfo != null) {
      Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(
        builder: (BuildContext context) {
          return MainPage();
        },
      ), (route) => route == null);
    }
  }
}
