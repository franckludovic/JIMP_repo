import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/Applications/screens/Applicaton_details/application_details.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../../styles/shadow.dart';
import '../../Images/rounded_image.dart';
import '../../custom_shapes/container_shapes/rounded_container.dart';
import '../../texts/applications_title_text.dart';
import '../../texts/compagny_title_with_verified_icon.dart';
import '../../../../utils/constants/sizes.dart';


class VerticalJInternshipCard extends StatelessWidget {
  const VerticalJInternshipCard({
    super.key,
    required this.companyLogo,
    required this.internshipTitle,
    required this.companyName,
    this.saved = false,
  });

  final String companyLogo;
  final String internshipTitle;
  final String companyName;
  final bool saved;

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    // Wrap the card in a SizedBox with a fixed height:
    return GestureDetector(
      onTap: () => Get.to(() => const MyApplicationDetails()),
      child: SizedBox(
        height: 270,
        width: 165,
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            boxShadow: [ShadowStyle.verticalApplicationShadow],
            borderRadius: BorderRadius.circular(JSizes.applicationImageRadius),
            color: dark ? JColors.darkGrey : JColors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Internship Image Section
              JRoundedContainer(
                height: 120,
                width: 120,
                padding: const EdgeInsets.all(JSizes.sm),
                margin: const EdgeInsets.only(bottom: 5, top: 20),
                backgroundColor: dark ? JColors.dark : JColors.grey,
                child: Center(
                  child: SizedBox(
                    width: 95,
                    height: 95,
                    child: JRoundedImage(
                      imageUrl: companyLogo,
                      applyImageRadius: true,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: JSizes.spaceBtwItems / 2),
              // Internship Details Section
              Padding(
                padding: const EdgeInsets.only(left: JSizes.sm, right: JSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    JApplicationTitleText(
                      title: internshipTitle,
                    ),
                    const SizedBox(height: JSizes.spaceBtwItems / 2),

                  ],
                ),
              ),


              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    alignment: Alignment.bottomLeft,
                    child: JCompagnyTittleVerifications(
                      title: companyName,
                      textColor: JColors.grey,
                    ),
                  ),
                  // Save Button Section (aligned at the bottom)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: JColors.dark,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(JSizes.cardRadiusMd),
                          bottomRight: Radius.circular(JSizes.applicationImageRadius),
                        ),
                      ),
                      child: SizedBox(
                        width: JSizes.iconLg * 1.2,
                        height: JSizes.iconLg * 1.2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 7.0, bottom: 5),
                          child: Icon(Iconsax.save_21, color: saved ? Colors.yellow : JColors.white, size: 32),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
