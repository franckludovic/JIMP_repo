import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/texts/compagny_title_with_verified_icon.dart';

import '../../../../../common/widgets/Images/rounded_image.dart';
import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../common/widgets/texts/applications_title_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';


class JApplicationHeader extends StatelessWidget {
  const JApplicationHeader({
    super.key,
    required this.companyName,
    required this.internshipName,
    required this.companyLogo,
  });

  final String companyName;
  final String internshipName;
  final String companyLogo;

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Container(
      padding: EdgeInsets.all(JSizes.defaultSpace / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
        children: [
          /// Company Name & Internship Post
          Expanded( // Limits the text space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                JCompagnyTittleVerifications(title: companyName, textColor: JColors.darkGrey,),
                SizedBox(height: 4),
                JApplicationTitleText(
                  title: internshipName,
                  textSize: 30,
                  maxLines: 2,

                ),
              ],
            ),
          ),

          /// Company Logo
          JRoundedContainer(
            height: 113,
            width: 113,
            padding: const EdgeInsets.all(JSizes.sm),
            margin: const EdgeInsets.only(bottom: 5, top: 10),
            backgroundColor: dark ? JColors.dark : JColors.grey,
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
    );
  }
}
