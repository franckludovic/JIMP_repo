import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/Percentage%20indicator/circular_pencentage_indicator.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';


class JSkillsCard extends StatelessWidget {
  const JSkillsCard({super.key,
    required this.skills});

  final List<JCircularSkillIndicator> skills;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: skills.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Row(
            children: [
              skills[index],
              const SizedBox(width: JSizes.xs)
          ],
          );}
      ),
    );
  }
}
