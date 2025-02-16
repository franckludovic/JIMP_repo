import 'package:flutter/material.dart';

import '../../../../../common/widgets/applications/carts/add_remove_button.dart';
import '../../../../../common/widgets/applications/carts/card_menu.dart';
import '../../../../../common/widgets/texts/application_price_text.dart';
import '../../../../../utils/constants/sizes.dart';

class JCardListviewItem extends StatelessWidget {
  const JCardListviewItem({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(height: JSizes.spaceBtwSections),
        itemCount: 2,
        itemBuilder: (_, index) => Column(

          children: [
            ///card image
            JCardItem(),
            if(showAddRemoveButtons) const SizedBox(height: JSizes.spaceBtwItems),

            ///add remove item
            if(showAddRemoveButtons)
              const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(width: 70),
                    ///add remove icon
                    JApplied_drop_buttons(),
                  ],
                ),
                JApplicationPrice(price: '256',)
              ],
            )

          ],
        )
    );
  }
}


