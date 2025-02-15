import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/texts/application_price_text.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/applications/carts/add_remove_button.dart';
import '../../../../common/widgets/applications/carts/card_menu.dart';

class ApplicationsApplied extends StatelessWidget {
  const ApplicationsApplied({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        showBackArrow: true,
          title: Text("Applications",
              style: Theme.of(context).textTheme.headlineSmall)),
      body: Padding(
        padding: EdgeInsets.all(JSizes.defaultSpace),
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: JSizes.spaceBtwSections),
          itemCount: 15,
          itemBuilder: (_, index) => Column(

             children: [
              ///image
              JCardItem(),
              SizedBox(height: JSizes.spaceBtwItems),

               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Row(
                     children: [
                       const SizedBox(width: 70),
                       ///add remove icon
                       JApplied_drop_buttons(),
                     ],
                   ),
                   JApplicationPrice(price: '256',)
                 ],
               )

              ],
            )
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(JSizes.defaultSpace),
        child: ElevatedButton(onPressed: () {}, child: Text("Checkout \$256.0")),
      ),
    );
  }
}


