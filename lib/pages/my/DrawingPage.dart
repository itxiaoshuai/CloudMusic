import 'package:flutter/material.dart';

class DrawingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Curved Line"),
      ),
      body: CustomPaint(
        painter: CurvePainter(),
        child: Container(
          color: Colors.amber,
        ),
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Colors.lightBlue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    var startPoint = Offset(0, 0);
    var controlPoint1 = Offset(size.width / 4, 10);
    var controlPoint2 = Offset(3 * size.width / 4, 10);
    var endPoint = Offset(size.width, 0);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    // path.lineTo(0, 50); //第1个点
    // path.lineTo(0, size.height); //第2个点

    path.lineTo(size.width, size.height); //第3个点
    path.lineTo(0, size.height); //第4个点
    path.lineTo(0, 0); //第4个点
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
