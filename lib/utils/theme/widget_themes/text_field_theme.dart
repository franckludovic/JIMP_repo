import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: JColors.darkGrey,
    suffixIconColor: JColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: JSizes.fontSizeMd, color: JColors.textPrimary, fontFamily: 'Urbanist'),
    hintStyle: const TextStyle().copyWith(fontSize: JSizes.fontSizeSm, color: JColors.textSecondary, fontFamily: 'Urbanist'),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal, fontFamily: 'Urbanist'),
    floatingLabelStyle: const TextStyle().copyWith(color: JColors.textSecondary, fontFamily: 'Urbanist'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JColors.borderPrimary),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JColors.borderPrimary),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JColors.borderSecondary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: JColors.error),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: JColors.darkGrey,
    suffixIconColor: JColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: JSizes.fontSizeMd, color: JColors.white, fontFamily: 'Urbanist'),
    hintStyle: const TextStyle().copyWith(fontSize: JSizes.fontSizeSm, color: JColors.white, fontFamily: 'Urbanist'),
    floatingLabelStyle: const TextStyle().copyWith(color: JColors.white.withAlpha((0.8 * 255).toInt()), fontFamily: 'Urbanist'),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: JColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(JSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: JColors.error),
    ),
  );
}
