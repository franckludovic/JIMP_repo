import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';


class SignUpNavigationButtons extends StatelessWidget {
  const SignUpNavigationButtons({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => Get.back(),
          style: ElevatedButton.styleFrom(
            backgroundColor: JColors.primary,
            padding: EdgeInsets.symmetric(horizontal: JSizes.lg, vertical: JSizes.sm * 1.3),
          ),
          child: const Row(
            children: [
              Icon(Iconsax.arrow_left_3, color: Colors.white, size: 30),
              SizedBox(width: 5),
              Text("Last Step", style: TextStyle(color: Colors.white, fontSize: 19, fontFamily: 'Poppins')),
            ],
          ),
        ),

        SizedBox(width: JSizes.md),

        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: JColors.primary,
            padding: EdgeInsets.symmetric(horizontal: JSizes.lg, vertical: JSizes.sm * 1.3),
          ),
          child: const Row(
            children: [
              Text("Next Step", style: TextStyle(color: Colors.white, fontSize: 19, fontFamily: 'Poppins')),
              SizedBox(width: 5),
              Icon(Iconsax.arrow_right_2, color: Colors.white, size: 30),
            ],
          ),
        ),
      ],
    );
  }
}
