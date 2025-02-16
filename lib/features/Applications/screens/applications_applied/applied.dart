import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/Applications/screens/applications_applied/widgets/cart_checkout_item.dart';
import 'package:project_bc_tuto/features/Applications/screens/checkout/checkout.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';


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
        ///item in cart
        child: JCardListviewItem(),
      ),

      ///checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(JSizes.defaultSpace),
        child: ElevatedButton(onPressed: () => Get.to(() => const CheckoutScreen()), child: Text("Checkout \$256.0")),
      ),
    );
  }
}

