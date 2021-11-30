import 'dart:ffi';

import 'package:cloud_music/base/res/gaps.dart';
import 'package:cloud_music/base/utils/time_utils.dart';
import 'package:cloud_music/data/protocol/user_detail_bean.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';

import '../../r.dart';

class PageUserBaseInfo extends StatefulWidget {
  ///用户ID
  final UserDetail userDetail;

  const PageUserBaseInfo({ Key? key, required this.userDetail}) : super(key: key);
  @override
  _PageUserBaseInfoState createState() => _PageUserBaseInfoState();
}

class _PageUserBaseInfoState extends State<PageUserBaseInfo> {
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
          "基本信息",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
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
                    "个人信息",
                    style: R.style.textBoldDark14,
                  ),
                  Gaps.vGap10,
                  Text(
                    "村龄:${widget.userDetail.createDays ~/ 365}年(${DateUtil.formatDateMs(widget.userDetail.createTime, format: 'yyyy年MM月注册')})",
                    style: R.style.textGray14,
                  ),
                  Gaps.vGap10,
                  Text(
                    "性别:${widget.userDetail.profile.gender == 2 ? '女' : '男'}",
                    style: R.style.textGray14,
                  ),
                  Gaps.vGap10,
                  Text(
                    "年龄:${TimeUtils.getAgeGroup(widget.userDetail.profile.birthday)}${TimeUtils.getconstellation(widget.userDetail.profile.birthday)}",
                    style: R.style.textGray14,
                  ),
                ],
              ),
            ),
            // Gaps.line,
            Container(
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "个人介绍",
                    style: R.style.textBoldDark14,
                  ),
                  Gaps.vGap10,
                  Text(
                    "村龄:${'还没有填写个人介绍'}",
                    style: R.style.textGray14,
                  ),
                  Gaps.vGap10,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
