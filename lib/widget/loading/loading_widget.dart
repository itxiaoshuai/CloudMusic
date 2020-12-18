import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' show lerpDouble;

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  // Random([int seed ])：创建一个随机数生成器
  final random =  Random();
  int dataSet = 50;
  AnimationController animation;
  double startHeight;
  double currentHeight;
  double endHeight;

  /*
 @protected
 @mustCallSuper
 void initState()
 将此对象插入树中时调用
 该框架将为其创建的每个State对象精确地调用此方法一次
 */
  @override
  void initState() {
    super.initState();

    animation =  AnimationController(
        // 这个动画应该持续的时间长短
        duration: const Duration(milliseconds: 300),
        vsync: this)
      ..repeat()
      ..addListener(() {
        print('xxxxxxxxxxxxxxxxx');
//        setState(() {
//          currentHeight = lerpDouble(startHeight, endHeight, animation.value);
//        });
      });

    startHeight = 0.0;
    currentHeight = 0.0;
    endHeight = dataSet.toDouble();
    // 开始向前运行这个动画（朝向最后）
    animation.forward();
  }

  void changeData() {
    setState(() {
      startHeight = currentHeight;
      dataSet = random.nextInt(100);
      endHeight = dataSet.toDouble();
      animation.forward(from: 0.0);
    });
  }

  /*
 @override
 void dispose()
 当该对象永久从树中删除时调用
 当该State对象永远不会再次构建时，该框架调用此方法
 框架调用dispose后，该State对象被视为已卸载，并且mounted属性为false，此时调用setState是一个错误
 生命周期的这个阶段是终点：没有办法重新安装dispose的State对象
 */
  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(

        child: Row(
          children: <Widget>[
            Text('xxxxx'),
            Text('xxxzzz'),
            Text('xxeeeeeexxx'),
            CustomPaint(
                size: Size(5.0, 100.0),
                painter:  BarChartPainter(currentHeight)),

//            CustomPaint(
//                size: Size(5.0, 100.0),
//                painter:  BarChartPainter(currentHeight)),
          ],
        ));
  }
}

// CustomPaint：是将绘画委托给CustomPainter策略的控件
class BarChartPainter extends CustomPainter {
  static const barWidth = 10.0;

  BarChartPainter(this.barHeight);

  final double barHeight;

  /*
 void paint(
 Canvas canvas,
 Size size
 )
 当对象需要绘制时调用，它给出Canvas的坐标空间，使得原点位于框的左上角，
 框的面积是size参数的大小
 */
  @override
  void paint(Canvas canvas, Size size) {
    final paint =  Paint()
      ..color = Colors.blue[400]
      ..style = PaintingStyle.fill;
    // drawRect：使用给定的Paint绘制一个矩形，是否填充或描边（或两者）是由Paint.style控制
    canvas.drawRect(
        // Rect.fromLTWH(double left, double top, double width, double height)：
        // 从左上角和上边缘构造一个矩形，并设置其宽度和高度
         Rect.fromLTWH(size.width - barWidth / 2.0, size.height - barHeight,
            barWidth, barHeight),
        paint);
  }

  /*
 bool shouldRepaint(
 CustomPainter,
 oldDelegate
 )
 当定制绘画委托类的新实例被提供给RenderCustomPaint对象时，
 或任何时候使用自定义绘画委托类的新实例创建新的CustomPaint对象
 （这相当于同一件事，因为后者是以前者实施）
 */
  @override
  bool shouldRepaint(BarChartPainter old) => barHeight != old.barHeight;
}
