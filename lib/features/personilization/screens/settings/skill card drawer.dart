import 'dart:math';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/Percentage indicator/circular_pencentage_indicator.dart';
import '../../../../common/widgets/pop_up/pop_up.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../Applications/models/user_model.dart';


/// A simple candidate skills list widget that takes a list of SkillEntry objects,
/// displays each as a SkillCard using JCircularSkillIndicator, and generates a random
/// color for each progress bar.
class CandidateSkillsList extends StatelessWidget {
  final List<SkillEntry> skills; // List of skills

  const CandidateSkillsList({super.key, required this.skills});

  Color _generateRandomColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If there are no skills, display a fallback message.
    if (skills.isEmpty) {
      return const Text("No skills provided");
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: skills.length,
        itemBuilder: (context, index) {
          final skill = skills[index];
          // Calculate progress percentage (assuming max level is 5)
          final double percentage = skill.level / 5.0;
          final String textPercent = "${(percentage * 100).round()}%";
          final Color progressColor = _generateRandomColor();

          return Row(
            children: [
              JCircularSkillIndicator(
                percentage: percentage,
                textPercent: textPercent,
                bottomText: skill.skill,
                progressColor: progressColor,
              ),
              const SizedBox(width: JSizes.xs,)
            ],
          );
        },
      ),
    );
  }
}
