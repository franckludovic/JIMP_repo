import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class Benefits extends StatelessWidget {
  const Benefits({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icons,
  });

  final String title;
  final String subTitle;
  final IconData icons;

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return SizedBox(
      width: 200,
      height: 200,

      child: Card(
        color: dark ?  null : Colors.purple.shade50,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(JSizes.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Icon(icons, color: JColors.primary,),

              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

