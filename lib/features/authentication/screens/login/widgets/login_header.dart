import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';

class JLoginHeader extends StatelessWidget {
  const JLoginHeader({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.only(bottom: 0, top: 0),
            child: Image(
              height: 300,
              image: AssetImage(dark ? JImages.darkAppLogo2 : JImages.lightAppLogo2),
            ),
          ),
        ),
        Text(JTexts.loginTitleCandidate, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: JSizes.sm),
        Text(JTexts.loginSubTitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}