import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'compagny_cards.dart';
import '../custom_shapes/container_shapes/rounded_container.dart';

class JCompagnyShowCase extends StatelessWidget {
  const JCompagnyShowCase({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return JRoundedContainer(
      showBorder: true,
      borderColor: JColors.darkerGrey,
      padding: const EdgeInsets.all(JSizes.md),
      backgroundColor: Colors.transparent,
      margin: const EdgeInsets.only(bottom: JSizes.spaceBtwItems),
      child: Column(
        children: [
          ///compagny with application count
          const JCompagnyCard(showBorder: false),
          const SizedBox(height: JSizes.spaceBtwItems),
          ///top 3 application
          Row(
            children: images
                .map(
                    (image) => CompanyTopApplicationImageWidget(image, context))
                .toList(),
          )
        ],
      ),
    );
  }
}

Widget CompanyTopApplicationImageWidget(String image,  context) {
  return Expanded(
      child: JRoundedContainer(
        height: 100,
        backgroundColor:
        JHelperFunctions.isDarkMode(context) ? JColors.darkGrey : JColors.light,
        margin: const EdgeInsets.only(right: JSizes.sm),
        padding: const EdgeInsets.all(JSizes.md),
        child:  Image(
            fit: BoxFit.contain, image: AssetImage(image)),
      ));
}
