import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../../../base/CommonLoading.dart';
import '../../../r.dart';

class MessageCommentPage extends StatefulWidget {
  var notice;

  MessageCommentPage({this.notice});

  @override
  State<StatefulWidget> createState() => _MessageCommentPageState();
}

class _MessageCommentPageState extends State<MessageCommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //修改颜色
        ),
        backgroundColor: Colors.white,
        title: Text(
          '评论',
          style: R.style.textDark16,
        ),
      ),
      body: _buildItem(context,json.decode(widget.notice)),
      // body: Container(
      //   // color: Colors.green,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       // Text(
      //       //   json.decode(widget.notice)['comment']['user']['avatarUrl'],
      //       // ),
      //       Row(
      //         children: [
      //           Gaps.hGap15,
      //           InkWell(
      //             child: CircleAvatar(
      //               backgroundImage: NetworkImage(json
      //                   .decode(widget.notice)['track']['user']['avatarUrl']),
      //               backgroundColor: Colors.black,
      //               radius: 15.0,
      //             ),
      //             onTap: (){
      //               // Navigator.of(context).pushNamed(
      //               //     RouteName.USER_HOME,
      //               //     arguments: json.decode(p['notice'])['user']
      //               //     ['userId']);
      //             },
      //           ),
      //           Gaps.hGap15,
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(json.decode(widget.notice)['track']['user']
      //                   ['nickname']),
      //               Text(
      //                 '${DateUtil.formatDateMs(json.decode(widget.notice)['track']['showTime'], format: 'yyyy年MM月dd日')}',
      //                 style: R.style.textGray10,
      //               )
      //             ],
      //           ),
      //           Spacer(),
      //         ],
      //       ),
      //       Text(
      //         json.decode(json.decode(widget.notice)['track']['json'])['msg'],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

Widget _buildItem(BuildContext context, p) {
  return Container(
    // color: Colors.blue,
    padding: EdgeInsets.only(left: 15, right: 15,top: 10),
    child: Column(
      crossAxisAlignment:CrossAxisAlignment.start ,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CircleAvatar(
              backgroundImage: NetworkImage(
                  p['track']['user']['avatarUrl']
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
                      Text(p['track']['user']['nickname']),
                      // Text(p['type'].toString() + ''),
                      Gaps.hGap5,
                      // _buildItemText(p['type'])
                    ],
                  ),
                  Gaps.vGap5,
                  Text(
                    '${DateUtil.formatDateMs(p['track']['showTime'], format: 'yyyy年MM月dd日')}',
                    style: R.style.textGray10,
                  ),
                ],
              ),
            ),

          ],
        ),
        Gaps.vGap24,
        Text(json.decode(p['track']['json'])['msg']),
        Gaps.vGap10,
        _buildItemType(
          p['type'],
          p['track']['json'],
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
  if (type == 1) {
    var p = json.decode(d);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
      dense: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          width: 50,
          height: 50,
          imageUrl: p['playlist']['coverImgUrl'] == null
              ? ""
              : p['playlist']['coverImgUrl'],
          placeholder: (context, url) => ProgressView(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      title: Text(
        p['playlist']['name'],
        style: TextStyle(),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text("by "+ p['playlist']['creator']['nickname']),
    );
  }
  if (type == 57) {
    return Text('视频');
  }
  return Container();
}
