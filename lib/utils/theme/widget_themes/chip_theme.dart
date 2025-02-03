import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    checkmarkColor: TColors.white,
    selectedColor: TColors.primary,
    disabledColor: TColors.grey.withAlpha((0.4 * 255).toInt()),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: const TextStyle(color: TColors.black, fontFamily: 'Urbanist'),
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    checkmarkColor: TColors.white,
    selectedColor: TColors.primary,
    disabledColor: TColors.darkerGrey,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    labelStyle: TextStyle(color: TColors.white, fontFamily: 'Urbanist'),
  );
}
