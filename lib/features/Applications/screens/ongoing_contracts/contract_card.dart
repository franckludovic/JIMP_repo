import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../models/contracts_model.dart';

class ContractCard extends StatelessWidget {
  final Contract contract;
  final VoidCallback onPressed;

  const ContractCard({
    super.key,
    required this.contract,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: JSizes.spaceBtwItems),
      child: Padding(
        padding: const EdgeInsets.all(JSizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: JSizes.spaceBtwItems),
            _buildProgressIndicator(),
            const SizedBox(height: JSizes.spaceBtwSections),
            _buildContractDetails(),
            const SizedBox(height: JSizes.spaceBtwItems),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(contract.companyLogo),
          radius: 24,
        ),
        const SizedBox(width: JSizes.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contract.companyName,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(contract.position,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600)),
          ],
        ),
        const Spacer(),
        _buildStatusChip(),
      ],
    );
  }

  Widget _buildStatusChip() {
    Color statusColor;
    switch (contract.status) {
      case 'In Progress':
        statusColor = JColors.primary;
        break;
      case 'Awaiting Review':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Chip(
      label: Text(contract.status),
      backgroundColor: statusColor.withAlpha((0.1 * 255).toInt()),
      labelStyle: TextStyle(color: statusColor),
      side: BorderSide.none,
      padding: EdgeInsets.all(JSizes.xs),
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
        const SizedBox(height: JSizes.xs),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${(contract.progress * 100).toInt()}% Complete'),
            Text(
              DateFormat('MMM dd').format(contract.endDate),
              style: TextStyle(color: Colors.grey.shade600),
            ),
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

  Widget _buildContractDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(Iconsax.calendar,
            '${DateFormat('MMM dd').format(contract.startDate)} - '
                '${DateFormat('MMM dd').format(contract.endDate)}'),
        _buildDetailRow(Iconsax.wallet,
            '\$${contract.payment?.toStringAsFixed(2)}/${contract.frequency}'),
        if (contract.nextDeadline != null)
          _buildDetailRow(Iconsax.timer,
              'Next Deadline: ${contract.nextDeadline}'),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: JSizes.xs),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: JSizes.sm),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        child: const Text('View Details'),
      ),
    );
  }
}