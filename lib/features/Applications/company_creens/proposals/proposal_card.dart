import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/texts/compagny_title_with_verified_icon.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/proposals/proposal_details.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class ProposalCard extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String location;
  final String jobType;
  final String jobTag;
  final String salary;
  final List<String> skills;
  final String companyLogo;
  final String postedDate;

  const ProposalCard({
    super.key,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.jobType,
    required this.jobTag,
    required this.salary,
    required this.skills,
    required this.companyLogo,
    required this.postedDate,


  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => Get.to(
              () => ProposalDetailsScreen(
            companyName: companyName,
            jobTitle: jobTitle,
            location: location,
            jobType: jobType,
            jobTag: jobTag,
            salary: salary,
            skills: skills,
            companyLogo: companyLogo,
            postedDate: postedDate,
          ),
        ),
        borderRadius: BorderRadius.circular(JSizes.sm),
        child: Padding(
          padding: const EdgeInsets.all(JSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CompanyProposalHeader(jobTitle: jobTitle, companyLogo: companyLogo ),

              SizedBox(height: JSizes.sm,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    padding: EdgeInsets.all(JSizes.sm),
                    backgroundColor: JColors.primary.withAlpha((0.1 * 255).toInt()),
                    label: Text(jobType),
                  ),

                  Chip(
                    padding: EdgeInsets.all(JSizes.sm),
                    backgroundColor: JColors.primary.withAlpha((0.1 * 255).toInt()),
                    label: Text(jobTag),
                  ),
                ],
              ),

          const SizedBox(height: JSizes.sm),

          buildDetailRow(
            icon: Icons.location_on_outlined,
            text: location,
          ),

          buildDetailRow(
            icon: Icons.attach_money,
            text: salary,
          ),
          const SizedBox(height: JSizes.sm),

              Wrap(
                spacing: 8,
                children: skills.map((skill) => Chip(
                  padding: EdgeInsets.symmetric(vertical: JSizes.sm, horizontal: JSizes.sm),
                  label: Text(skill),
                  backgroundColor: JColors.grey.withAlpha((0.5 * 255).toInt()),
                )).toList(),
              ),



          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              JCompagnyTittleVerifications(title: companyName, isVerified: true,),

              Text(
                "Posted $postedDate",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          ],
        ),
      ),
    ),
    );
  }

  Widget buildDetailRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: JColors.darkGrey),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(color: JColors.darkGrey)),
        ],
      ),
    );
  }
}