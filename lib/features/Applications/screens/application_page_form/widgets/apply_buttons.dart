import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../../common/widgets/success_screen/success_screen.dart';

class JApplyButtons extends StatelessWidget {
  const JApplyButtons({
    super.key,
    this.isVerificationRequired = false,
    this.isSkillVerified = false
  });

  final bool isVerificationRequired;
  final bool isSkillVerified;

  @override
  Widget build(BuildContext context) {
    final bool isSubmitDisabled = isVerificationRequired && !isSkillVerified;
    final bool verifyDisabled = !isVerificationRequired;

    return SizedBox(
      width: JDeviceUtils.getScreenWidth(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // VERIFY SKILLS BUTTON
          verifyButton(context, verifyDisabled),

          // SUBMIT APPLICATION BUTTON
          submitButton(context, isSubmitDisabled),
        ],
      ),
    );
  }

  Widget verifyButton(BuildContext context, bool disabled) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: JSizes.md,
          horizontal: JSizes.lg * 0.6,
        ),
        backgroundColor: disabled ? JColors.darkerGrey : JColors.primary,
        side: BorderSide(
            color: disabled ? JColors.darkGrey : JColors.primary
        ),
      ),
      onPressed: disabled ? null : _handleVerifySkills,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "VERIFY SKILLS",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              color: disabled ? Colors.grey : Colors.white,
            ),
          ),
          if(disabled) const SizedBox(width: JSizes.sm),
          if(disabled) const Icon(Icons.lock, size: 20),
        ],
      ),
    );
  }

  Widget submitButton(BuildContext context, bool disabled) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(JSizes.md ),
        backgroundColor: disabled ? JColors.darkerGrey : JColors.primary,
        side: BorderSide(
            color: disabled ? JColors.darkGrey : JColors.primary
        ),
      ),
      onPressed: disabled
          ? () => _showVerificationAlert(context)
          : _handleSubmitApplication,
      child: Text(
        "Submit Application",
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          color: disabled ? Colors.grey : Colors.white,
        ),
      ),
    );
  }

  void _handleVerifySkills() {
    // Implement verification logic
    () {};
  }

  void _handleSubmitApplication() {
    // Implement submission logic
        () {};
  }

  void _showVerificationAlert(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Skill verification test required. Please verify skills first."),
        duration: Duration(seconds: 3),
      ),
    );
  }
}