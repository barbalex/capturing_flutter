import 'package:flutter/material.dart';

// see: locate/index.dart for example how to use this
class SnapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.4951542);
    path_0.cubicTo(
        size.width * 0.9991568,
        size.height * 0.4951542,
        size.width * 1.000000,
        size.height * 0.4951542,
        size.width * 1.000000,
        size.height * 0.4951542);
    path_0.moveTo(size.width * 0.4915682, 0);
    path_0.lineTo(size.width * 0.4915682, size.height * 1.000000);
    path_0.moveTo(size.width * 0.8296795, size.height * 0.4955947);
    path_0.arcToPoint(Offset(size.width * 0.4911467, size.height * 0.8493392),
        radius:
            Radius.elliptical(size.width * 0.3385329, size.height * 0.3537445),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.arcToPoint(Offset(size.width * 0.1526138, size.height * 0.4955947),
        radius:
            Radius.elliptical(size.width * 0.3385329, size.height * 0.3537445),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.arcToPoint(Offset(size.width * 0.4911467, size.height * 0.1418502),
        radius:
            Radius.elliptical(size.width * 0.3385329, size.height * 0.3537445),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.arcToPoint(Offset(size.width * 0.8296795, size.height * 0.4955947),
        radius:
            Radius.elliptical(size.width * 0.3385329, size.height * 0.3537445),
        rotation: 0,
        largeArc: false,
        clockwise: true);
    path_0.close();

    Paint paint_0_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.05;
    paint_0_stroke.color = Color(0xff000000).withOpacity(1);
    paint_0_stroke.strokeCap = StrokeCap.butt;
    paint_0_stroke.strokeJoin = StrokeJoin.miter;
    canvas.drawPath(path_0, paint_0_stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
