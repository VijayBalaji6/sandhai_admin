import 'package:QuIDPe/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgAsset extends StatelessWidget {
  final String assetName;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  const CustomSvgAsset({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      placeholderBuilder: (context) => SizedBox(
        width: width,
        height: height,
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorBuilder: (context, error, stackTrace) =>
          SvgPicture.asset(Assets.svg.quidLogo, width: width, height: height),
    );
  }
}
