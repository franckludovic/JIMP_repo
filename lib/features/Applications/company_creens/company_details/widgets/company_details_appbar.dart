import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class CompanyDetailsAppBar extends StatelessWidget {
  const CompanyDetailsAppBar({
    super.key, required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only( top: JSizes.xl * 1.2, left: JSizes.sm, right: JSizes.sm),
      padding: EdgeInsets.only(left:  JSizes.xs, right: JSizes.md),
      width: JDeviceUtils.getScreenWidth(context),
      height: 65,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: JColors.white.withAlpha((0.6 * 255).toInt())
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Row(
            children: [
              GestureDetector( onTap: () => Get.back(), child: Icon(Iconsax.arrow_left_3, color: JColors.black, size: 35)),
              SizedBox(width: JSizes.md),
              Text(title, style: Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}

