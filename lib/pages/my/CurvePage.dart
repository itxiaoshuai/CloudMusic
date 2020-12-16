import 'package:flutter/material.dart';

class CustomClipperDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, //去掉debug图标
      theme: ThemeData(
          primarySwatch: Colors.red
      ),
      home: CustomPaint(
        painter: CurvePainter(),
        child: Container(),
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

    var startPoint = Offset(0, size.height / 2);
    var controlPoint1 = Offset(size.width / 4, size.height / 3);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 3);
    var endPoint = Offset(size.width, size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
class CurvePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('贝塞尔曲线切割')),
      body: Column(
        children: <Widget>[
          ClipPath( //路径裁切组件
            clipper: BottomClipper(), //路径
            child: Container(
              color: Colors.deepOrangeAccent,
              height: 200.0,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size){
    // var path = Path();
    // path.moveTo(0, 50);
    // path.lineTo(0, 50); //第1个点
    // path.lineTo(0, size.height); //第2个点
    //
    //
    // path.lineTo(size.width, size.height); //第3个点
    // path.lineTo(size.width, 50); //第4个点
    // var firstControlPoint = Offset(size.width/2, 0);
    // var firstEdnPoint = Offset(0, 50);
    // path.quadraticBezierTo(
    //     firstControlPoint.dx,
    //     firstControlPoint.dy,
    //     firstEdnPoint.dx,
    //     firstEdnPoint.dy
    // );
    // var path = Path();
    // path.lineTo(0, 0); //第1个点
    // path.lineTo(0, size.height-50.0); //第2个点
    // var firstControlPoint = Offset(size.width/2, size.height);
    // var firstEdnPoint = Offset(size.width, size.height-50.0);
    // path.quadraticBezierTo(
    //     firstControlPoint.dx,
    //     firstControlPoint.dy,
    //     firstEdnPoint.dx,
    //     firstEdnPoint.dy
    // );
    // path.lineTo(size.width, size.height-50.0); //第3个点
    // path.lineTo(size.width, 0); //第4个点
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
    // canvas.drawPath(path, paint);
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}