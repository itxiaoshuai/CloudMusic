import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/net/huyi_android_api.dart';
import 'package:flutter_app/widget/ListItemCustom.dart';
import 'package:flutter_app/widget/base_song_img_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlaylistCategoryPage extends StatefulWidget {
  final String cat;
  int limit = 30;
  int offset = 0;

  PlaylistCategoryPage({
    this.cat,
  });

  @override
  State<StatefulWidget> createState() => PlaylistCategoryPageState();
}

class PlaylistCategoryPageState extends State<PlaylistCategoryPage>
    with AutomaticKeepAliveClientMixin {
  List widgets = [];
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    onRefresh(widget.cat);
  }

  void _onLoading() async {
    onLoadingMore(widget.cat);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: MaterialClassicHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("上拉加载");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("加载失败！点击重试！");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("松手,加载更多!");
            } else {
              body = Text("没有更多数据了!");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView(
          children: [
            Container(
//      padding: const EdgeInsets.all(18.0),
              child: LayoutBuilder(builder: (context, constraints) {
                int count = 3;
                double spacing = 8;
                double totalWidthSpacing = spacing * (count + 1);
                double width =
                    ((constraints.maxWidth - totalWidthSpacing) ~/ count)
                        .toDouble();
                print(width);
                return Padding(
                  padding: EdgeInsets.only(left: spacing),
                  child: Wrap(
                    spacing: spacing,
                    direction: Axis.horizontal,
                    children: widgets.map<Widget>((p) {
                      return BaseImgItem(
                        id: p['id'],
                        width: width,
                        playCount: p['playCount'],
                        img: p['coverImgUrl'],
                        describe: p['name'],
                      );
                    }).toList(),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onRefresh(cat) async {
    widget.offset = 0;
    Map<String, dynamic> formData = {
      'cat': cat,
      'limit': widget.limit,
      'offset': widget.offset,
    };
    var response = await http.get('/top/playlist/', queryParameters: formData);
    widgets.clear();
    List rows = response.data['playlists'];
    widgets = rows;
    _refreshController.refreshCompleted();
    setState(() {});
  }

  Future<void> onLoadingMore(cat) async {
    widget.offset = widget.offset + widget.limit;
    Map<String, dynamic> formData = {
      'cat': cat,
      'limit': widget.limit,
      'offset': (widget.offset),
    };
    var response = await http.get('/top/playlist/', queryParameters: formData);

    List rows = response.data['playlists'];
    widgets.addAll(rows);
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  bool get wantKeepAlive => true;
}
