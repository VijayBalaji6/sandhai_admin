import 'package:QuIDPe/src/common/widgets/dotted_lines/dotter_line_painter.dart';
import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double dashWidth;
  final double dashSpacing;
  final double lineThickness;
  final Color? color;
  final Axis axis;

  const DottedLine({
    this.dashWidth = 6,
    this.dashSpacing = 4,
    this.lineThickness = 2,
    this.color,
    this.axis = Axis.horizontal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: axis == Axis.horizontal
          ? Size(double.infinity, lineThickness)
          : Size(lineThickness, double.infinity),
      painter: DottedLinePainter(
        dashWidth: dashWidth,
        dashSpacing: dashSpacing,
        lineThickness: lineThickness,
        color: color ?? AppColor.dottedLineColor,
        axis: axis,
      ),
    );
  }
}
