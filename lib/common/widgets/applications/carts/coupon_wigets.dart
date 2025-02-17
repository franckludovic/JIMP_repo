import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../custom_shapes/container_shapes/rounded_container.dart';

class JAttashProve extends StatelessWidget {
  const JAttashProve({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return JRoundedContainer(
      showBorder: true,
      backgroundColor: dark ? JColors.dark : JColors.white,
      padding: const EdgeInsets.only(
          top: JSizes.sm,
          bottom: JSizes.sm,
          right: JSizes.sm,
          left: JSizes.md),
      child: Row(
        children: [
          ///Text Fields
          Flexible(
            child: Row(
              children: [
                Icon(Iconsax.document_upload),
                SizedBox(width: JSizes.spaceBtwItems/2),
                Flexible(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Attach a Prove',
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),

          ///buttons
          SizedBox(
              width: 80,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    foregroundColor: dark ? JColors.white.withAlpha((0.5 * 255).toInt()) : JColors.dark.withAlpha((0.5 * 255).toInt()),
                    backgroundColor: Colors.grey.withAlpha((0.5 * 255).toInt()),
                    side: BorderSide(color: Colors.grey.withAlpha((0.1 * 255).toInt()),)
                ),
                child: const Text('Attach'),
              )
          )
        ],
      ),
    );
  }
}
