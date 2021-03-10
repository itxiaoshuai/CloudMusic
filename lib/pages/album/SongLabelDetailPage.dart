import 'package:flutter/material.dart';
import 'package:cloud_music/base/res/colors.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/net/http.dart';
import 'package:cloud_music/pages/playlist/page_category_song_list.dart';
import 'package:cloud_music/pages/video/VideoList.dart';

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


