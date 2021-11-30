import 'package:flutter/material.dart';
import 'dart:math' as math show sin, pi;

class SpinKitWave extends StatefulWidget {
  @override
  _SpinKitWaveState createState() => _SpinKitWaveState();
}

class _SpinKitWaveState extends State<SpinKitWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _scaleCtrl;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200))
      ..repeat()
      ..addListener(() {
      });
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _bar(0, -1.2);
  }

  Widget _bar(int index, double delay) {
    final _size = 20 * 0.2;
    return ScaleYWidget(
      scaleY: DelayTween(
        begin: .4,
        end: 1.0,
        delay: delay,
      ).animate(_scaleCtrl),
      child: SizedBox.fromSize(
        size: Size(_size, 20),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class ScaleYWidget extends AnimatedWidget {
  const ScaleYWidget({
    required Animation<double> scaleY,
    required this.child,
    this.alignment = Alignment.center,
  }) : super( listenable: scaleY);

  final Widget child;
  final Alignment alignment;

   get scaleY => listenable;

  @override
  Widget build(BuildContext context) {
    final double scaleValue = scaleY!.value;
    final Matrix4 transform = Matrix4.identity()..scale(1.0, scaleValue, 1.0);
    return Transform(
      transform: transform,
      alignment: alignment,
      child: child,
    );
  }
}

class DelayTween extends Tween<double> {
  DelayTween({
    required double begin,
    required double end,
    required this.delay,
  }) : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) {
    return super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);
  }

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}

class AngleDelayTween extends Tween<double> {
  AngleDelayTween({
    required double begin,
    required double end,
    required this.delay,
  }) : super(begin: begin, end: end);

  final double delay;

  @override
  double lerp(double t) => super.lerp(math.sin((t - delay) * math.pi * 0.5));

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
