import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import '../../../features/Applications/screens/Applicaton_details/application_details.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'package:intl/intl.dart';


class HorizontalJIntershipCard extends StatelessWidget {
  const HorizontalJIntershipCard({
    super.key,
    required this.companyLogo,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.duration,
    required this.skills,
    this.backgroundColor,
    this.onTap,
    this.saved = false,
    this.isCompleted = false,
    this.day,
    this.month,
    this.year,
    this.borderRadius = 12,
    this.iconBorderRad = JSizes.md,

  });

  final String companyLogo;
  final String companyName;
  final String jobTitle;
  final String location;
  final String duration;
  final Color? backgroundColor;
  final List<String> skills;
  final bool saved;
  final VoidCallback? onTap;
  final bool isCompleted;
  final int? day;
  final int? month;
  final int? year;
  final double borderRadius;
  final double iconBorderRad;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const MyApplicationDetails()),
      child: Stack(
        children: [
          // Internship Card
          Container(
            height: 200,
            width: null,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: backgroundColor ??
                  (JHelperFunctions.isDarkMode(context)
                      ? JColors.grey
                      : JColors.secondary.withAlpha((0.1 * 255).toInt())),
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha((0.1 * 255).toInt()),
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
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 70,
                        height: 70,
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

          // Dates Positioned at Bottom-Left (Only if Completed and Date is Provided)
          if (isCompleted && day != null && month != null && year != null)
            Positioned(
              bottom: 20,
              left: 20,
              child: Dates(
                year: year!,
                month: month!,
                day: day!,
              ),
            ),

          // Save Button Positioned at Bottom-Right (Only if Not Completed)
          if (!isCompleted)
            Positioned(
              bottom: 2.5,
              right: 3,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: JColors.dark,
                  borderRadius:  BorderRadius.only(
                    topLeft: Radius.circular(iconBorderRad),
                    bottomRight: Radius.circular(iconBorderRad * 0.75),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Icon(
                    Iconsax.save_21,
                    color: saved ? Colors.yellow : JColors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}



class CompletionDate extends StatelessWidget {
  final DateTime completionDate;

  const CompletionDate({super.key, required this.completionDate});

  @override
  Widget build(BuildContext context) {

    return Text(
      'Completed on: ${DateFormat('dd - MM - yyyy').format(completionDate)}',
      style:  TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.bold ,color: JColors.black, ),
    );
  }
}


class Dates extends StatelessWidget {
  const Dates({super.key, required this.year, required this.month, required this.day});

  final int year;
  final int month;
  final int day;

  @override
  Widget build(BuildContext context) {
    final DateTime internshipEndDate = DateTime(year, month, day);
    return CompletionDate(completionDate: internshipEndDate);
  }
}