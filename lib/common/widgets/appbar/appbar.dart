import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../../utils/constants/sizes.dart';

class JAppbar extends StatelessWidget implements PreferredSizeWidget {
  const
  JAppbar({
    super.key,
    this.title,
    this.actions,
    this.leadingIcon,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.color,

    this.backgroundColor,
     this.leadingIconSize = 35,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color? color;
  final double leadingIconSize;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: JSizes.md),
      child: AppBar(
        backgroundColor: backgroundColor,
           automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Iconsax.arrow_left,
                color: dark ? JColors.white : JColors.black))
            : leadingIcon != null
            ? IconButton(
          onPressed: leadingOnPressed,
          icon: Icon(
            leadingIcon,
            size: leadingIconSize,
            color: color ?? (dark
                ? JColors.white
                : JColors.black),
          ),
        )
            : null,title: title,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(JDeviceUtils.getAppBarHeight());
}
