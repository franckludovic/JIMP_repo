import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../utils/constants/image_strings.dart';

class ProposalDetailsScreen extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String location;
  final String jobType;
  final String salary;
  final List<String> skills;
  final String companyLogo;
  final String postedDate;

  const ProposalDetailsScreen({
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
    return Scaffold(
      appBar: JAppbar(
        title: Text('Proposal Details'.tr, style: Theme.of(context).textTheme.headlineMedium,),
       showBackArrow: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, size: 30,),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CompanyProposalHeader(jobTitle: jobTitle, companyLogo: companyLogo,),


            const SizedBox(height: JSizes.spaceBtwSections),
            proposalSectionTitle('Position Details'.tr),
            proposalDetailItem('Job Type'.tr, jobType),
            proposalDetailItem('location'.tr, location),
            proposalDetailItem('salary'.tr, salary),
            proposalDetailItem('Posted Date'.tr, postedDate),

            const SizedBox(height: 24),
            proposalSectionTitle('Required Skills'.tr),
            Wrap(
              spacing: 8,
              children: skills.map((skill) => Chip(
                label: Text(skill),
                backgroundColor: JColors.primary,
              )).toList(),
            ),

            const SizedBox(height: 24),
            proposalSectionTitle('Job Description'.tr),
            Text(
              'lorem_ipsum_description'.tr, // Add your translation
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 24),
            proposalSectionTitle('Benefits'.tr),
            Wrap(
              spacing: 8,
              children: [
                proposalBenefitChip('Health Insurance'.tr),
                proposalBenefitChip('Paid Time off'.tr),
                proposalBenefitChip('Retirement Plan'.tr),
              ],
            ),

            const SizedBox(height: 32),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }


  Widget proposalSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: JColors.primary,
        ),
      ),
    );
  }

  Widget proposalDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: TextStyle(color: JColors.darkGrey),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget proposalBenefitChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: JColors.success.withAlpha((0.1 * 255).toInt()),
      labelStyle: TextStyle(color: JColors.success),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.check, size: 20),
            label: Text('ACCEPT'.tr),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: JColors.success,
              foregroundColor: Colors.white,
            ), onPressed: () {  },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.close, size: 20),
            label: Text('REJECT'.tr),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: JColors.darkGrey),
            ), onPressed: () {  },
          ),
        ),
      ],
    );
  }
}

class CompanyProposalHeader extends StatelessWidget {
  const CompanyProposalHeader({
    super.key,
    required this.jobTitle,
    this.companyLogo = JImages.google,
  });

  final String jobTitle;
  final String companyLogo;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: JSizes.lg, vertical: JSizes.lg),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
              image:  DecorationImage(
                image: AssetImage(companyLogo,),
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text(
            jobTitle,
            style: Theme.of(context).textTheme.headlineMedium
          ),
        ],
      );
  }
}