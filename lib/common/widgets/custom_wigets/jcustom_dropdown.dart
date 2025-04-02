import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class JCustomDropDown extends StatelessWidget {
  final List<String> items;
  final String? value;
  final String hint;
  final ValueChanged<String?> onChanged;
  final String? title;

  const JCustomDropDown({
    Key? key,
    required this.items,
    required this.value,
    required this.hint,
    required this.onChanged,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!, style: Theme.of(context).textTheme.bodyLarge,),
        SizedBox(height: JSizes.sm,),
        DropdownButtonFormField<String>(
          value: value,
          items: items
              .map((item) => DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          ))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hint,
          ),
        ),
      ],
    );
  }
}
