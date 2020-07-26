import 'package:flutter/material.dart';

//圆形模块组件
class MenuItem extends StatelessWidget {
  final String text;
  final String image;

  MenuItem({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Column(
        children: <Widget>[
          Container(
            width: 40.0,
            decoration: BoxDecoration(
              //圆形渐变
              color: Colors.white,
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [
                Colors.redAccent,
                Colors.redAccent,
                Colors.red,
              ]),
            ),
            child: Image.asset(
              image,
              color: Colors.white,
              width: 50,
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 5), //上边距
              child: Text(text,
                  style: TextStyle(
                    fontSize: 12,
                  )))
        ],
      ),
    );
  }
}
