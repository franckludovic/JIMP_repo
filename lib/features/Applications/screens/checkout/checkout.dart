import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/common/widgets/success_screen/success_screen.dart';
import 'package:project_bc_tuto/features/Applications/screens/applications_applied/widgets/cart_checkout_item.dart';
import 'package:project_bc_tuto/features/Applications/screens/checkout/widget/billing_address_section.dart';
import 'package:project_bc_tuto/features/Applications/screens/checkout/widget/billing_amount_section.dart';
import 'package:project_bc_tuto/features/Applications/screens/checkout/widget/billing_payment_section.dart';
import 'package:project_bc_tuto/navigation_menu.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/applications/carts/coupon_wigets.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
          showBackArrow: true,
          title: Text('Order Review',
              style: Theme.of(context).textTheme.headlineSmall)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              ///item in the cart
              const JCardListviewItem(showAddRemoveButtons: false),
              const SizedBox(height: JSizes.spaceBtwSections),

              /// coupon textfield

              JCouponCode(),
              const SizedBox(height: JSizes.spaceBtwSections),

              ///--billing Section
              JRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(JSizes.md),
                backgroundColor: dark ? JColors.black : JColors.white,
                child: Column(
                  children: [
                    ///printing
                    JBillingAmountSection(),
                    const SizedBox(height: JSizes.spaceBtwItems),

                    ///divider
                    Divider(),
                    const SizedBox(height: JSizes.spaceBtwItems),

                    ///payment methods
                    const JBillingPaymentSection(),
                    const SizedBox(height: JSizes.spaceBtwItems),

                    ///address
                    JBillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      ///Checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(JSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () => Get.to(() => SuccessScreen(
              image: JImages.successfulPaymentIcon2,
              title: "Payment Success",
              subTitle: "Your Item will be shopped soon!",
              onPressed: () => Get.offAll(() => const NavigationMenu()),
            )
            ),
            child: Text("Checkout \$256.0")),
      ),
    );
  }
}
