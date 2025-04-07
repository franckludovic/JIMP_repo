
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../../utils/validators/validation.dart';
import '../../../../Applications/models/company_model.dart';

class BranchCardWidget extends StatefulWidget {
  final int index;
  final CompanyBranch branch;
  final ValueChanged<CompanyBranch> onChanged;
  final VoidCallback onRemove;

  const BranchCardWidget({
    super.key,
    required this.index,
    required this.branch,
    required this.onChanged,
    required this.onRemove,
  });

  @override
  _BranchCardWidgetState createState() => _BranchCardWidgetState();
}

class _BranchCardWidgetState extends State<BranchCardWidget> {
  late TextEditingController countryController;
  late TextEditingController regionController;
  late TextEditingController cityController;
  late TextEditingController localAddressController;
  late TextEditingController postalCodeController;
  late TextEditingController contactEmailController;
  late TextEditingController phoneNumberController;
  late TextEditingController contactNameController;

  @override
  void initState() {
    super.initState();
    countryController = TextEditingController(text: widget.branch.address.country);
    regionController = TextEditingController(text: widget.branch.address.region);
    cityController = TextEditingController(text: widget.branch.address.city);
    localAddressController = TextEditingController(text: widget.branch.address.street);
    postalCodeController = TextEditingController(text: widget.branch.address.postalCode);
    contactEmailController = TextEditingController(text: widget.branch.contactEmail);
    phoneNumberController = TextEditingController(text: widget.branch.phoneNumber);
    contactNameController = TextEditingController(text: widget.branch.contactName);
  }

  void _updateBranch() {
    final updatedAddress = CompanyAddress(
      street: localAddressController.text.trim(),
      city: cityController.text.trim(),
      country: countryController.text.trim(),
      region: regionController.text.trim(),
      postalCode: postalCodeController.text.trim(),
    );
    final updatedBranch = CompanyBranch(
      address: updatedAddress,
      contactEmail: contactEmailController.text.trim(),
      phoneNumber: phoneNumberController.text.trim(),
      contactName: contactNameController.text.trim(),
    );
    widget.onChanged(updatedBranch);
  }

  @override
  void dispose() {
    countryController.dispose();
    regionController.dispose();
    cityController.dispose();
    localAddressController.dispose();
    postalCodeController.dispose();
    contactEmailController.dispose();
    contactNameController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      child: Padding(
        padding: const EdgeInsets.all(JSizes.spaceBtwItems),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Branch ${widget.index + 1}", style: Theme.of(context).textTheme.headlineMedium),
                JRoundedContainer(
                  backgroundColor: Colors.red.withAlpha((0.2 * 255).toInt()),
                  child: IconButton(
                    onPressed: widget.onRemove,
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                )
              ],
            ),
            const SizedBox(height: JSizes.spaceBtwItems),
            TextFormField(
              controller: contactNameController,
              decoration: const InputDecoration(labelText: "Contact Name", prefixIcon: Icon(Iconsax.user)),
              validator: (value) => TValidator.validateEmptyText('Contact Name', value),
            ),

            const SizedBox(height: JSizes.spaceBtwInputFields),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: countryController,
                    decoration: const InputDecoration(labelText: "Country"),
                    onChanged: (_) => _updateBranch(),
                  ),
                ),
                const SizedBox(width: JSizes.md),
                Expanded(
                  child: TextFormField(
                    controller: regionController,
                    decoration: const InputDecoration(labelText: "Region/State"),
                    onChanged: (_) => _updateBranch(),
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
                    onChanged: (_) => _updateBranch(),
                  ),
                ),
                const SizedBox(width: JSizes.md),
                Expanded(
                  child: TextFormField(
                    controller: localAddressController,
                    decoration: const InputDecoration(labelText: "Local Address"),
                    onChanged: (_) => _updateBranch(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields),
            TextFormField(
              controller: postalCodeController,
              decoration: const InputDecoration(labelText: "Postal Code"),
              onChanged: (_) => _updateBranch(),
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields),
            TextFormField(
              controller: contactEmailController,
              decoration: const InputDecoration(labelText: "Contact Email"),
              onChanged: (_) => _updateBranch(),
            ),
            const SizedBox(height: JSizes.spaceBtwInputFields),
            TextFormField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: "Contact Phone"),
              onChanged: (_) => _updateBranch(),
            ),
          ],
        ),
      ),
    );
  }
}