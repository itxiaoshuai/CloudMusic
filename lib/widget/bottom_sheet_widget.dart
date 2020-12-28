import 'package:cloud_music/base/ConstImg.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'package:flutter/material.dart';

import '../r.dart';
import 'item/list_item.dart';

class BottomSheetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 56,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child: Row(children: <Widget>[
              Gaps.hGap15,
              Expanded(
                child: Text(
                  "已选类别",
                  style: R.style.textBoldDark14,
                ),
              ),
              InkWell(
                child: Icon(Icons.close, color: Colors.grey),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Gaps.hGap15,
            ]),
          ),
          Gaps.line,
          Expanded(
              child: Container(
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          ListItem(image: "images/ticket.png", text: "下一首播放"),
                          ListItem(image: "images/ticket.png", text: "收藏到歌单"),
                          ListItem(
                              image: ConstImgResource.download, text: "下载"),
                          ListItem(image: ConstImgResource.comment, text: "评论"),
                          ListItem(image: ConstImgResource.share, text: "分享"),
                          ListItem(
                              image: "images/pocket_ringtone.png",
                              text: "歌手:Marro5"),
                          ListItem(
                              image: "images/timing.png",
                              text: "专辑:Nobody's Love"),
                          ListItem(image: "images/timing.png", text: "云歌推荐"),
                          ListItem(image: "images/alarm.png", text: "设为铃声"),
                          ListItem(image: "images/alarm.png", text: "购买单曲"),
                          ListItem(
                              image: "images/music_free_flow.png",
                              text: "人气榜应援"),
                          ListItem(image: "images/coupon.png", text: "屏蔽歌曲或歌手"),
                        ],
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}