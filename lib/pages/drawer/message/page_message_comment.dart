import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

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
      body: Container(
        // color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              json.decode(widget.notice)['comment']['user']['avatarUrl'],
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(json
                      .decode(widget.notice)['comment']['user']['avatarUrl']),
                  backgroundColor: Colors.black,
                  radius: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(json.decode(widget.notice)['comment']['user']
                        ['nickname']),
                    Text(
                      '${DateUtil.formatDateMs(json.decode(widget.notice)['comment']['time'], format: 'yyyy年MM月dd日')}',
                      style: R.style.textGray10,
                    )
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Text('2'),
                    Image.asset(R.mipmap.praise),
                  ],
                ),
              ],
            ),
            Text(
              json.decode(widget.notice)['comment']['content'],
            ),
          ],
        ),
      ),
    );
  }
}
