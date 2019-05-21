import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'item/DrawerListItem.dart';

class HomeDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerListItem(image:"images/location.png", text: "附近的人"),
        ],
      ),

    );
  }
}
