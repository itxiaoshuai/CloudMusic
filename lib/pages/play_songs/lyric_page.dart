import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_music/base/utils/string.dart';
import 'package:cloud_music/manager/audio_paly_manager.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/data/protocol/lyric.dart';
import 'package:cloud_music/pages/play_songs/widget_lyric.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../r.dart';
import '../../subtitle.dart';
import '../../subtitle_entry.dart';

int curSongId = 0;

class LyricPage extends StatefulWidget {
  final AudioPlayManager model;

  LyricPage(this.model);

  @override
  _LyricPageState createState() => _LyricPageState();
}

class _LyricPageState extends State<LyricPage> with TickerProviderStateMixin {
  late LyricData _lyricData;
  List<Lyric> lyrics = [];
  late LyricWidget _lyricWidget;
  List<SubtitleEntry> _subtitleList = [];
  late AnimationController _lyricOffsetYController;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((call) {
    //   curSongId = widget.model.curSong.id;
    //   _request();
    //   // loadData();
    // });
    _lyricOffsetYController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              // _lyricOffsetYController.dispose();
            }
          });
    curSongId = widget.model.curSong.id;

    _request(curSongId);
  }

  void _request(int id) async {
    Map<String, dynamic> formData = {
      'id': id,
    };
    _lyricData = await RequestManager.getLyricData(formData);
    print('${_lyricData.lrc.lyric}');
    setState(() {
      lyrics = formatLyric(_lyricData.lrc.lyric);
      _lyricWidget = LyricWidget(lyrics, 0);

      List<String> list = _lyricData.lrc.lyric.split(RegExp('\n'));
      // loadData();
      list.forEach((s) {
        print('list----$s');
        if (s.isNotEmpty) {
          String time = s.substring(0, s.indexOf(']'));
          String lyric = s.substring(s.indexOf(']') + 1);
          int minuteSeparatorIndex = time.indexOf(".");
          time = time.substring(1, minuteSeparatorIndex);
          _subtitleList.add(SubtitleEntry(time, lyric));
        }
      });
    });
  }

  loadData() async {
    var jsonStr =
        await DefaultAssetBundle.of(context).loadString('assets/subtitle.txt');
    var list = jsonStr.split(RegExp('\n'));
    list.forEach((f) {
      if (f.isNotEmpty) {
        var r = f.split(RegExp(' '));
        if (r.length >= 2) {
          _subtitleList.add(SubtitleEntry(r[0], r[1]));
        }
      }
    });
    setState(() {});
  }

  /// 开始下一行动画
  void startLineAnim(int curLine) {
    // 判断当前行和 customPaint 里的当前行是否一致，不一致才做动画
    if (_lyricWidget.curLine != curLine) {
      // 如果动画控制器不是空，那么则证明上次的动画未完成，
      // 未完成的情况下直接 stop 当前动画，做下一次的动画
      if (_lyricOffsetYController != null) {
        _lyricOffsetYController.stop();
      }

      // 初始化动画控制器，切换歌词时间为300ms，并且添加状态监听，
      // 如果为 completed，则消除掉当前controller，并且置为空。
      _lyricOffsetYController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 300))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _lyricOffsetYController.stop();
          }
        });
      // 计算出来当前行的偏移量
      var end = _lyricWidget.computeScrollY(curLine) * -1;
      // 起始为当前偏移量，结束点为计算出来的偏移量
      Animation animation =
          Tween<double>(begin: _lyricWidget.getOffsetY, end: end)
              .animate(_lyricOffsetYController);
      // 添加监听，在动画做效果的时候给 offsetY 赋值
      _lyricOffsetYController.addListener(() {
        _lyricWidget.offsetY = animation.value;
      });
      // 启动动画
      _lyricOffsetYController.forward();
    }
  }

  Widget _buildPlayStateWidget(AudioPlayManager manager) {
    print('播放状态xxxxxxxxxxxxx---->${manager.curState}');
    if (manager.curSong.id != curSongId) {
      _request(manager.curSong.id);
    }
    return Container(
      alignment: Alignment.center,
      child: Text(
        '歌词加载中...',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioPlayManager>(builder: (context, model, child) {
      return Scaffold(
          backgroundColor: Colors.transparent,
          body: lyrics.isEmpty
              ? _buildPlayStateWidget(model)
              : Container(
                  color: Colors.transparent,
                  child: StreamBuilder<String>(
                    stream: widget.model.curPositionStream,
                    builder: (context, snapshot) {
                      // print(
                      //     'curPositionStream=====${widget.model.curPositionStream}');
                      if (snapshot.hasData) {
                        var curTime = double.parse(snapshot.data!
                            .substring(0, snapshot.data!.indexOf('-')));
                        // print('curTime=====${curTime}');
                        if (model.curSong.id != curSongId) {
                          curSongId = model.curSong.id;
                          _request(curSongId);
                        }
                        // 获取当前在哪一行
                        int curLine = findLyricIndex(curTime, lyrics);
                        if (!_lyricWidget.isDragging) {
                          startLineAnim(curLine);
                        }
                        // 给 customPaint 赋值当前行
                        _lyricWidget.curLine = curLine;
                        return CustomPaint(
                          size: Size(
                              MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height -
                                  kToolbarHeight -
                                  ScreenUtil().setWidth(150) -
                                  ScreenUtil().setWidth(50) -
                                  MediaQuery.of(context).padding.top -
                                  ScreenUtil().setWidth(120)),
                          painter: _lyricWidget,
                        );
                        return Subtitle(
                          _subtitleList,
                          diameterRatio: 20,
                          selectedTextStyle: R.style.commonWhiteTextStyle,
                          unSelectedTextStyle: R.style.commonWhite70TextStyle,
                          itemExtent: 30,
                        );
                      } else {
                        return Subtitle(
                          _subtitleList,
                          diameterRatio: 20,
                          selectedTextStyle: R.style.commonWhiteTextStyle,
                          unSelectedTextStyle: R.style.commonWhite70TextStyle,
                          itemExtent: 30,
                        );
                      }
                    },
                  ),
                ));
    });
  }
}
