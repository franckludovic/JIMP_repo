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
    required this.companyProfileImage,

  });

  final String companyName;
  final String companyLogo;
  final String companyProfileImage;



  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Container(

      child: Stack(

        children: [
          Stack(
            children: [
              SizedBox(
                  width: JDeviceUtils.getScreenWidth(context),
                  child: Image.asset(companyProfileImage)
              ),


              Column(
                children: [

                  CompanyDetailsAppBar(),
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
      ),
    );
  }
}
