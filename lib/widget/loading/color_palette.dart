import 'package:flutter/material.dart';
import 'dart:math';

class ColorPalette {
  static final ColorPalette primary =  ColorPalette(<Color>[
    Colors.blue.shade400,
    Colors.red.shade400,
    Colors.green.shade400,
    Colors.yellow.shade400,
    Colors.purple.shade400,
    Colors.orange.shade400,
    Colors.teal.shade400,
  ]);

  ColorPalette(List<Color> colors) : _colors = colors {
    // bool isNotEmpty：如果此集合中至少有一个元素，则返回true
    assert(colors.isNotEmpty);
  }

  final List<Color> _colors;

  Color operator [](int index) => _colors[index % length];

  // 返回集合中的元素数量
  int get length => _colors.length;

  /*
 int nextInt(
  int max
 )
 生成一个非负随机整数，范围从0到max（包括max）
  */
  Color random(Random random) => this[random.nextInt(length)];
}