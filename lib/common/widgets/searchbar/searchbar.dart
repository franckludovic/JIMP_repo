import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class JSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? padding;

  const JSearchBar({
    super.key,
    required this.controller,
    this.hintText = 'Search...',
    this.prefixIcon = Iconsax.search_normal,
    this.onChanged,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(JSizes.defaultSpace),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(prefixIcon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onChanged: onChanged,
      ),
    );
  }
}