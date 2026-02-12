import 'package:QuIDPe/src/config/design_system/color/app_color.dart';
import 'package:flutter/material.dart';
import 'package:QuIDPe/src/common/widgets/ticket_shape_border/ticket_position_enum.dart';

class TicketShapeBorder extends ShapeBorder {
  final double borderRadius;
  final double clipRadius;
  final double punchRadius;
  final double? topRightRadius;
  final double? topLeftRadius;
  final double? bottomRightRadius;
  final double? bottomLeftRadius;
  final List<double> dashPattern;
  final Color dashedLineColor;
  final TicketClipPosition clipPosition;
  final bool drawDashedLine;

  const TicketShapeBorder({
    this.topRightRadius,
    this.topLeftRadius,
    this.bottomRightRadius,
    this.bottomLeftRadius,
    this.borderRadius = 5,
    this.clipRadius = 5,
    this.punchRadius = 5,
    this.dashPattern = const [5, 3],
    this.drawDashedLine = true,
    this.dashedLineColor = AppColor.dottedLineColor,
    this.clipPosition = TicketClipPosition.both,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final double r = borderRadius;
    final double p = punchRadius;
    final double cR = clipRadius;

    // Base rounded rectangle path with custom corner radii
    Path base = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          rect,
          topLeft: Radius.circular(topLeftRadius ?? r),
          topRight: Radius.circular(topRightRadius ?? r),
          bottomLeft: Radius.circular(bottomLeftRadius ?? r),
          bottomRight: Radius.circular(bottomRightRadius ?? r),
        ),
      );

    // Path for punch holes
    Path holes = Path();

    if (clipPosition == TicketClipPosition.left ||
        clipPosition == TicketClipPosition.both) {
      holes.addOval(
        Rect.fromCircle(
          center: Offset(rect.left + cR, rect.center.dy),
          radius: p,
        ),
      );
    }

    if (clipPosition == TicketClipPosition.right ||
        clipPosition == TicketClipPosition.both) {
      holes.addOval(
        Rect.fromCircle(
          center: Offset(rect.right - cR, rect.center.dy),
          radius: p,
        ),
      );
    }

    // Subtract the holes from the base shape
    return Path.combine(PathOperation.difference, base, holes);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final double y = rect.center.dy;

    // Adjust line start and end between holes
    double startX =
        rect.left +
        ((clipPosition == TicketClipPosition.left ||
                clipPosition == TicketClipPosition.both)
            ? punchRadius * 2
            : 0);

    double endX =
        rect.right -
        ((clipPosition == TicketClipPosition.right ||
                clipPosition == TicketClipPosition.both)
            ? punchRadius * 2
            : 0);

    double x = startX;
    while (x < endX) {
      path.moveTo(x, y);
      x += dashPattern[0];
      if (x < endX) path.lineTo(x, y);
      x += dashPattern[1];
    }
  }

  @override
  ShapeBorder scale(double t) => this;
}
