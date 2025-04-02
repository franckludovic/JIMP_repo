import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../application_page_form/applyPage.dart';

class JApplySaveButton extends StatelessWidget {

  final bool isReveiw;

  const JApplySaveButton({super.key,  this.isReveiw = false, });

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Container(
      height: 80,
      width: 80,
      padding: const EdgeInsets.symmetric(
          horizontal: JSizes.defaultSpace, vertical: JSizes.defaultSpace / 2.5),
      decoration: BoxDecoration(
        color: dark ? JColors.darkerGrey : JColors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(JSizes.cardRadiusLg),
          topRight: Radius.circular(JSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: JColors.darkGrey,
              borderRadius: BorderRadius.circular(100),
              ),
            child: SizedBox(
              width: JSizes.iconLg * 2,
              height: JSizes.iconLg * 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 8),
                child: Icon(Iconsax.save_21, size: 50, color: JColors.white, ),
              ),
            ),
          ),

          SizedBox(

            width: 250,
            height: 80,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric( vertical:  JSizes.sm, horizontal: JSizes.lg),
                  backgroundColor: JColors.primary,
                  side: const BorderSide(color: JColors.grey),
                ),
                onPressed: () => Get.to(() =>  ApplyPage(requiresVerification: false,)),
                child: isReveiw? Text("POST", style: TextStyle(fontSize: 25, fontFamily: 'Poppins')) :  Text("APPLY", style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),)
            ),
          ),
        ],
      ),
    );
  }
}
