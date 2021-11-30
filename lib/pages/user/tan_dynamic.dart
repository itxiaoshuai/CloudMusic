import 'dart:convert';

import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/data/protocol/user_detail_bean.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_music/base/utils/number_utils.dart';
import '../../r.dart';
import 'package:cloud_music/base/ConstImg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/CommonLoading.dart';

class TabDynamic extends StatefulWidget {
  ///用户ID
  final UserDetail userDetail;

  const TabDynamic({Key? key, required this.userDetail}) : super(key: key);

  @override
  _TabDynamicState createState() => _TabDynamicState();
}

class _TabDynamicState extends State<TabDynamic>
    with AutomaticKeepAliveClientMixin {
  List list = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    Map<String, dynamic> formData = {
      'uid': widget.userDetail.profile.userId,
    };
    var response = await RequestManager.fetchDynamic(formData);
    if (response.data['code'] == 200) {
      list = response.data['events'];
    }
    setState(() {});
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildItem(BuildContext context, p) {
    return Container(
      // color: Colors.blue,
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              p['user']['avatarUrl'] == null ? "" : p['user']['avatarUrl'],
            ),
            backgroundColor: Colors.black,
            radius: 20.0,
          ),
          Gaps.hGap10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(p['user']['nickname']),
                    // Text(p['type'].toString() + ''),
                    Gaps.hGap5,
                    _buildItemText(p['type'])
                  ],
                ),
                Gaps.vGap5,
                Text(
                  '${DateUtil.formatDateMs(p['eventTime'], format: 'yyyy年MM月dd日')}',
                  style: R.style.textGray10,
                ),

                Gaps.vGap10,
                Text(json.decode(p['json'])['msg']),
                Gaps.vGap10,
                _buildItemType(
                  p['type'],
                  p,
                ),
                // json.decode(p['json'])['resource']['status']==0? Text('文本'):Text('视频'),
                // Text(json.decode(p['json'])['resource']['title']),

                // Row(
                //   children: [
                //     // Padding(
                //     //   padding: EdgeInsets.only(top: ScreenUtil().setWidth(10)),
                //     //   child: Text(
                //     //       '${NumberUtils.amountConversion(p['likedCount'])}',
                //     //       style:
                //     //           TextStyle(fontSize: 12, color: Colors.black38)),
                //     // ),
                //     SizedBox(width: 17.w),
                //     Image.asset(
                //       ConstImgResource.share,
                //       width: 22.w,
                //       height: 22.h,
                //       color: Colors.grey,
                //     ),
                //     Text('转发'),
                //     SizedBox(width: 50.w),
                //     Image.asset(
                //       ConstImgResource.comment,
                //       width: 22.w,
                //       height: 22.h,
                //       color: Colors.grey,
                //     ),
                //     Text('评论'),
                //     SizedBox(width: 50.w),
                //     Image.asset(
                //       ConstImgResource.praise,
                //       width: 22.w,
                //       height: 22.h,
                //       color: Colors.grey,
                //     ),
                //     Text('点赞'),
                //   ],
                // ),
                Gaps.vGap10,
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(8),
                //   child: Image.network(
                //       json.decode(p['json'])['program']['dj']['backgroundUrl'],
                //       width: 150,
                //       height: 150,
                //       fit: BoxFit.cover),
                // ),
                Gaps.vGap10,
                // Container(
                //   padding: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     color: Colors.grey[300],
                //     // 底色
                //     //        shape: BoxShape.circle, // 圆形，使用圆形时不可以使用borderRadius
                //     shape: BoxShape.rectangle,
                //     // 默认值也是矩形
                //     borderRadius: BorderRadius.circular((10.0)), // 圆角度
                //   ),
                //   child: Expanded(
                //     child: Row(
                //       children: [
                //         ClipRRect(
                //           borderRadius: BorderRadius.circular(8),
                //           // child: Image.network(
                //           //     json.decode(p['json'])['program']['coverUrl'],
                //           //     width: 50,
                //           //     height: 50,
                //           //     fit: BoxFit.cover),
                //         ),
                //         Gaps.hGap10,
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             // Text(json.decode(p['json'])['program']['name']),
                //             Row(
                //               children: [
                //                 Container(
                //                   padding: EdgeInsets.only(
                //                       left: 2, right: 2, top: 1, bottom: 1),
                //                   child: Center(
                //                       // child: Text(
                //                       //   json.decode(p['json'])['program']['radio']
                //                       //       ['category'],
                //                       //   style: TextStyle(
                //                       //     fontSize: 8,
                //                       //     color: Colors.red,
                //                       //   ),
                //                       // ),
                //                       ),
                //                   decoration: BoxDecoration(
                //                     border: Border.all(
                //                         color: Colors.red, width: 0.5),
                //                     color: Colors.transparent,
                //                     shape: BoxShape.rectangle, // 默认值也是矩形
                //                     borderRadius:
                //                         BorderRadius.circular((4.0)), // 圆角度
                //                   ),
                //                 ),
                //                 // Text(json.decode(p['json'])['program']['radio']
                //                 //     ['name']),
                //               ],
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getText(String p) {
    StringBuffer stringBuffer = new StringBuffer();
    var length = json.decode(p)['song']['artists'].length;
    json.decode(p)['song']['artists'].forEach((item) {
      if (length == 1) {
        stringBuffer.write(item['name']);
      }
      if (length > 1) {
        stringBuffer.write(item['name']);
        stringBuffer.write('/');
      }

      length--;
    });

    return Text(stringBuffer.toString());
  }

  Widget _buildItemText(int type) {
    if (type == 18) {
      return Text('分享单曲:');
    }
    if (type == 22) {
      return Text('转发:');
    }
    if (type == 35) {
      return Text('');
    }
    if (type == 39) {
      return Text('发布Mlog:');
    }
    if (type == 56) {
      return Text('分享:');
    }
    if (type == 57) {
      return Text('视频:');
    }
    return Container();
  }

  Widget _buildItemType(int type, d) {
    if (type == 18) {
      String p = d['json'];
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
        dense: true,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            width: 50,
            height: 50,
            imageUrl: json.decode(p)['song']['album']['blurPicUrl'] == null
                ? ""
                : json.decode(p)['song']['album']['blurPicUrl'],
            placeholder: (context, url) => ProgressView(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        title: Text(
          json.decode(p)['song']['name'],
          style: TextStyle(),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: getText(p),
      );
    }
    if (type == 22) {
      return Text('转发:');
    }
    if (type == 35) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: Colors.transparent,
          // margin: EdgeInsets.only(top: 18),
//      padding: const EdgeInsets.all(18.0),
          child: LayoutBuilder(builder: (context, constraints) {
            int count = 3;
            double spacing = 3;
            double totalWidthSpacing = spacing * (count + 1);
            double width = ((constraints.maxWidth - totalWidthSpacing) ~/ count)
                .toDouble();
            print(width);
            return Padding(
              padding: EdgeInsets.only(left: 0),
              child: Wrap(
                spacing: spacing,
                direction: Axis.horizontal,
                children: d['pics'].map<Widget>((p) {
                  return Container(
                    width: width,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: width,
                            height: width,
                            imageUrl:
                                p['originUrl'] == null ? "" : p['originUrl'],
                            placeholder: (context, url) => ProgressView(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Container(
                          height: spacing,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          }),
        ),
      );
    }
    if (type == 39) {
      String p = d['json'];
      return ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          width: 200,
          height: 250,
          imageUrl: json.decode(p)['video']['coverUrl'] == null
              ? ""
              : json.decode(p)['video']['coverUrl'],
          placeholder: (context, url) => ProgressView(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      );
    }
    if (type == 56) {
      String p = d['json'];
      return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
        dense: true,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            width: 50,
            height: 50,
            imageUrl: json.decode(p)['resource']['coverImgUrl'] == null
                ? ""
                : json.decode(p)['resource']['coverImgUrl'],
            placeholder: (context, url) => ProgressView(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        title: Text(
          json.decode(p)['resource']['title'],
          style: TextStyle(),
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(json.decode(p)['resource']['subTitle']),
      );
    }
    if (type == 57) {
      return Text('视频');
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: ListView(
        children: [
          Gaps.vGap5,
          Column(
            children: list.map((p) {
              //选项卡
              return _buildItem(context, p);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
