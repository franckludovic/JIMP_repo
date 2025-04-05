import 'package:flutter/material.dart';

import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/Images/rounded_image.dart';
import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import 'company_details_appbar.dart';

class CompagnyDetailsHeader extends StatelessWidget {
  const CompagnyDetailsHeader({
    super.key,
    required this.companyName,
    required this.companyLogo,
    required this.companyProfileImage, required this.title,
    this.logourl,
    this.profileurl,

  });

  final String companyName;
  final String companyLogo;
  final String companyProfileImage;
  final String title;
  final Image? logourl;
  final Image? profileurl;




  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: JColors.grey
              ),
                width: JDeviceUtils.getScreenWidth(context),
                child: Image.network(companyProfileImage)
            ),

            Column(
              children: [

                CompanyDetailsAppBar(title: title,),
                JRoundedContainer(
                  height: 113,
                  width: 113,
                  margin: EdgeInsets.only(top: 140, right: 200),
                  padding: const EdgeInsets.all(JSizes.sm),
                  backgroundColor: dark ? JColors.darkGrey : JColors.grey,
                  child: Center(
                    child: SizedBox(
                      width: 105,
                      height: 105,
                      child: JRoundedImage(
                        isNetworkImage: true,
                        imageUrl: companyLogo,
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
    );
  }
}
