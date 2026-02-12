import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HalfBorderCircle extends StatelessWidget {
  final double size;
  final double strokeWidth;
  final Color topColor;
  final Color bottomColor;
  final Color? centerColor; // <-- new optional parameter

  const HalfBorderCircle({
    super.key,
    this.size = 80,
    this.strokeWidth = 10,
    this.topColor = AppColor.greyColor, // light grey
    this.bottomColor = AppColor.activeGreenColor, // teal/green
    this.centerColor, // can be null (transparent)
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HalfBorderPainter(
        topColor: topColor,
        bottomColor: bottomColor,
        strokeWidth: strokeWidth,
        centerColor: centerColor,
      ),
    );
  }
}

class _HalfBorderPainter extends CustomPainter {
  final Color topColor;
  final Color bottomColor;
  final double strokeWidth;
  final Color? centerColor;

  _HalfBorderPainter({
    required this.topColor,
    required this.bottomColor,
    required this.strokeWidth,
    this.centerColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Fill center if color provided
    if (centerColor != null) {
      final fillPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = centerColor!;
      canvas.drawCircle(center, radius, fillPaint);
    }

    // Draw top half
    paint.color = topColor;
    canvas.drawArc(rect, -math.pi, math.pi, false, paint);

    // Draw bottom half
    paint.color = bottomColor;
    canvas.drawArc(rect, 0, math.pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
