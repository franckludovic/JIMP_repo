import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/proposals/proposal_details.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

class ProposalCard extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String location;
  final String jobType;
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
            salary: salary,
            skills: skills,
            companyLogo: companyLogo,
            postedDate: postedDate,
          ),
        ),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CompanyProposalHeader(jobTitle: 'Senior SoftWare',),

          const SizedBox(height: 16),
          _buildDetailRow(
            icon: Icons.location_on_outlined,
            text: location,
          ),
          _buildDetailRow(
            icon: Icons.attach_money,
            text: salary,
          ),
          const SizedBox(height: 12),

          const SizedBox(height: 8),
          Text(
            "Posted $postedDate",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildDetailRow({required IconData icon, required String text}) {
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