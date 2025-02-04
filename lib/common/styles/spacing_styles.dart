
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/sizes.dart';

class TSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: JSizes.appBarHeight,
    left: JSizes.defaultSpace,
    bottom: JSizes.defaultSpace,
    right: JSizes.defaultSpace,
  );
}