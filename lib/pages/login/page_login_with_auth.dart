import 'package:flutter/material.dart';
import 'package:flutter_app/base/res/gaps.dart';
import 'package:flutter_app/base/res/styles.dart';
import 'package:flutter_app/widget/cloud_password_input.dart';
import 'package:flutter_app/widget/item/DrawerListItem.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWithAuth extends StatefulWidget {
  @override
  _LoginWithAuthState createState() => _LoginWithAuthState();
}

class _LoginWithAuthState extends State<LoginWithAuth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context); // 关闭当前页面
            }),
        backgroundColor: Colors.white,
        title: Text(
          '手机号登录',
          style: TextStyles.textDark14,
        ),
        actions: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Material(
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 0.5),
                      shape: BoxShape.rectangle,
                      // 默认值也是矩形
                      borderRadius: BorderRadius.circular((30)), // 圆角度
                    ),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Text(
                      '密码登录',
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Gaps.hGap15,
        ],
      ),
      body: LoginWithAuthBody(),
    );
  }
}

class LoginWithAuthBody extends StatefulWidget {
  @override
  _LoginWithAuthBodyState createState() => _LoginWithAuthBodyState();
}

class _LoginWithAuthBodyState extends State<LoginWithAuthBody> {
  TextEditingController _controller = TextEditingController();
  FocusNode _node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap50,
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Text(
              '请输入验证码',
              style: TextStyles.textBoldDark18,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Row(
              children: [
                Text(
                  '已发送至+86 1314****484',
                  style: TextStyles.textGray12,
                ),
                Gaps.hGap10,
                Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1, color: Colors.grey[500]))),
                      child: Icon(
                        Icons.edit_outlined,
                        size: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  '42s',
                  style: TextStyles.textGray12,
                ),
              ],
            ),
          ),
          CloudPasswordInputTextField(
            borderWidth: 0.5,
            borderRaiuds: 5,
            controller: _controller,
            node: _node,
            // backgroundColor: Colors.red,
            obscureText: false,
            // obscureTextString: "🤪",
            // boxWidth: 45,
            // boxHeight: 80,
            boxType: CloudPasswordInputTextFieldBoxType.LINE,
            type: CloudPasswordInputTextFieldType.BOXES,
            length: 6,
            textStyle: TextStyle(fontSize: 20),
            onChange: (text) {
              print(text);
              if (text.toString().length == 6) {
                Fluttertoast.showToast(msg: "xxxxxxxxxxx");
              }
            },
          ),
          Gaps.vGap24,
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(

                      onTap: () {},
                      child: Container(
                        child: Row(
                          children: [
                            Text(
                              '手机号已停用',
                              style: TextStyles.textGray12,
                            ),
                            Icon(
                              Icons.chevron_right_sharp,
                              size: 12,
                              color: Colors.grey[500],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
