import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/multiselectchip/multiselectChip.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class BenefitsSection extends StatefulWidget {
  final List<String> predefinedBenefits;
  final List<String> initialSelected;
  final Function(List<String>) onBenefitsChanged;

  const BenefitsSection({
    Key? key,
    required this.predefinedBenefits,
    required this.initialSelected,
    required this.onBenefitsChanged,
  }) : super(key: key);

  @override
  State<BenefitsSection> createState() => _BenefitsSectionState();
}

class _BenefitsSectionState extends State<BenefitsSection> {
  late List<String> selectedBenefits;
  final TextEditingController customBenefitsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedBenefits = List<String>.from(widget.initialSelected);
  }

  void _onSelectionChanged(List<String> selected) {
    setState(() {
      selectedBenefits = selected;
    });
    _notifyChanges();
  }

  void _notifyChanges() {
    // Combine predefined selected benefits and custom ones split by commas:
    final customBenefits = customBenefitsController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();
    final allBenefits = [...selectedBenefits, ...customBenefits];
    widget.onBenefitsChanged(allBenefits);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Benefits:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: JSizes.sm),
        // Multi-select chip for predefined benefits
        MultiSelectChip(
          options: widget.predefinedBenefits,
          selectedOptions: selectedBenefits,
          onSelectionChanged: _onSelectionChanged,
        ),
        const SizedBox(height: JSizes.sm),
        // Custom benefits text field for additional entries (comma-separated)
        TextField(
          controller: customBenefitsController,
          decoration: const InputDecoration(
            labelText: "Custom Benefits (separate with commas)",
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          onChanged: (value) {
            _notifyChanges();
          },
        ),
      ],
    );
  }
}
