import 'package:flutter/material.dart';
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
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 20),
              child: _inputStyle(
                  TextInputType.number, "+86 请输入手机号码", Icons.phone_android,
                      (account) {
                    this.phone = account;
                  }, false),
            ),

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
    UserInfo userInfo = await MusicRepository.logoin(phone, password);
    if (userInfo != null) {
      Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(
        builder: (BuildContext context) {
          return MainPage();
        },
      ), (route) => route == null);
    }
  }
}
