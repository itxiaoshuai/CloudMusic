import 'package:flutter/material.dart';
import 'package:flutter_app/pages/find/FutureBuilderPage.dart';

class ListItem extends StatelessWidget {
  final String text;
  final String image;

  ListItem({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 10),
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
        ),
      ),
    );
  }
}
