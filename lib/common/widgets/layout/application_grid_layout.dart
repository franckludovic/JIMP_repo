import 'package:flutter/material.dart';

import '../../../features/Applications/screens/home/widgets/vertical_Application.dart';

class InternshipGrid extends StatelessWidget {
  final List<JInternshipCardVertical> internships;

  const InternshipGrid({super.key, required this.internships});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust based on your UI needs
        crossAxisSpacing: 12.5,
        mainAxisSpacing: 12.5,
        childAspectRatio: 0.64, // Adjust to maintain uniform height
      ),
      itemCount: internships.length,
      itemBuilder: (context, index) {
        return internships[index]; // Display each internship card
      },
    );
  }
}
