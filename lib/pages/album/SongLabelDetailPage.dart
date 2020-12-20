import 'package:flutter/material.dart';
import 'package:flutter_app/base/res/colors.dart';
import 'package:flutter_app/base/res/gaps.dart';
import 'package:flutter_app/base/res/styles.dart';
import 'package:flutter_app/net/http.dart';
import 'package:flutter_app/pages/playlist/page_category_song_list.dart';
import 'package:flutter_app/pages/video/VideoList.dart';

class SongLabelDetailPage extends StatefulWidget {
  final String cat;

  SongLabelDetailPage({
    this.cat,
  });

  @override
  State<StatefulWidget> createState() => _SongLabelDetailPageState();
}

class _SongLabelDetailPageState extends State<SongLabelDetailPage> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cat),
      ),
      body: PlaylistCategoryPage(cat: widget.cat),
    );
  }

}


