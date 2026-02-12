import 'package:flutter/material.dart';

class DottedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpacing;
  final double lineThickness;
  final Color color;
  final Axis axis;

  DottedLinePainter({
    required this.dashWidth,
    required this.dashSpacing,
    required this.lineThickness,
    required this.color,
    required this.axis,
  });

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = lineThickness;

    double start = 0;

    if (axis == Axis.horizontal) {
      while (start < size.width) {
        canvas.drawLine(
          Offset(start, 0),
          Offset(start + dashWidth, 0),
          paint,
        );
        start += dashWidth + dashSpacing;
      }
    } else {
      while (start < size.height) {
        canvas.drawLine(
          Offset(0, start),
          Offset(0, start + dashWidth),
          paint,
        );
        start += dashWidth + dashSpacing;
      }
    }
  }
}
