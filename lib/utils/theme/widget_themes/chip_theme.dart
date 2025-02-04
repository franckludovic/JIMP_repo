import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: JColors.white,
    selectedColor: JColors.primary,
    disabledColor: JColors.grey.withAlpha((0.4 * 255).toInt()),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: const TextStyle(color: JColors.black, fontFamily: 'Urbanist'),
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    checkmarkColor: JColors.white,
    selectedColor: JColors.primary,
    disabledColor: JColors.darkerGrey,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: TextStyle(color: JColors.white, fontFamily: 'Urbanist'),
  );
}
