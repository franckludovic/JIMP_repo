import 'dart:math';
import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../../common/widgets/Percentage indicator/circular_pencentage_indicator.dart';
import '../../../../common/widgets/pop_up/pop_up.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../Applications/models/user_model.dart';

/// A candidate skills list widget that takes a list of SkillEntry objects and a candidate ID.
class CandidateSkillsList extends StatelessWidget {
  final List<SkillEntry> skills; // List of skills
  final String candidateId;      // Candidate document ID in Firestore

  const CandidateSkillsList({
    Key? key,
    required this.skills,
    required this.candidateId,
  }) : super(key: key);

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
    if (skills.isEmpty) {
      return const Text("No skills provided");
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
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
                bottomText: skill.skill, // The skill name
                progressColor: progressColor,
                candidateId: candidateId, // Pass the candidate ID
                skillName: skill.skill,   // Pass the skill name used in Firestore
              ),
              const SizedBox(width: JSizes.xs),
            ],
          );
        },
      ),
    );
  }
}
