import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'dart:ui' show lerpDouble;
import 'dart:math';
import 'bar_hight_palette.dart';
import 'color_palette.dart';

class BarChart {
  static const int barCount = 4;
  final List<Bar> bars;

  BarChart(this.bars) {
    assert(bars.length == barCount);
  }

  factory BarChart.empty() {
    return BarChart(

// 创建给定长度的固定长度列表，并用fill在每个位置初始化值
// length必须是非负整数

        List.filled(barCount, Bar(0.0, Colors.transparent)));
  }

  factory BarChart.random(Random random) {
    final Color color = ColorPalette.primary.random(random);

    return BarChart(

// 创建给定长度的固定长度列表，并用generator创建的值在每个位置初始化值
// 创建的列表是固定长度，除非growable为true

        List.generate(
            barCount, (i) => Bar(HightPalette.primary.random(i), color)));
  }

  static BarChart lerp(BarChart begin, BarChart end, double t) {
    return BarChart(List.generate(
        barCount, (i) => Bar.lerp(begin.bars[i], end.bars[i], t)));
  }
}

class BarChartTween extends Tween<BarChart> {
  BarChartTween(BarChart begin, BarChart end) : super(begin: begin, end: end);

  @override
  BarChart lerp(double t) => BarChart.lerp(begin!, end!, t);
}

class Bar {
  Bar(this.height, this.color);

  final double height;
  final Color color;

  static Bar lerp(Bar begin, Bar end, double t) {
    return Bar(lerpDouble(begin.height, end.height, t)!,
        Color.lerp(begin.color, end.color, t)!);
  }
}

class BarTween extends Tween<Bar> {
  BarTween(Bar begin, Bar end) : super(begin: begin, end: end);

  @override
  Bar lerp(double t) => Bar.lerp(begin!, end!, t);
}

class BarChartPainter extends CustomPainter {
  static const barWidthFraction = 0.75;

  BarChartPainter(Animation<BarChart> animation)
      : animation = animation,
        super(repaint: animation);

  final Animation<BarChart> animation;

  @override
  void paint(Canvas canvas, Size size) {
    void drawBar(Bar bar, double x, double width, Paint paint) {
      paint.color = bar.color;
      canvas.drawRect(
          Rect.fromLTWH(x, size.height - bar.height, width, bar.height), paint);
    }

    //Paint：Canvas绘制时使用的样式说明
    //style：是否绘制内部的形状、形状的边缘或两者都有，默认为PaintingStyle.fill
    final paint = Paint()..style = PaintingStyle.fill;
    final chart = animation.value;

    /// 每个条形占用的空间宽度
    final barDistance = size.width / (1 + chart.bars.length);

    /// 每个条形占用空间75%的宽度
    final barWidth = barDistance * barWidthFraction;

    /// 用于计算每个条形的x坐标点
    var x = barDistance - barWidth / 2;
    for (final bar in chart.bars) {
      drawBar(bar, x, barWidth, paint);
      x += barDistance;
    }
  }

  @override
  bool shouldRepaint(BarChartPainter old) => false;
}
