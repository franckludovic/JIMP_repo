import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../container_shapes/Cirular_shape.dart';

class JDivider extends StatelessWidget {
  const JDivider({
    super.key,
    this.padding = JSizes.defaultSpace,
    this.height = 4,
    this.color = JColors.grey ,
  });

  final double padding;
  final double height;
  final Color color;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: JCircularContainer(
        height: height,
        backgroundColor: color ,
        width: JDeviceUtils.getScreenWidth(context),
      ),
    );
  }
}
