import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:project_bc_tuto/utils/constants/sizes.dart';


import '../../../../common/widgets/companies/desciption_info_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../models/contracts_model.dart';

class ContractDetailPage extends StatelessWidget {
  final Contract contract;

  const ContractDetailPage({super.key, required this.contract});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contract.companyName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(JSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContractSummary(),
            const JSectionHeading(title: 'Contract Details', showActonButton: false,),
            _buildDetailItem('Position', contract.position),
            _buildDetailItem('Contract Type', contract.contractType),
            SizedBox(height: JSizes.md,),
            const JSectionHeading(title: 'My Role', showActonButton: false,),
            RedMoreInfoText(textBody: "You will be working on the Infrastructure  team and contributing to the development of our systems"),
            SizedBox(height: JSizes.md,),
            _buildDetailItem('Start Date',
                DateFormat('MMM dd, yyyy').format(contract.startDate)),
            _buildDetailItem('End Date',
                DateFormat('MMM dd, yyyy').format(contract.endDate)),
            const JSectionHeading(title: 'Payment Details', showActonButton: false,),
            _buildDetailItem('Rate', '\$${contract.payment}/${contract.frequency}'),
            _buildDetailItem('Payment Method', 'Direct Deposit'),
            const JSectionHeading(title: 'Milestones', showActonButton: false,),
            _buildProgressIndicator(),
            const SizedBox(height: JSizes.spaceBtwSections),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Contact Employer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContractSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(JSizes.md),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(contract.companyLogo),
              ),
              title: Text(contract.companyName),
              subtitle: Text(contract.position),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem('Status', contract.status),
                _buildSummaryItem('Progress', '${(contract.progress * 100).toInt()}%'),
                _buildSummaryItem('Next Payment', 'Jan 15'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: JSizes.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      children: [
        LinearProgressIndicator(
          value: contract.progress,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(
              _getProgressColor(contract.progress)),
        ),
        const SizedBox(height: JSizes.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Start: ${DateFormat('MMM dd').format(contract.startDate)}'),
            Text('End: ${DateFormat('MMM dd').format(contract.endDate)}'),
          ],
        ),
      ],
    );
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.3) return Colors.red;
    if (progress < 0.7) return Colors.orange;
    return Colors.green;
  }
}