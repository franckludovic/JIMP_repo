import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

class ShadowStyle {

  static final verticalApplicationShadow = BoxShadow(
    color: JColors.darkerGrey.withAlpha((0.1 * 255).toInt()),
    blurRadius: 50,
    spreadRadius: 7,
    offset: const Offset(0, 2)
  );


  static final horizontalApplicationShadow = BoxShadow(
      color: JColors.darkerGrey.withAlpha((0.1 * 255).toInt()),
      blurRadius: 50,
      spreadRadius: 7,
      offset: const Offset(0, 2)
  );

}