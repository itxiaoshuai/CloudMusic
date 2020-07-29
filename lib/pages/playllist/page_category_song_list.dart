import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';
import 'package:flutter_app/widget/base_song_img_item.dart';

class PlaylistCategoryPage extends StatefulWidget {
  final String cat;

  PlaylistCategoryPage({
    this.cat,
  });

  @override
  State<StatefulWidget> createState() => PlaylistCategoryPageState();
}

class PlaylistCategoryPageState extends State<PlaylistCategoryPage> {
  List widgets = [];

  @override
  void initState() {
    loadData(widget.cat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
//      padding: const EdgeInsets.all(18.0),
          child: LayoutBuilder(builder: (context, constraints) {
            int count = 3;
            double spacing = 8;
            double totalWidthSpacing = spacing * (count + 1);
            double width = ((constraints.maxWidth - totalWidthSpacing) ~/ count)
                .toDouble();
            print(width);
            return Padding(
              padding: EdgeInsets.only(left: spacing),
              child: Wrap(
                spacing: spacing,
                direction: Axis.horizontal,
                children: widgets.map<Widget>((p) {
                  return BaseImgItem(
                    width: width,
                    img: p['coverImgUrl'],
                    describe: p['name'],
                  );
                }).toList(),
              ),
            );
          }),
        )
      ],
    );
  }

  Future<void> loadData(cat) async {
    Map<String, dynamic> formData = {
      'cat': cat,
    };
    var response =
        await http.get('/top/playlist/highquality', queryParameters: formData);
    print(response.data);
//    Map data = json.decode(response.data);
    List rows = response.data['playlists'];
    widgets = rows;
    setState(() {});
  }
}
