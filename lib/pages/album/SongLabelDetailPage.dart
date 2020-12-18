import 'package:cloud_music/pages/playllist/page_category_song_list.dart';
import 'package:flutter/material.dart';


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


