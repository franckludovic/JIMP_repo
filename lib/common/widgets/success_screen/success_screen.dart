import 'package:flutter/material.dart';

import 'package:project_bc_tuto/common/styles/spacing_styles.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle,  this.onPressed});

  final String image, title, subTitle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: JSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              ///image

              Image(
                  image: AssetImage(image),
                  width: JHelperFunctions.screenWidth() * 0.6),
              const SizedBox(height: JSizes.spaceBtwSections),

              ///Tittle and subtitle
              Text(title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: JSizes.spaceBtwItems),

              Text(subTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: JSizes.spaceBtwSections),

              ///Buttons
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: JColors.primary,
                        side: BorderSide(color: JColors.grey)
                      ),
                      child: const Text(JTexts.jContinue, style: TextStyle(fontFamily: "Poppins", fontSize: 20),))),
              const SizedBox(height: JSizes.spaceBtwItems),
            ],
          ),
        ),
      ),
    );
  }
}
