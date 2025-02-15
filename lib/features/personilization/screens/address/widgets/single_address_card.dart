import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';

class JSingleAddressCard extends StatelessWidget {
  const JSingleAddressCard({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return JRoundedContainer(
      padding: EdgeInsets.all(JSizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAddress
          ? JColors.primary.withAlpha((0.5 * 255).toInt())
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
              ? JColors.darkerGrey
              : JColors.grey,
      margin: const EdgeInsets.only(bottom: JSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress ? Iconsax.tick_circle5 : null,
              color: selectedAddress
                  ? dark
                    ? JColors.light
                    : JColors.dark.withAlpha((0.8 * 255).toInt())
                  : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "John frietz",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: JSizes.sm/2,),
              const Text('(+ 237) 654 89 6 67', maxLines: 1, overflow: TextOverflow.ellipsis,),
              const SizedBox(height: JSizes.sm/2,),
              const Text("8236 Haven's fall, South Skyland, 87985 Polarys", softWrap: true),

            ],
          )

        ],
      ),
    );
  }
}
