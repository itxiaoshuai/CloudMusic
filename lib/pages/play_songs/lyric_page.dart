import 'dart:async';

import 'package:cloud_music/base/utils/string.dart';
import 'package:cloud_music/manager/audio_paly_manager.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:flutter/material.dart';
import 'package:cloud_music/data/protocol/lyric.dart';
import 'package:cloud_music/pages/play_songs/widget_lyric.dart';
import '../../r.dart';
import '../../subtitle.dart';
import '../../subtitle_entry.dart';

class LyricPage extends StatefulWidget {
  final AudioPlayManager model;

  LyricPage(this.model);

  @override
  _LyricPageState createState() => _LyricPageState();
}

class _LyricPageState extends State<LyricPage> with TickerProviderStateMixin {
  int curSongId;
  LyricData _lyricData;
  List<Lyric> lyrics;
  LyricWidget _lyricWidget;
  List<SubtitleEntry> _subtitleList = [];

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((call) {
    //   curSongId = widget.model.curSong.id;
    //   _request();
    //   // loadData();
    // });
    _request();
  }

  void _request() async {
    Map<String, dynamic> formData = {
      'id': 33894312,
    };
    _lyricData = await RequestManager.getLyricData(formData);
    // print('${_lyricData.lrc.lyric}');
    setState(() {
      lyrics = formatLyric(_lyricData.lrc.lyric);
      _lyricWidget = LyricWidget(lyrics, 0);

      List<String> list = _lyricData.lrc.lyric.split(RegExp('\n'));

      list.forEach((s) {
        print('list----${s}');
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: StreamBuilder<String>(
        stream: widget.model.curPositionStream,
        builder: (context, snapshot) {
          print('curPositionStream=====${widget.model.curPositionStream}');
          if (snapshot.hasData) {
            var curTime = double.parse(
                snapshot.data.substring(0, snapshot.data.indexOf('-')));
            print('curTime=====${curTime}');

            // 获取当前在哪一行
            int curLine = findLyricIndex(curTime, lyrics);

            // 给 customPaint 赋值当前行
            _lyricWidget.curLine = curLine;
            return Subtitle(
              _subtitleList,
              diameterRatio: 20,
              selectedTextStyle: R.style.commonWhiteTextStyle,
              unSelectedTextStyle: R.style.commonWhite70TextStyle,
              itemExtent: 30,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
