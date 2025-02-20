import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../../../utils/constants/sizes.dart';


class ChatInputField extends StatelessWidget {
  const ChatInputField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: JSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 32,
            color: JColors.secondary.withAlpha((0.09 * 255).toInt()),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: JSizes.sm,
                ),
                decoration: BoxDecoration(
                  color: JColors.primary.withAlpha((0.05 * 255).toInt()),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: JSizes.defaultSpace / 4),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                          suffixIcon: JRoundedContainer(
                            backgroundColor: dark ? JColors.white : JColors.grey ,
                            radius: 10,
                            margin: EdgeInsets.only(right: JSizes.sm * 0.6, top: JSizes.xs, bottom: JSizes.xs ),
                            child: IconButton(onPressed: () {}, icon: Icon(Iconsax.send1, size: 28, color: JColors.primary,)),
                          )
                        ),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withAlpha((0.64 * 255).toInt()),
                    ),
                    const SizedBox(width: JSizes.defaultSpace / 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
