import 'package:chewie/chewie.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_music/base/ConstImg.dart';
import 'package:cloud_music/base/res/colors.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import 'package:cloud_music/data/protocol/VideoDetailData.dart';
import 'package:cloud_music/net/http.dart';
import 'package:cloud_music/pages/playlist/page_playlist_detail.dart';
import 'package:cloud_music/route/routes.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  final String id;
  final String url;

  VideoDetailPage({
    required this.id,
    required this.url,
  });

  @override
  State<StatefulWidget> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  List _commentList = [];
  late VideoPlayerController _controller;
  late bool _isPlaying = false;
  late VideoDetailData _videoDetail;

  @override
  void initState() {
    loadData(widget.id);
    fetchVideoDetail(widget.id);

    _controller = VideoPlayerController.network(widget.url)
      // 播放状态
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {});
      });

    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Container(
        color: Colors.white,
//        decoration: BoxDecoration(
//            image: DecorationImage(
//          image: NetworkImage(
//              'https://img.zcool.cn/community/0372d195ac1cd55a8012062e3b16810.jpg'),
//          fit: BoxFit.cover,
//        )),
        child: Scaffold(
            backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
//            appBar: AppBar(
//              backgroundColor: Colors.transparent, //把appbar的背景色改成透明
//              elevation: 0, //appbar的阴影
//              title: Text('widget.title'),
//            ),
            body: Container(
              child: ListView(
                children: [
                  Chewie(
                    controller: ChewieController(
                      videoPlayerController: _controller,

                    ),
                  ),
                  Text(_videoDetail == null ? '' : _videoDetail.data.title),
                  Container(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 15, bottom: 15),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Material(
                          child: InkWell(
                            //点击事件回调
                            onTap: () {
//                              Navigator.of(context)
//                                  .pushNamed(RouteName.comment, arguments: id);
                            },
                            child: ListItem(
                              image: ConstImgResource.praise,
                              text: _videoDetail == null
                                  ? ''
                                  : _videoDetail.data.praisedCount.toString(),
                            ),
                          ),
                        ),
                        ListItem(
                          image: ConstImgResource.collect,
                          text: _videoDetail == null
                              ? ''
                              : _videoDetail.data.subscribeCount.toString(),
                        ),
                        ListItem(
                            image: ConstImgResource.comment,
                            text: _videoDetail == null
                                ? ''
                                : _videoDetail.data.commentCount.toString()),
                        ListItem(
                            image: ConstImgResource.share,
                            text: _videoDetail == null
                                ? ''
                                : _videoDetail.data.shareCount.toString()),
                      ],
                    ),
                  ),
                  Gaps.line,
                  _videoDetail == null
                      ? SizedBox()
                      : Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 5, bottom: 5),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      RouteName.USER_HOME,
                                      arguments:
                                          _videoDetail.data.creator.userId);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    color: Colors.blue,
                                    child: Image.network(
                                        _videoDetail.data.creator.avatarUrl),
                                  ),
                                ),
                              ),
                              Gaps.hGap10,
                              Text(
                                _videoDetail.data.creator.nickname,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black87),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 15, right: 15, top: 5, bottom: 5),
                                child: Text(
                                  "+关注",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.rectangle, // 默认值也是矩形
                                  borderRadius:
                                      BorderRadius.circular((20.0)), // 圆角度
                                ),
                              ),
                            ],
                          ),
                        ),
                  Container(
                    color: Colours.line,
                    height: 10,
                  ),
                  Container(
                    child: Column(
                      children: _commentList.map((comment) {
                        return buildCommentItem(comment);
                      }).toList(),
                    ),
                  ),
                ],
              ),
            )));
  }

  Widget buildCommentItem(comment) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteName.USER_HOME,
                      arguments: comment.user.userId);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    width: 32,
                    height: 32,
                    color: Colors.blue,
                    child: Image.network(comment['user']['avatarUrl']),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment['user']['nickname'],
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    DateUtil.formatDateMs(comment['time'],
                        format: "yyyy/M/d HH:mm:ss"),
                    style: TextStyle(fontSize: 10, color: Colors.black38),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text(
                    '${NumberUtils.amountConversion(comment['likedCount'])}',
                    style: TextStyle(fontSize: 10, color: Colors.black38)),
              ),
              SizedBox(width: 17),
              Image.asset(
                ConstImgResource.praise,
                width: 10,
                height: 10,
                color: Colors.grey,
              )
            ],
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.only(left: 40),
            child: Text(comment['content']),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Future<void> loadData(id) async {
    Map<String, dynamic> formData = {
      'id': id,
    };
    var response = await http.get('/comment/video', queryParameters: formData);
    print(response.data);
    List rows = response.data['comments'];
    _commentList = rows;
    setState(() {});
  }

  Future<void> fetchVideoDetail(id) async {
    Map<String, dynamic> formData = {
      'id': id,
    };
    var response = await http.get('/video/detail', queryParameters: formData);

    _videoDetail = VideoDetailData.fromJson(response.data);
    setState(() {});
  }
}
