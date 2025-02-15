import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/applications/carts/card_menu.dart';

class ApplicationsApplied extends StatelessWidget {
  const ApplicationsApplied({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        showBackArrow: true,
          title: Text("Applications Status",
              style: Theme.of(context).textTheme.headlineMedium)),
      body: Padding(
        padding: EdgeInsets.all(JSizes.defaultSpace),
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(height: JSizes.spaceBtwSections),
          itemCount: 1,
          itemBuilder: (_, index) => Column(

             children: [
              ///image
              JAppliedCard(status: 'REJECTED'),
              JAppliedCard(status: 'ACCEPTED'),
              JAppliedCard(),

              SizedBox(height: JSizes.spaceBtwItems),

              ],
            )
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(JSizes.defaultSpace),
      //   child: ElevatedButton(onPressed: () {}, child: Text("Checkout \$256.0")),
      // ),
    );
  }
}


