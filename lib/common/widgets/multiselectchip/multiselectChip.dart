import 'package:flutter/material.dart';

class MultiSelectChip extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final Function(List<String>) onSelectionChanged;
  final int maxSelection;

  const MultiSelectChip({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.onSelectionChanged,
    this.maxSelection = 5,
  });

  @override
  State<MultiSelectChip> createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  late List<String> selectedChoices;

  @override
  void initState() {
    super.initState();
    selectedChoices = List.from(widget.selectedOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: widget.options.map((item) {
        final isSelected = selectedChoices.contains(item);

        return ChoiceChip(
          label: Text(item),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (isSelected) {
                selectedChoices.remove(item);
              } else {
                if (selectedChoices.length < widget.maxSelection) {
                  selectedChoices.add(item);
                } else {
                  // Optional: show snackbar or warning
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('You can only select up to ${widget.maxSelection} subcategories.'),
                    ),
                  );
                }
              }
              widget.onSelectionChanged(selectedChoices);
            });
          },
        );
      }).toList(),
    );
  }
}
