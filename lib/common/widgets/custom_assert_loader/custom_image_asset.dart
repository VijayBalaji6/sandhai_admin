import 'package:flutter/material.dart';

class CustomImageAsset extends StatelessWidget {
  const CustomImageAsset({
    super.key,
    required this.asset,
    this.width,
    this.height,
  });

  final String asset;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: width,
      height: height,
      errorBuilder: (_, _, _) {
        return const SizedBox.shrink();
      },
    );
  }
}
