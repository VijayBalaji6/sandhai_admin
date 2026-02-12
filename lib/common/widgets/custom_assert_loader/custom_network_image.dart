import 'package:cached_network_image/cached_network_image.dart';
import 'package:QuIDPe/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double width;
  final double height;
  final double borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BoxFit fit;
  final Color? imageBgColor;

  const CustomNetworkImage({
    super.key,
    this.imageUrl,
    this.width = 60,
    this.height = 60,
    this.borderRadius = 8,
    this.placeholder,
    this.errorWidget,
    this.imageBgColor,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final Center defaultImage = Center(
      child: SvgPicture.asset(Assets.svg.quidLogo, width: 24, height: 24),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: imageUrl != null
          ? CachedNetworkImage(
              imageUrl: imageUrl!,
              width: width,
              height: height,
              fit: fit,
              color: null,
              placeholder: (_, _) =>
                  placeholder ??
                  Center(
                    child: SizedBox(
                      width: width * 0.35,
                      height: width * 0.35,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
              errorWidget: (_, _, _) => errorWidget ?? defaultImage,
            )
          : defaultImage,
    );
  }
}
