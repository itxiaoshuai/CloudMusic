import 'package:flutter/material.dart';
import 'package:flutter_app/base/ConstImg.dart';
import 'package:flutter_app/base/res/gaps.dart';
import 'package:flutter_app/base/res/styles.dart';
import 'package:flutter_app/data/protocol/playlist_detail.dart';
import 'package:flutter_app/widget/item/list_item.dart';

///单个歌曲(item)
class TrackItem extends StatelessWidget {
  final int index;
  final Tracks tracks;

  TrackItem({this.index, this.tracks});

  String getText(Tracks tracks) {
    StringBuffer stringBuffer = new StringBuffer();
    var length = tracks.ar.length;
    tracks.ar.forEach((item) {
      if (length == 1) {
        stringBuffer.write(item.name);
      }
      if (length > 1) {
        stringBuffer.write(item.name);
        stringBuffer.write('/');
      }

      length--;
    });
    if (tracks.al != null) {
      if (tracks.al.name != null) stringBuffer.write('-');
      stringBuffer.write(tracks.al.name);
    }

    return stringBuffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.redAccent,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              index.toString(),
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Container(
//              color: Colors.amberAccent,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //将自由空间均匀地放置在孩子之间以及第一个和最后一个孩子之前和之后
                  children: [
                    Expanded(
                      child: Container(
//                      color: Colors.green,
                          child: Center(
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            tracks.name,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )),
                    ),
                    Expanded(
                      child: Container(
//                      color: Colors.green,
                          child: Center(
                        child: Align(
                          alignment: FractionalOffset.centerLeft,
                          child: Text(
                            getText(tracks),
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )),
                    ),
                  ]),
            ),
          ),
          Container(
//            color: Colors.blue,
            child: IconButton(
                iconSize: 25,
                icon: ImageIcon(AssetImage("images/album/track_mv.png")),
                color: Colors.grey[500],
                onPressed: () {}),
          ),
          Container(
//            color: Colors.red,
            child: IconButton(
                iconSize: 15,
                icon: ImageIcon(AssetImage("images/album/track_more.png")),
                color: Colors.grey[500],
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 406.0,
                        child: BottomSheetWidget(),
                      );
                    },
                  ).then((val) {
                    print(val);
                  });
                }),
          ),
        ],
      ),
    );
  }
}

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
                  style: TextStyles.textBoldDark14,
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
