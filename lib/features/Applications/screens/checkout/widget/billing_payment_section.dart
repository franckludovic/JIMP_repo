import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';


class JBillingPaymentSection extends StatelessWidget {
  const JBillingPaymentSection ({super.key});

  @override
  Widget build(BuildContext context) {

    final dark = JHelperFunctions.isDarkMode(context);

    return  Column(
      children: [
        JSectionHeading(title: "Payment Methods", buttonTitle: 'Change', onPressed: () {},),
        const SizedBox(height: JSizes.spaceBtwItems / 2,),

        Row(
          children: [
            JRoundedContainer(
              width: 60,
              height: 35,
              backgroundColor: dark ? JColors.light : JColors.white,
              padding: const EdgeInsets.all(JSizes.sm),
              child: const Image(image: AssetImage(JImages.paypal2), fit: BoxFit.contain),
            ),
            const SizedBox(width: JSizes.spaceBtwItems / 2,),
            Text('Paypal', style: Theme.of(context).textTheme.bodyLarge,)
          ],
        )
      ],
    );
  }
}

