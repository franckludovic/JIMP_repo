import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class JIntershipCard extends StatelessWidget {

  const JIntershipCard({
    super.key,
    required this.companyLogo,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.duration,
    required this.skills,
    this.backgroundColor,
    this.onTap,
  });

  final String companyLogo;
  final String companyName;
  final String jobTitle;
  final String location;
  final String duration;
  final Color? backgroundColor;
  final List<String> skills;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: backgroundColor ?? (JHelperFunctions.isDarkMode(context) ? JColors.grey : JColors.secondary.withAlpha((0.1 * 255).toInt())),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.2 * 255).toInt()),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),



        child: Row(
          children: [
            // Company Logo
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                companyLogo,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.business, color: Colors.grey),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),


            // Job Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    companyName,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    jobTitle,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    duration,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Skills:  ${skills.join(", ")}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: JColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}






