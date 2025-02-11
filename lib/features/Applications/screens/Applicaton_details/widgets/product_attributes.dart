import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/common/widgets/texts/application_price_text.dart';
import 'package:project_bc_tuto/common/widgets/texts/applications_title_text.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    return Column(
      children: [
        JRoundedContainer(
          padding: EdgeInsets.all(JSizes.md),
          backgroundColor: dark ? JColors.darkerGrey : JColors.grey,
          child: Column(
            children: [
              ///title price stock statues
              Row(
                children: [
                  const JSectionHeading(
                      title: "Variations", showActonButton: false),
                  const SizedBox(width: JSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          JApplicationTitleText(
                            title: 'Price: ',
                            smallSize: true,
                          ),

                          ///Actual Price
                          Text(
                            '\$25',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),

                          const SizedBox(width: JSizes.spaceBtwItems),

                          ///Sale Price
                          JApplicationPrice(price: "20")
                        ],
                      ),

                      ///stock
                      Row(
                        children: [
                          const JApplicationTitleText(
                            title: 'Stock: ',
                            smallSize: true,
                          ),
                          Text(
                            'IN Stock',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),

              ///variation description
              JApplicationTitleText(
                title:
                    "This is the Description of the product and i van go up to 4 lines",
                smallSize: true,
                maxLines: 4,
              )
            ],
          ),
        ),
        const SizedBox(height: JSizes.spaceBtwItems),

        ///--Attribute
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            JSectionHeading(title: 'Colors', showActonButton: false,),
            const SizedBox(height: JSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                JChoiceChip(text: 'Green', selected: true, onSelected: (value) {},),
                JChoiceChip(text: 'Blue', selected: false, onSelected: (value) {},),
                JChoiceChip(text: 'Yellow', selected: true, onSelected: (value) {},),
                JChoiceChip(text: 'Green', selected: true, onSelected: (value) {},),
                JChoiceChip(text: 'Blue', selected: false, onSelected: (value) {},),
                JChoiceChip(text: 'Yellow', selected: true, onSelected: (value) {},),
                JChoiceChip(text: 'Green', selected: true, onSelected: (value) {},),
                JChoiceChip(text: 'Blue', selected: false, onSelected: (value) {},),
                JChoiceChip(text: 'Yellow', selected: true, onSelected: (value) {},),

              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const JSectionHeading(title: 'Size', showActonButton: false,),
            const SizedBox(height: JSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                JChoiceChip(text: 'EU 34', selected: true, onSelected: (value) {},),
                JChoiceChip(text: 'EU 36', selected: false, onSelected: (value) {},),
                JChoiceChip(text: 'EU 38', selected: true, onSelected: (value) {},),

              ],
            )
          ],
        ),
      ],
    );
  }
}

