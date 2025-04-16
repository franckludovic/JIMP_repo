import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/sizes.dart';
import '../shimmer/shimerEffect.dart';

class JRoundedImage extends StatelessWidget {
  const JRoundedImage({
    super.key,
    this.width = 55,
    this.height = 55,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.cover,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = JSizes.md,
    this.errorWidget,
  });

  final Widget? errorWidget;
  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: SizedBox(
            width: width,
            height: height,
            child: isNetworkImage
                ? CachedNetworkImage(
              imageUrl: imageUrl,
              fit: fit,
              placeholder: (context, url) => const JShimmerEffect(width: 55, height: 55, radius: 55),
              errorWidget: (context, url, error) => errorWidget ?? const Icon(Icons.error),
            )
                : Image.asset(
              imageUrl,
              fit: fit,
            ),
          ),
        ),
      ),
    );
  }
}
