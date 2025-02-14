import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';

import '../../../../common/widgets/Images/rounded_image.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CompanyDetails extends StatelessWidget {
  const CompanyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(

              children: [

                Stack(
                  children: [
                    Container(
                        width: JDeviceUtils.getScreenWidth(context),
                        child: Image.asset(JImages.googleProfileImage)
                    ),
                    JRoundedContainer(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      padding: EdgeInsets.all(0),
                      radius: JSizes.xxl,
                      height: 70,
                      backgroundColor: JColors.white.withAlpha((0.8 * 255).toInt()),
                    ),

                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          child: JAppbar(
                            title: Text("Google",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 30,
                                    color: dark ? JColors.primary : JColors.black)),
                            leadingIcon: Iconsax.arrow_left_3,
                            color: JColors.black,
                            leadingOnPressed: () => Get.to(() => CandidateNavigationMenu()),
                            actions: [
                              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, size: 40, color: JColors.black,))
                            ],
                          ),
                        ),


                        JRoundedContainer(
                          height: 113,
                          width: 113,
                          margin: EdgeInsets.only(top: 140, right: 200),
                          padding: const EdgeInsets.all(JSizes.sm),
                          backgroundColor: /*dark ? JColors.dark : JColors.grey,*/ Colors.greenAccent,                          child: Center(
                            child: SizedBox(
                              width: 105,
                              height: 105,
                                child: JRoundedImage(
                                  imageUrl: JImages.google,
                                  applyImageRadius: true,
                                  fit: BoxFit.contain,
                                ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
