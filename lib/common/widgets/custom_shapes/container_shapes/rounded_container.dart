import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class JRoundedContainer extends StatelessWidget {
  const JRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.margin,
    this.showBorder = false,
    this.padding,
    this.borderColor = JColors.borderPrimary,
    this.borderWidth = 1.0,
    this.radius = JSizes.cardRadiusLg,
    this.backgroundColor = JColors.white,
  });

  final Widget? child;
  final double radius;
  final double? width;
  final double? height;
  final bool showBorder;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,

      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder
            ? Border.all(
          color: borderColor,
          width: borderWidth,
        )
            : null,
      ),
      child: child,
    );
  }
}