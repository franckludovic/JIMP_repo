import 'package:flutter/material.dart';
import 'custom_dropdown.dart';

class CustomDropdownDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String label,
    required String initialValue,
    required List<String> options,
    required Function(String selectedValue) onSave,
  }) {
    String selected = initialValue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return CustomDropDown(
                label: label,
                value: selected,
                items: options,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selected = value;
                    });
                  }
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(selected); // Return value to caller
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
