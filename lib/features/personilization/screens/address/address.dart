import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/personilization/screens/address/add_new_address.dart';
import 'package:project_bc_tuto/features/personilization/screens/address/widgets/single_address_card.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(
          Iconsax.add,
          color: JColors.white,
        ),
      ),
      appBar: JAppbar(
        showBackArrow: true,
        title: Text(
          "Address",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              JSingleAddressCard(selectedAddress: false),
              JSingleAddressCard(selectedAddress: true),

            ],
          ),
        ),
      ),
    );
  }
}
