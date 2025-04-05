import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../../Applications/models/company_model.dart';


class BranchCardWidget extends StatefulWidget {
  final int index;
  final CompanyBranch branch;
  final ValueChanged<CompanyBranch> onChanged;
  final VoidCallback onRemove;
  final bool isEditable;
  final bool isInDialog;
  final VoidCallback? onSave;

  const BranchCardWidget({
    super.key,
    required this.index,
    required this.branch,
    required this.onChanged,
    required this.onRemove,
    this.isEditable = false,
    this.isInDialog = false,
    this.onSave,
  });

  @override
  _BranchCardWidgetState createState() => _BranchCardWidgetState();
}

class _BranchCardWidgetState extends State<BranchCardWidget> {
  late TextEditingController _countryController;
  late TextEditingController _regionController;
  late TextEditingController _cityController;
  late TextEditingController _streetController;
  late TextEditingController _postalCodeController;
  late TextEditingController _contactEmailController;
  late TextEditingController _phoneController;
  late TextEditingController _contactNameController;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _countryController = TextEditingController(text: widget.branch.address.country);
    _regionController = TextEditingController(text: widget.branch.address.region);
    _cityController = TextEditingController(text: widget.branch.address.city);
    _streetController = TextEditingController(text: widget.branch.address.street);
    _postalCodeController = TextEditingController(text: widget.branch.address.postalCode);
    _contactEmailController = TextEditingController(text: widget.branch.contactEmail);
    _phoneController = TextEditingController(text: widget.branch.phoneNumber);
    _contactNameController = TextEditingController(text: widget.branch.contactName);
  }

  void _saveChanges() {
    final updatedBranch = CompanyBranch(
      address: CompanyAddress(
        street: _streetController.text.trim(),
        city: _cityController.text.trim(),
        region: _regionController.text.trim(),
        country: _countryController.text.trim(),
        postalCode: _postalCodeController.text.trim(),
      ),
      contactEmail: _contactEmailController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      contactName: _contactNameController.text.trim(),
    );

    widget.onChanged(updatedBranch);
    widget.onSave?.call();
  }

  @override
  void dispose() {
    _countryController.dispose();
    _regionController.dispose();
    _cityController.dispose();
    _streetController.dispose();
    _postalCodeController.dispose();
    _contactEmailController.dispose();
    _phoneController.dispose();
    _contactNameController.dispose();
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
            // Header Section
            _buildHeader(),
            const SizedBox(height: JSizes.spaceBtwItems),

            // Input Fields
            _buildContactNameField(),
            const SizedBox(height: JSizes.spaceBtwInputFields),
            _buildLocationFields(),
            const SizedBox(height: JSizes.spaceBtwInputFields),
            _buildAddressFields(),
            const SizedBox(height: JSizes.spaceBtwInputFields),
            _buildPostalCodeField(),
            const SizedBox(height: JSizes.spaceBtwInputFields),
            _buildContactInfoFields(),

            // Action Buttons
            if (widget.isEditable) _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Branch ${widget.index + 1}", style: Theme.of(context).textTheme.headlineMedium),
        if (!widget.isInDialog && widget.isEditable)
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: widget.onRemove,
          ),
      ],
    );
  }

  Widget _buildContactNameField() {
    return TextFormField(
      controller: _contactNameController,
      decoration: const InputDecoration(
        labelText: "Contact Name",
        prefixIcon: Icon(Iconsax.user),
      ),
      enabled: widget.isEditable,
      validator: (value) => TValidator.validateEmptyText('Contact Name', value),
    );
  }

  Widget _buildLocationFields() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _countryController,
            decoration: const InputDecoration(labelText: "Country"),
            enabled: widget.isEditable,
          ),
        ),
        const SizedBox(width: JSizes.md),
        Expanded(
          child: TextFormField(
            controller: _regionController,
            decoration: const InputDecoration(labelText: "Region/State"),
            enabled: widget.isEditable,
          ),
        ),
      ],
    );
  }

  Widget _buildAddressFields() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _cityController,
            decoration: const InputDecoration(labelText: "City"),
            enabled: widget.isEditable,
          ),
        ),
        const SizedBox(width: JSizes.md),
        Expanded(
          child: TextFormField(
            controller: _streetController,
            decoration: const InputDecoration(labelText: "Street Address"),
            enabled: widget.isEditable,
          ),
        ),
      ],
    );
  }

  Widget _buildPostalCodeField() {
    return TextFormField(
      controller: _postalCodeController,
      decoration: const InputDecoration(labelText: "Postal Code"),
      enabled: widget.isEditable,
    );
  }

  Widget _buildContactInfoFields() {
    return Column(
      children: [
        TextFormField(
          controller: _contactEmailController,
          decoration: const InputDecoration(labelText: "Contact Email"),
          enabled: widget.isEditable,
        ),
        const SizedBox(height: JSizes.spaceBtwInputFields),
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(labelText: "Contact Phone"),
          enabled: widget.isEditable,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: JSizes.spaceBtwItems),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.isInDialog)
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
          const SizedBox(width: JSizes.md),
          ElevatedButton(
            onPressed: () {
              if (widget.isInDialog) {
                _saveChanges();
                Navigator.of(context).pop();
              } else {
                _saveChanges();
              }
            },
            child: Text(widget.isInDialog ? "Save Changes" : "Save"),
          ),
        ],
      ),
    );
  }
}