import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/ConstImg.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/net/http.dart';
import 'package:cloud_music/widget/base_song_img_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VideoListPage extends StatefulWidget {
  final int categoryId;
  late int limit = 30;
  late int offset = 0;

  VideoListPage({
    required this.categoryId,
  });

  @override
  State<StatefulWidget> createState() => VideoListPageState();
}

class VideoListPageState extends State<VideoListPage>
    with AutomaticKeepAliveClientMixin {
  List widgets = [];
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  void _onRefresh() async {
    onRefresh(widget.categoryId);
  }

  void _onLoading() async {
    onLoadingMore(widget.categoryId);
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
          builder: (BuildContext context, LoadStatus? mode) {
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
              // color: Colors.red,
//      padding: const EdgeInsets.all(18.0),
              child: LayoutBuilder(builder: (context, constraints) {
                int count = 2;
                double spacing = 15;
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
                      return VideoItem(
                          id: p['id'],
                          width: width,

                          // playCount: p['playCount'],
                          img: p['data']['coverUrl'],
                          describe: p['data']['title'],
                          durationms: p['data']['durationms'],
                          avatarUrl: p['data']['creator']['avatarUrl']);
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> formData = {
      'id': cat,
      // 'cookie': prefs.get('cookie'),
    };
    var response =
        await http.get('/video/timeline/recommend/', queryParameters: formData);
    widgets.clear();
    List rows = response.data['datas'];
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

class VideoItem extends StatelessWidget {
  final double width; //宽
  final double height; //高
  final double circular; //圆角
  final String img; //图片
  final String updateFrequency; //每周几更新
  final String describe; //描述
  final int playCount;
  final int id;
  final String avatarUrl;
  final int durationms;

  VideoItem({
    this.width = 0,
    this.height = 0,
    this.circular = 6.0,
    this.updateFrequency = "",
    required this.img,
    this.describe = '',
    this.playCount = 0,
    required this.id,
    required this.avatarUrl,
    required this.durationms,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
          width: width,
          child: Container(
            // color: Colors.blue,
            margin: EdgeInsets.only(bottom: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 100,
                color: Colors.white,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          height: 200,
                          imageUrl: img,
                          placeholder: (context, url) => ProgressView(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        Positioned(
                            left: 10,
                            top: 160,
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                shape: BoxShape.rectangle,
                                // 默认值也是矩形
                                borderRadius:
                                    BorderRadius.circular((30.0)), // 圆角度
                              ),
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  avatarUrl == null ? "" : avatarUrl,
                                ),
                                backgroundColor: Colors.black,
                                radius: 15.0,
                              ),
                            )),
                        Positioned(
                            bottom: 10,
                            right: 5,
                            child: Text(
                              DateUtil.formatDateMs(durationms,
                                  format: "mm:ss"),
                              style: TextStyles.textGray12,
                            )),
                      ],
                    ),
                    Text(
                      describe,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
