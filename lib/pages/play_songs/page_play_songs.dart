import 'package:cloud_music/data/protocol/tracks.dart';
import 'package:cloud_music/manager/audio_paly_manager.dart';
import 'package:cloud_music/pages/play_songs/page_songplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/base/res/gaps.dart';
import 'dart:ui';
import 'package:cloud_music/base/res/styles.dart';
import 'package:cloud_music/widget/widget_play_bottom_menu.dart';
import 'package:common_utils/common_utils.dart';
import 'package:cloud_music/widget/widget_round_img.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_music/pages/play_songs/lyric_page.dart';

class PlaySongsPage extends StatefulWidget {
  @override
  _PlaySongsPageState createState() => _PlaySongsPageState();
}

class _PlaySongsPageState extends State<PlaySongsPage>
    with TickerProviderStateMixin {
  late Animation<double> _stylusAnimation;
  late AnimationController _stylusController; //唱针控制器
  late AnimationController _controller; // 封面旋转控制器
  int switchIndex = 0; //用于切换歌词
  @override
  void initState() {
    super.initState();
    _stylusController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    _stylusAnimation =
        Tween<double>(begin: -0.03, end: -0.10).animate(_stylusController);
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    _controller.addStatusListener((status) {
      // 转完一圈之后继续
      if (status == AnimationStatus.completed) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      // if (tracks.al != null) {
      //   if (tracks.al.name != null) stringBuffer.write('-');
      //   stringBuffer.write(tracks.al.name);
      // }

      return stringBuffer.toString();
    }
    return Consumer<AudioPlayManager>(builder: (context, model, child) {
      var curSong = model.curSong;
      if (model.curState == PlayerState.PLAYING) {
        // 如果当前状态是在播放当中，则唱片一直旋转，
        // 并且唱针是移除状态
        _controller.forward();
        _stylusController.reverse();
      } else {
        _controller.stop();
        _stylusController.forward();
      }
      return Scaffold(
          body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
              image: NetworkImage(
                  curSong.al.picUrl),
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
                  curSong.name,
                  style: TextStyles.commonWhiteTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getText(curSong),
                      style: TextStyles.smallWhite70TextStyle,
                    ),
                    Icon(
                      Icons.chevron_right_sharp,
                      size: 16,
                      color: Colors.white70,
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.share_outlined),
                onPressed: () {
                  if (switchIndex == 0) {
                    _controller.forward();
                    _stylusController.reverse();
                    switchIndex = 1;
                  } else {
                    switchIndex = 0;
                    _controller.stop();
                    _stylusController.forward();
                  }
                },
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
                top: kToolbarHeight + MediaQuery.of(context).padding.top),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                   child: Container(
                     // color: Colors.red,
                       child: GestureDetector(
                         ///点击穿透
                         behavior: HitTestBehavior.translucent,
                         onTap: () {
                           setState(() {
                             if (switchIndex == 0) {
                               switchIndex = 1;
                             } else {
                               switchIndex = 0;
                             }
                           });
                         },
                         child: Container(
                           child: IndexedStack(
                             index: switchIndex,
                             children: [
                               Stack(
                                 children: [
                                   Align(
                                     alignment: Alignment.topCenter,
                                     child: Container(
                                       // color: Colors.white70,
                                       margin: EdgeInsets.only(top: ScreenUtil().setWidth(150)),
                                       child: Stack(
                                         alignment: Alignment.center,
                                         children: <Widget>[
                                           RoundImgWidget(
                                              curSong.al.picUrl,
                                               MediaQuery.of(context).size.width -
                                                   140),
                                           RotationTransition(
                                             turns: _controller,
                                             child: RoundImgWidget(
                                                 curSong.al.picUrl,
                                                 MediaQuery.of(context).size.width -
                                                     140),
                                           ),
                                           Image.asset(
                                             'images/bet.png',
                                             width: MediaQuery.of(context).size.width -
                                                 90,
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                   Align(
                                     child: RotationTransition(
                                       turns: _stylusAnimation,
                                       alignment: Alignment(
                                           -1 +
                                               (ScreenUtil().setWidth(45 * 2) /
                                                   (ScreenUtil().setWidth(293))),
                                           -1 +
                                               (ScreenUtil().setWidth(45 * 2) /
                                                   (ScreenUtil().setWidth(504)))),
                                       child: Image.asset(
                                         'images/bgm.png',
                                         width: ScreenUtil().setWidth(205),
                                         height: ScreenUtil().setWidth(352.8),
                                       ),
                                     ),
                                     alignment: Alignment(0.25, -1),
                                   ),
                                 ],
                               ),
                               // SongPlay(model),
                               LyricPage(model),
                             ],
                           ),
                         ),
                       )
                   ),),

                // _buildSongsHandle(),
                StreamBuilder<String>(
                  stream: model.curPositionStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var totalTime = snapshot.data!
                          .substring(snapshot.data!.indexOf('-') + 1);
                      var startTime = double.parse(snapshot.data!
                          .substring(0, snapshot.data!.indexOf('-')));
                      return _buildProgress(
                        startTime,
                        totalTime,
                      );
                    } else {
                      return _buildProgress(
                        0,
                        "0",
                      );
                    }
                  },
                ),

                PlayBottomMenuWidget(),
              ],
            ),
          ),
        ],
      ));
    });
  }

  // Widget _buildSongsHandle() {
  //   return Container(
  //     child: Row(
  //       children: <Widget>[
  //         ImageMenuWidget('images/icon_dislike.png', 40),
  //         ImageMenuWidget(
  //           'images/icon_song_download.png',
  //           40,
  //           onTap: () {},
  //         ),
  //         ImageMenuWidget(
  //           'images/bfc.png',
  //           40,
  //           onTap: () {},
  //         ),
  //         Expanded(
  //           child: Align(
  //             child: Container(
  //               width: ScreenUtil().setWidth(130),
  //               height: ScreenUtil().setWidth(80),
  //               child: CustomFutureBuilder<SongCommentData>(
  //                 futureFunc: NetUtils.getSongCommentData,
  //                 params: {'id': model.curSong.id, 'offset': 1},
  //                 loadingWidget: Image.asset(
  //                   'images/icon_song_comment.png',
  //                   width: ScreenUtil().setWidth(80),
  //                   height: ScreenUtil().setWidth(80),
  //                 ),
  //                 builder: (context, data) {
  //                   return GestureDetector(
  //                     onTap: () {
  //                       NavigatorUtil.goCommentPage(context,
  //                           data: CommentHead(
  //                               model.curSong.picUrl,
  //                               model.curSong.name,
  //                               model.curSong.artists,
  //                               data.total,
  //                               model.curSong.id,
  //                               CommentType.song.index));
  //                     },
  //                     child: Stack(
  //                       alignment: Alignment.center,
  //                       children: <Widget>[
  //                         Image.asset(
  //                           'images/icon_song_comment.png',
  //                           width: ScreenUtil().setWidth(80),
  //                           height: ScreenUtil().setWidth(80),
  //                         ),
  //                         Align(
  //                           alignment: Alignment.topRight,
  //                           child: Container(
  //                             margin: EdgeInsets.only(
  //                                 top: ScreenUtil().setWidth(12)),
  //                             width: ScreenUtil().setWidth(58),
  //                             child: Text(
  //                               '${NumberUtils.formatNum(data.total)}',
  //                               style: common10White70TextStyle,
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           ),
  //         ),
  //         ImageMenuWidget('images/icon_song_more.png', 40),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildProgress(double startTime, String totalTime) {
    return Container(
      // color: Colors.green,
      child: Row(
        children: <Widget>[
          Gaps.hGap15,
          Text(
            DateUtil.formatDateMs(startTime.toInt(), format: "mm:ss"),
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
              max: double.parse(totalTime),
            ),
          ),
          Text(
            DateUtil.formatDateMs(int.parse(totalTime), format: "mm:ss"),
            style: TextStyles.smallWhiteTextStyle,
          ),
          Gaps.hGap15,
        ],
      ),
    );
  }
}
