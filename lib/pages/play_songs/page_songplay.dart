import 'package:cloud_music/base/utils/string.dart';
import 'package:cloud_music/data/protocol/lyric.dart';
import 'package:cloud_music/manager/audio_paly_manager.dart';
import 'package:cloud_music/manager/request_manager.dart';
import 'package:cloud_music/pages/play_songs/widget_lyric.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../subtitle_entry.dart';

class SongPlay extends StatefulWidget {
  final AudioPlayManager model;

  SongPlay(this.model);

  @override
  _SongPlayState createState() => _SongPlayState();
}

final ItemScrollController itemScrollController = ItemScrollController();
final ItemPositionsListener itemPositionsListener =
    ItemPositionsListener.create();

class _SongPlayState extends State<SongPlay> {
  late LyricData _lyricData;
  late List<Lyric> lyrics;
  late LyricWidget _lyricWidget;
  List<SubtitleEntry> _subtitleList = [];

  @override
  void initState() {
    _request();
    super.initState();
  }

  void _request() async {
    Map<String, dynamic> formData = {
      'id': 33894312,
    };
    _lyricData = await RequestManager.getLyricData(formData);
    print('${_lyricData.lrc.lyric}');
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

  void scrollTo(int index) async {
    if (itemScrollController.isAttached) {
      await itemScrollController.scrollTo(
          index: index,
          duration: new Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          alignment: 0.5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: StreamBuilder<String>(
        stream: widget.model.curPositionStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var curTime = double.parse(
                snapshot.data!.substring(0, snapshot.data!.indexOf('-')));
            // print('curTime=====${curTime}');

            // 获取当前在哪一行
            int curLine = findLyricIndex(curTime, lyrics);
            scrollTo(curLine);
            // 给 customPaint 赋值当前行
            _lyricWidget.curLine = curLine;

            return Material(
                color: Colors.transparent,
                child: ScrollablePositionedList.builder(
                  itemCount: _subtitleList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {},
                    child: Container(
                      child: Text(_subtitleList[index].content,
                          style: TextStyle(
                              color: _lyricWidget.curLine == index
                                  ? Colors.white
                                  : Colors.white30),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                ));
          } else {
            return Material(
                color: Colors.transparent,
                child: ScrollablePositionedList.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _subtitleList.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {},
                    child: Container(
                      child: Text(_subtitleList[index].content,
                          style: TextStyle(
                              color: _lyricWidget.curLine == index
                                  ? Colors.white
                                  : Colors.white30),
                          textAlign: TextAlign.center),
                    ),
                  ),
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                ));
          }
        },
      ),
    );
  }
}
