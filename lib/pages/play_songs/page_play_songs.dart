import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'dart:ui';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/widget/widget_play_bottom_menu.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:common_utils/common_utils.dart';
import 'package:cloud_music/widget/widget_img_menu.dart';
import 'package:cloud_music/widget/widget_round_img.dart';

class PlaySongsPage extends StatefulWidget {
  @override
  _PlaySongsPageState createState() => _PlaySongsPageState();
}

class _PlaySongsPageState extends State<PlaySongsPage>
    with TickerProviderStateMixin {
  Animation<double> _stylusAnimation;
  AnimationController _stylusController; //唱针控制器
  @override
  void initState() {
    super.initState();
    _stylusController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _stylusAnimation =
        Tween<double>(begin: -0.03, end: -0.10).animate(_stylusController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image(
            image: NetworkImage(
                'http://p3.music.126.net/JL0hXL3TNcjcfi0uJTKM-A==/109951163300299605.jpg'),
            fit: BoxFit.fitHeight),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 120, sigmaY: 30),
          child: Container(color: Colors.black.withOpacity(0.1)),
        ),
        AppBar(
          centerTitle: true,
          brightness: Brightness.dark,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.transparent,
          title: Column(
            children: <Widget>[
              Text(
                '我喜欢',
                style: TextStyles.commonWhiteTextStyle,
              ),

              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Text(
                    '上海彩虹室内合唱团',
                    style:TextStyles.smallWhite70TextStyle,
                  ),
                  Icon(Icons.chevron_right_sharp,size: 16,color: Colors.white70,),
                ],
              ),

            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.share_outlined),
              onPressed: () {},
            )
          ],
        ),
        Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                      top: kToolbarHeight + MediaQuery.of(context).padding.top),
                  child: Stack(
                    children: [
                      Align(
                        child: Container(
                          margin: EdgeInsets.only(top: 0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              RoundImgWidget(
                                  'http://p3.music.126.net/JL0hXL3TNcjcfi0uJTKM-A==/109951163300299605.jpg',
                                  MediaQuery.of(context).size.width - 140),
                              Image.asset(
                                'images/bet.png',
                                width: MediaQuery.of(context).size.width - 90,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        child: Container(
                          // color: Colors.red,
                          child: Image.asset(
                            'images/bgm.png',
                            width: 70,
                          ),
                        ),
                        //这里也可以用Alignment ，FractionalOffset 继承自 Alignment，它和 Alignment唯一的区别就是坐标原点不同！
                        // FractionalOffset 的坐标原点为矩形的左侧顶点，这和布局系统的一致，所以理解起来会比较容易。
                        alignment: FractionalOffset(
                            0.5 + 100 / MediaQuery.of(context).size.width / 2,
                            0),
                      ),
                    ],
                  ),
                ),
              ),
              _buildSongsHandle(),
              _buildProgress(0, 3*60*1000+57*1000, 0),
              PlayBottomMenuWidget(),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _buildSongsHandle() {
    return Container(
      child: Row(
        children: <Widget>[
          // ImageMenuWidget('images/icon_dislike.png', 40),
          // ImageMenuWidget(
          //   'images/icon_song_download.png',
          //   40,
          //   onTap: () {},
          // ),
          // ImageMenuWidget(
          //   'images/bfc.png',
          //   40,
          //   onTap: () {},
          // ),
          // Expanded(
          //   child: Align(
          //     child: Container(
          //       width: ScreenUtil().setWidth(130),
          //       height: ScreenUtil().setWidth(80),
          //       child: CustomFutureBuilder<SongCommentData>(
          //         futureFunc: NetUtils.getSongCommentData,
          //         params: {'id': model.curSong.id, 'offset': 1},
          //         loadingWidget: Image.asset(
          //           'images/icon_song_comment.png',
          //           width: ScreenUtil().setWidth(80),
          //           height: ScreenUtil().setWidth(80),
          //         ),
          //         builder: (context, data) {
          //           return GestureDetector(
          //             onTap: () {
          //               NavigatorUtil.goCommentPage(context, data: CommentHead(model.curSong.picUrl, model.curSong.name, model.curSong.artists, data.total, model.curSong.id, CommentType.song.index));
          //             },
          //             child: Stack(
          //               alignment: Alignment.center,
          //               children: <Widget>[
          //                 Image.asset(
          //                   'images/icon_song_comment.png',
          //                   width: ScreenUtil().setWidth(80),
          //                   height: ScreenUtil().setWidth(80),
          //                 ),
          //                 Align(
          //                   alignment: Alignment.topRight,
          //                   child: Container(
          //                     margin: EdgeInsets.only(top: ScreenUtil().setWidth(12)),
          //                     width: ScreenUtil().setWidth(58),
          //                     child: Text(
          //                       '${NumberUtils.formatNum(data.total)}',
          //                       style: common10White70TextStyle,
          //                     ),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // ),
          // ImageMenuWidget('images/icon_song_more.png', 40),
        ],
      ),
    );
  }

  Widget _buildProgress(int startTime, int duration, int curTimeStr) {
    return Container(
      // color: Colors.green,
      child: Row(
        children: <Widget>[
          Gaps.hGap15,
          Text(
            DateUtil.formatDateMs(curTimeStr, format: "mm:ss"),
            style: TextStyles.smallWhiteTextStyle,
          ),
          Expanded(
            child: Slider(
              value: startTime.toDouble(),
              onChanged: (data) {},
              onChangeStart: (data) {},
              onChangeEnd: (data) {},
              activeColor: Colors.white,
              inactiveColor: Colors.white30,
              min: 0,
              max: duration.toDouble(),
            ),
          ),
          Text(
            DateUtil.formatDateMs(duration, format: "mm:ss"),
            style: TextStyles.smallWhiteTextStyle,
          ),
          Gaps.hGap15,
        ],
      ),
    );
  }
}
