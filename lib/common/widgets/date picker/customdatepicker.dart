import 'package:flutter/material.dart';

class CustomDatePickerField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const CustomDatePickerField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hint,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
  }) : super(key: key);

  Future<void> _selectDate(BuildContext context) async {
    // Use the controller's text if it can be parsed, otherwise initialDate or now.
    DateTime initDate = initialDate ?? DateTime.now();
    if (controller.text.isNotEmpty) {
      final parsed = DateTime.tryParse(controller.text);
      if (parsed != null) {
        initDate = parsed;
      }
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      // Format the date as yyyy-MM-dd
      controller.text = "${picked.toLocal()}".split(' ')[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
        border: const OutlineInputBorder(),
      ),
      onTap: () => _selectDate(context),
    );
  }
}