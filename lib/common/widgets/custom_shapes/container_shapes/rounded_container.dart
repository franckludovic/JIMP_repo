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
    this.radius = JSizes.cardRadiusLg,
    this.backgroundColor = JColors.white,

  });

  final Widget? child;
  final double radius;
  final double? width;
  final double? height;
  final bool showBorder;
  final Color borderColor;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

 // final void Function()? onTap;

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
        border: showBorder ? Border.all(color: borderColor) : null,
        // boxShadow: [
        //   if (showShadow)
        //     BoxShadow(
        //       color: TColors.grey.withOpacity(0.1),
        //       spreadRadius: 5,
        //       blurRadius: 8,
        //       offset: const Offset(0, 3),
        //     ),
        // ],
      ),
      child: child,
    );

  }
}
