import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import 'package:cloud_music/base/utils/time_utils.dart';
import 'package:cloud_music/pages/my/PageMy.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/data/protocol/playlist.dart';
import 'package:cloud_music/data/protocol/user_detail_bean.dart';
import 'package:cloud_music/net/http.dart';

import '../../r.dart';

class TabMusic extends StatefulWidget {
  ///用户ID
  final UserDetail userDetail;

  const TabMusic({Key key, @required this.userDetail}) : super(key: key);

  @override
  _TabMusicState createState() => _TabMusicState();
}

class _TabMusicState extends State<TabMusic>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<Playlist> mListDataSubscribed = [];
  List<Playlist> mListDataCreate = [];
  List<Playlist> mListData = [];
  var subscribed;

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: EdgeInsets.only(left: 15, right: 15),
      child: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // 底色
              //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
              shape: BoxShape.rectangle,
              // 默认值也是矩形
              borderRadius: BorderRadius.circular((15.0)), // 圆角度
            ),
            // margin: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              // margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "基本信息",
                          style: R.style.textBoldDark18,
                        ),
                        Gaps.vGap10,
                        Text(
                          "村龄:${widget.userDetail.createDays ~/ 365}年(${DateUtil.formatDateMs(widget.userDetail.createTime, format: 'yyyy年MM月注册')})",
                          style: R.style.textDark14,
                        ),
                        Gaps.vGap10,
                        Text(
                          "性别:${widget.userDetail.profile.gender == 2 ? '女' : '男'}",
                          style: R.style.textDark14,
                        ),
                        Gaps.vGap10,
                        Text(
                          "年龄:${TimeUtils.getAgeGroup(widget.userDetail.profile.birthday)}${TimeUtils.getconstellation(widget.userDetail.profile.birthday)}",
                          style: R.style.textDark14,
                        ),
                      ],
                    ),
                  ),
                  Gaps.line,
                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "查看全部",
                          style: R.style.textDark14,
                        ),
                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gaps.vGap15,
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // 底色
              //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
              shape: BoxShape.rectangle,
              // 默认值也是矩形
              borderRadius: BorderRadius.circular((15.0)), // 圆角度
            ),
            // margin: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              // margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15, top: 15),
                          child: Text(
                            "创建的歌单",
                            style: R.style.textBoldDark18,
                          ),
                        ),
                        Column(
                          children: mListDataCreate
                              .map((element) => Stack(children: <Widget>[
                                    Visibility(
                                        child: ListTile(
                                          title: Text(
                                            element.name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          subtitle: Text(
                                              '${element.trackCount}首，播放${NumberUtils.amountConversion(element.playCount)}次'),
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                                element.coverImgUrl,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        visible: element.creator.userId ==
                                            widget.userDetail.profile.userId),
                                  ]))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gaps.vGap15,
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              // 底色
              //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
              shape: BoxShape.rectangle,
              // 默认值也是矩形
              borderRadius: BorderRadius.circular((15.0)), // 圆角度
            ),
            // margin: EdgeInsets.only(left: 15, right: 15),
            child: Container(
              // margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // margin: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 15, top: 15),
                          child: Text(
                            "收藏的歌单",
                            style: R.style.textBoldDark18,
                          ),
                        ),
                        Column(
                          children: mListDataSubscribed
                              .map((element) => Stack(children: <Widget>[
                                    Visibility(
                                        child: ListTile(
                                          title: Text(
                                            element.name,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          subtitle: Text(
                                            '${element.trackCount}首,by${element.creator.nickname}，播放${NumberUtils.amountConversion(element.playCount)}次',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                                element.coverImgUrl,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                        visible: element.creator.userId !=
                                            widget.userDetail.profile.userId),
                                  ]))
                              .toList(),
                        ),
                        Gaps.line,
                        Visibility(
                          child: Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "查看全部",
                                  style: R.style.textDark14,
                                ),
                                Icon(Icons.chevron_right),
                              ],
                            ),
                          ),
                          visible: mListDataSubscribed.length >= 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gaps.vGap50,
        ],
      ),
    );
  }

  Future<void> initData() async {
    Map<String, dynamic> formData = {
      'uid': widget.userDetail.profile.userId,
    };
    var response = await http.get('/user/playlist', queryParameters: formData);

//    playlistDetail = PlaylistDetail.fromJson(response.data['playlist']);
//     mListData = (response.data["playlist"] as List)
//         .cast<Map>()
//         .map((e) => Playlist.fromJson(e))
//         .toList();
    final created = response.data["playlist"].where(
        (p) => p['creator']["userId"] == widget.userDetail.profile.userId);
    final subscribed = response.data["playlist"].where(
        (p) => p['creator']["userId"] != widget.userDetail.profile.userId);

    created.map((e) => {mListDataCreate.add(Playlist.fromJson(e))}).toList();
    subscribed
        .map((e) => {mListDataSubscribed.add(Playlist.fromJson(e))})
        .toList();

    if (mListDataSubscribed.length >= 10) {
      mListDataSubscribed = (mListDataSubscribed.sublist(0, 10));
    }
    setState(() {});
  }
}
