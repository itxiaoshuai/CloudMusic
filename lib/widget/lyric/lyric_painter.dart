import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'lyric.dart';

class LyricPainter extends CustomPainter with ChangeNotifier {
  //歌词列表
  late List<Lyric> lyrics;

  //翻译/音译歌词列表
  late List<Lyric> subLyrics;

  //画布大小
  Size canvasSize = Size.zero;

  //字体最大宽度
  late double lyricMaxWidth;

  //歌词间距
  late double lyricGapValue;

  //歌词间距
  late double subLyricGapValue;

  //通过偏移量控制歌词滑动
  late double _offset = 0;

  set offset(value) {
    _offset = value;
    notifyListeners();
  }

  get offset => _offset;

  //歌词位置
  int _currentLyricIndex = 0;

  get currentLyricIndex => _currentLyricIndex;

  set currentLyricIndex(value) {
    _currentLyricIndex = value;
    notifyListeners();
  }

  //歌词样式
  late TextStyle lyricTextStyle;

  //滑动歌词样式
  late TextStyle draggingLyricTextStyle;

  //滑动歌词样式
  late TextStyle draggingSubLyricTextStyle;

  //翻译/音译歌词样式
  late TextStyle subLyricTextStyle;

  //当前歌词样式
  late TextStyle currLyricTextStyle;

  //当前翻译/音译歌词样式
  late TextStyle currSubLyricTextStyle;

  //滑动到的行
  late int _draggingLine;

  get draggingLine => _draggingLine;

  set draggingLine(value) {
    this._draggingLine = value;
    notifyListeners();
  }

  //歌词画笔数组
  late final List<TextPainter> lyricTextPaints;

  //翻译/音译歌词画笔数组
  late final List<TextPainter> subLyricTextPaints;

  LyricPainter(this.lyrics, this.lyricTextPaints, this.subLyricTextPaints,
      {required this.subLyrics,
        required this.lyricTextStyle,
        required this.subLyricTextStyle,
        required this.currLyricTextStyle,
        required this.currSubLyricTextStyle,
        required this.draggingLyricTextStyle,
        required this.draggingSubLyricTextStyle,
        required this.lyricGapValue,
        required this.subLyricGapValue,
        required this.lyricMaxWidth});


  // @override
  // void paint(Canvas canvas, Size size) {
  //   canvasSize = size;
  //
  //   //初始化歌词的Y坐标在正中央
  //   lyricTextPaints[currentLyricIndex]
  //     //设置歌词
  //     ..text = TextSpan(
  //         text: lyrics[currentLyricIndex].lyric, style: currLyricTextStyle)
  //     ..layout(maxWidth: lyricMaxWidth);
  //   var currentLyricY = _offset +
  //       size.height / 2 -
  //       lyricTextPaints[currentLyricIndex].height / 2;
  //
  //   //遍历歌词进行绘制
  //   for (int lyricIndex = 0; lyricIndex < lyrics.length; lyricIndex++) {
  //     var currentLyric = lyrics[lyricIndex];
  //     var isCurrLine = currentLyricIndex == lyricIndex;
  //     var isDraggingLine = _draggingLine == lyricIndex;
  //     var currentLyricTextPaint = lyricTextPaints[lyricIndex]
  //       //设置歌词
  //       ..text = TextSpan(
  //           text: currentLyric.lyric,
  //           style: isCurrLine
  //               ? currLyricTextStyle
  //               : isDraggingLine
  //                   ? draggingLyricTextStyle
  //                   : lyricTextStyle);
  //     currentLyricTextPaint.layout(maxWidth: lyricMaxWidth);
  //     var currentLyricHeight = currentLyricTextPaint.height;
  //     //仅绘制在屏幕内的歌词
  //     if (currentLyricY < size.height && currentLyricY > 0) {
  //       //绘制歌词到画布
  //       currentLyricTextPaint
  //         ..paint(
  //             canvas,
  //             Offset((size.width - currentLyricTextPaint.width) / 2,
  //                 currentLyricY));
  //     }
  //     //当前歌词结束后调整下次开始绘制歌词的y坐标
  //     currentLyricY += currentLyricHeight + lyricGapValue;
  //     //如果有翻译歌词时,寻找该行歌词以后的翻译歌词
  //     if (subLyrics != null) {
  //       List<Lyric> remarkLyrics = subLyrics
  //           .where((subLyric) =>
  //               subLyric.startTime >= currentLyric.startTime &&
  //               subLyric.endTime <= currentLyric.endTime)
  //           .toList();
  //       remarkLyrics.forEach((remarkLyric) {
  //         //获取位置
  //         var subIndex = subLyrics.indexOf(remarkLyric);
  //
  //         var currentSubPaint = subLyricTextPaints[subIndex] //设置歌词
  //           ..text = TextSpan(
  //               text: remarkLyric.lyric,
  //               style: isCurrLine
  //                   ? currSubLyricTextStyle
  //                   : isDraggingLine
  //                       ? draggingSubLyricTextStyle
  //                       : subLyricTextStyle);
  //         //仅绘制在屏幕内的歌词
  //         if (currentLyricY < size.height && currentLyricY > 0) {
  //           currentSubPaint
  //             //计算文本宽高
  //             ..layout(maxWidth: lyricMaxWidth)
  //             //绘制 offset=横向居中
  //             ..paint(
  //                 canvas,
  //                 Offset((size.width - subLyricTextPaints[subIndex].width) / 2,
  //                     currentLyricY));
  //         }
  //         currentSubPaint..layout(maxWidth: lyricMaxWidth);
  //         //当前歌词结束后调整下次开始绘制歌词的y坐标
  //         currentLyricY += currentSubPaint.height + subLyricGapValue;
  //       });
  //     }
  //   }
  // }

  @override
  bool shouldRepaint(LyricPainter oldDelegate) {
    //当歌词进度发生变化时重新绘制
    return oldDelegate.currentLyricIndex != currentLyricIndex;
  }
  double _offsetY = 0;  bool isDragging = false; // 是否正在人为拖动
  int curLine=0;
  @override
  void paint(Canvas canvas, Size size) {
    debugPrint("Size----"+size.height.toString());
    debugPrint("Size----"+size.height.toString());

    canvasSize = size;
    var y = _offsetY + size.height / 2 + lyricTextPaints[0].height / 2;

    for (int i = 0; i < lyrics.length; i++) {
      if (y > size.height || y < (0 - lyricTextPaints[i].height / 2)) {
      } else {
        // 画每一行歌词
        if (curLine == i) {
          // 如果是当前行
          lyricTextPaints[i].text =
              TextSpan(text: lyrics[i].lyric, style: TextStyle(fontSize: 16, color: Colors.grey));
          lyricTextPaints[i].layout();
        } else if (isDragging &&
            i ==
                (_offsetY / (lyricTextPaints[0].height + ScreenUtil().setWidth(30)))
                    .abs()
                    .round() - 1) {
          // 如果是拖动状态中的当前行
          lyricTextPaints[i].text =
              TextSpan(text: lyrics[i].lyric, style: TextStyle(fontSize: 16, color: Colors.grey));
          lyricTextPaints[i].layout();
        } else {
          lyricTextPaints[i].text =
              TextSpan(text: lyrics[i].lyric, style: TextStyle(fontSize: 16, color: Colors.grey));
          lyricTextPaints[i].layout();
        }

        lyricTextPaints[i].paint(
          canvas,
          Offset((size.width - lyricTextPaints[i].width) / 2, y),
        );
      }
      // 计算偏移量
      y += lyricTextPaints[i].height + ScreenUtil().setWidth(30);
      lyrics[i].offset = y;
    }
  }
}
