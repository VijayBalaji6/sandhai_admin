import 'package:flutter/material.dart';

class CustomShimmerBox extends StatelessWidget {
  const CustomShimmerBox({
    super.key,
    this.h = 16,
    this.w = double.infinity,
    this.r = 6,
    this.color = const Color(0xFFE6E6E6),
  });

  final double h;
  final double w;
  final double r;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(r),
      ),
    );
  }
}
