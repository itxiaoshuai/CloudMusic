import 'package:flutter/material.dart';
import 'package:cloud_music/pages/find/FutureBuilderPage.dart';

class DrawerListItem extends StatelessWidget {
  final String text;
  final String image;
  final String? route;

  DrawerListItem({required this.image, required this.text, this.route});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(route!);
        },
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
              Spacer(), //使用Spacer自动填充
              Icon(
                Icons.keyboard_arrow_right_rounded,
                size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
