import 'package:flutter/material.dart';

class DrawerListItem extends StatelessWidget {
  final String text;
  final String image;

  DrawerListItem({ this.image,this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      height: 45.0,
      child: Row(
        children: <Widget>[
          Image.asset(
            image,
            width: 18,
            height: 18,
            color: Colors.black,
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              text,
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
