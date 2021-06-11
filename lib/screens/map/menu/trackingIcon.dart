import 'package:flutter/material.dart';

// see: locate/index.dart for example how to use this
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(size.width, 0);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, 0);
    path_0.close();

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.3570833, size.height * 0.2500000);
    path_1.lineTo(size.width * 0.2500000, size.height * 0.2500000);
    path_1.lineTo(size.width * 0.2500000, size.height * 0.3575000);
    path_1.cubicTo(
        size.width * 0.3091667,
        size.height * 0.3575000,
        size.width * 0.3570833,
        size.height * 0.3091667,
        size.width * 0.3570833,
        size.height * 0.2500000);
    path_1.close();
    path_1.moveTo(size.width * 0.5000000, size.height * 0.2500000);
    path_1.lineTo(size.width * 0.4287500, size.height * 0.2500000);
    path_1.cubicTo(
        size.width * 0.4287500,
        size.height * 0.3483333,
        size.width * 0.3487500,
        size.height * 0.4287500,
        size.width * 0.2500000,
        size.height * 0.4287500);
    path_1.lineTo(size.width * 0.2500000, size.height * 0.5000000);
    path_1.cubicTo(
        size.width * 0.3883333,
        size.height * 0.5000000,
        size.width * 0.5000000,
        size.height * 0.3879167,
        size.width * 0.5000000,
        size.height * 0.2500000);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.6908104, size.height * 0.5971045);
    path_2.cubicTo(
        size.width * 0.6643148,
        size.height * 0.5971045,
        size.width * 0.6419350,
        size.height * 0.6128235,
        size.width * 0.6319027,
        size.height * 0.6351342);
    path_2.lineTo(size.width * 0.5567890, size.height * 0.6351342);
    path_2.cubicTo(
        size.width * 0.5467567,
        size.height * 0.6128235,
        size.width * 0.5243769,
        size.height * 0.5971045,
        size.width * 0.4978813,
        size.height * 0.5971045);
    path_2.cubicTo(
        size.width * 0.4713858,
        size.height * 0.5971045,
        size.width * 0.4490060,
        size.height * 0.6128235,
        size.width * 0.4389737,
        size.height * 0.6351342);
    path_2.lineTo(size.width * 0.3638600, size.height * 0.6351342);
    path_2.cubicTo(
        size.width * 0.3538277,
        size.height * 0.6128235,
        size.width * 0.3314479,
        size.height * 0.5971045,
        size.width * 0.3049523,
        size.height * 0.5971045);
    path_2.cubicTo(
        size.width * 0.2694534,
        size.height * 0.5971045,
        size.width * 0.2406427,
        size.height * 0.6255000,
        size.width * 0.2406427,
        size.height * 0.6604873);
    path_2.cubicTo(
        size.width * 0.2406427,
        size.height * 0.6954746,
        size.width * 0.2694534,
        size.height * 0.7238700,
        size.width * 0.3049523,
        size.height * 0.7238700);
    path_2.cubicTo(
        size.width * 0.3314479,
        size.height * 0.7238700,
        size.width * 0.3538277,
        size.height * 0.7081511,
        size.width * 0.3638600,
        size.height * 0.6858404);
    path_2.lineTo(size.width * 0.4389737, size.height * 0.6858404);
    path_2.cubicTo(
        size.width * 0.4490060,
        size.height * 0.7081511,
        size.width * 0.4713857,
        size.height * 0.7238700,
        size.width * 0.4978813,
        size.height * 0.7238700);
    path_2.cubicTo(
        size.width * 0.5243769,
        size.height * 0.7238700,
        size.width * 0.5467567,
        size.height * 0.7081511,
        size.width * 0.5567890,
        size.height * 0.6858404);
    path_2.lineTo(size.width * 0.6319027, size.height * 0.6858404);
    path_2.cubicTo(
        size.width * 0.6419350,
        size.height * 0.7081511,
        size.width * 0.6643148,
        size.height * 0.7238700,
        size.width * 0.6908104,
        size.height * 0.7238700);
    path_2.cubicTo(
        size.width * 0.7263093,
        size.height * 0.7238700,
        size.width * 0.7551200,
        size.height * 0.6954746,
        size.width * 0.7551200,
        size.height * 0.6604873);
    path_2.cubicTo(
        size.width * 0.7551200,
        size.height * 0.6255000,
        size.width * 0.7263093,
        size.height * 0.5971045,
        size.width * 0.6908104,
        size.height * 0.5971045);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_2, paint_2_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
