import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../../Applications/models/company_model.dart';

import '../../../controllers.onboarding/company_signup_controller/company_sign_up_controller.dart';

class BranchReviewWidget extends StatelessWidget {
  final int index;
  final CompanyBranch branch;

  const BranchReviewWidget({
    super.key,
    required this.index,
    required this.branch,
  });

  void _showEditDialog(BuildContext context) {
    final controller = Get.find<CompanySignupController>();
    final address = branch.address;

    // Controllers initialized with current values
    final countryController = TextEditingController(text: address.country);
    final regionController = TextEditingController(text: address.region);
    final cityController = TextEditingController(text: address.city);
    final streetController = TextEditingController(text: address.street);
    final postalController = TextEditingController(text: address.postalCode);
    final emailController = TextEditingController(text: branch.contactEmail);
    final phoneController = TextEditingController(text: branch.phoneNumber);
    final nameController = TextEditingController(text: branch.contactName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Text("Edit Branch"),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Contact Name"),
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: countryController,
                      decoration: const InputDecoration(labelText: "Country"),
                    ),
                  ),
                  const SizedBox(width: JSizes.md),
                  Expanded(
                    child: TextFormField(
                      controller: regionController,
                      decoration: const InputDecoration(labelText: "Region"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cityController,
                      decoration: const InputDecoration(labelText: "City"),
                    ),
                  ),
                  const SizedBox(width: JSizes.md),
                  Expanded(
                    child: TextFormField(
                      controller: streetController,
                      decoration: const InputDecoration(labelText: "Street"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              TextFormField(
                controller: postalController,
                decoration: const InputDecoration(labelText: "Postal Code"),
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Contact Email"),
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              controller.removeBranch(index);
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              final updatedBranch = CompanyBranch(
                address: CompanyAddress(
                  country: countryController.text,
                  region: regionController.text,
                  city: cityController.text,
                  street: streetController.text,
                  postalCode: postalController.text,
                ),
                contactEmail: emailController.text,
                phoneNumber: phoneController.text,
                contactName: nameController.text,
              );
              controller.updateBranch(index, updatedBranch);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      child: ListTile(
        contentPadding: const EdgeInsets.all(JSizes.md),
        title: Text("Branch ${index + 1}"),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${branch.address.street}, ${branch.address.city}"),
            Text("${branch.address.region}, ${branch.address.country}"),
            Text("Postal: ${branch.address.postalCode}"),
            Text("Email: ${branch.contactEmail}"),
            Text("Phone: ${branch.phoneNumber}"),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Iconsax.edit, size: 20),
          onPressed: () => _showEditDialog(context),
        ),
      ),
    );
  }
}