import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';


class JBillingAmountSection extends StatelessWidget {
  const JBillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///subTotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sub Total", style: Theme.of(context).textTheme.bodyMedium,),
            Text("\$256", style: Theme.of(context).textTheme.bodyMedium,),

          ],
        ),

        const SizedBox(height: JSizes.spaceBtwItems / 2,),

        ///--Shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Shipping fee", style: Theme.of(context).textTheme.bodyMedium,),
            Text("6.0", style: Theme.of(context).textTheme.labelLarge,),

          ],
        ),

        const SizedBox(height: JSizes.spaceBtwItems / 2,),

        ///--tax fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tax fee", style: Theme.of(context).textTheme.bodyMedium,),
            Text("6.0", style: Theme.of(context).textTheme.labelLarge,),

          ],
        ),

        const SizedBox(height: JSizes.spaceBtwItems / 2,),

        ///--order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Order Total", style: Theme.of(context).textTheme.bodyMedium,),
            Text("6.0", style: Theme.of(context).textTheme.titleMedium,),

          ],
        ),

      ],
    );
  }
}

