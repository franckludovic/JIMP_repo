import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../../common/widgets/texts/section_heading.dart';
//import '../../../../../utils/helpers/helper_functions.dart';

class JBillingAddressSection extends StatelessWidget {
  const JBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {

    //final dark = JHelperFunctions.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JSectionHeading(title: "Shipping Address", buttonTitle: 'Change', onPressed: () {},),
        Text("JIMP SKY", style: Theme.of(context).textTheme.bodyLarge),

        const SizedBox(height: JSizes.spaceBtwItems / 2),


        Row(
          children: [
            const Icon(Iconsax.call, color: Colors.grey, size: 16),
            const SizedBox(width: JSizes.spaceBtwItems),
            Text('+237 654 87 96 54', style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),

        const SizedBox(height: JSizes.spaceBtwItems / 2),


        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: JSizes.spaceBtwItems),
            Expanded(child: Text('South  carolina, Mains Street, USA', style: Theme.of(context).textTheme.bodyMedium, softWrap: true,)),
          ],
        ),



      ],
    );
  }
}
