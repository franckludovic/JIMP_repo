import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/models/user_model.dart';
import 'package:project_bc_tuto/features/personilization/controllers/user_controller.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common/widgets/icons/jsaveicon.dart';
import '../../../../utils/popups/loaders.dart';
import '../../controllers/applicant_controller.dart';
import '../../models/posting_model.dart';
import '../application_page_form/applyPage.dart';

class JobDetailsController extends GetxController {
  final PostingModel job;
  final RxBool isBookmarked = false.obs;
  final RxBool isSaved = false.obs;

  JobDetailsController(this.job);

  void toggleSaved() => isSaved.toggle();

  void shareJob() {
    Share.share(
      'Check out this ${job.jobTitle} position at ${job.companyName}:\n\n'
      '${job.jobDescription}\n\nApply here: [Application Link]',
    );
  }

  void launchEmail() async {
    final uri = Uri.parse('mailto:${job.contactEmail}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar('Error', 'Could not launch email client');
    }
  }
}

class JobDetailsPage extends StatelessWidget {
  final PostingModel posting;

  const JobDetailsPage({super.key, required this.posting});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobDetailsController(posting));
    final dateFormat = DateFormat('MMM dd, yyyy');


    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              posting.companyLogo,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: Colors.grey[100],
                child: const Icon(Icons.business, size: 60),
              ),
            ),
          ),
          pinned: true,
          actions: [
            JSaveIcon(
              postingId: posting.id,
            ),
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: controller.shareJob,
            ),
          ],
        ),
        SliverToBoxAdapter(
          // Fixed syntax
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatusIndicator(),
                _buildHeaderSection(),
                const SizedBox(height: 24),
                _buildContactSection(controller),
                _buildSectionTitle('About the Opportunity'),
                _buildSectionContent(posting.jobDescription),
                _buildDetailGrid(posting),
                _buildChipSection('Required Skills', posting.requiredSkills),
                _buildChipSection('Benefits', posting.benefits),
                _buildChipSection('Tags', posting.tags),
                _buildDetailSection(posting, dateFormat),
                const SizedBox(height: 40),
                _buildActionButtons(controller),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  // Update the _buildStatusIndicator method
  Widget _buildStatusIndicator() {
    return Container(
      margin: EdgeInsets.only(bottom: JSizes.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTypeChip(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: _getStatusColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, size: 16, color: _getStatusColor()),
                const SizedBox(width: 8),
                Text(
                  posting.applicationStatus.toString().split('.').last,
                  style: TextStyle(
                    color: _getStatusColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Add new method for opportunity type chip
  Widget _buildTypeChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _getTypeColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.work_outline, size: 16, color: _getTypeColor()),
          const SizedBox(width: 8),
          Text(
            posting.opportunityType,
            style: TextStyle(
              color: _getTypeColor(),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

// Add color mapping for opportunity types
  Color _getTypeColor() {
    switch (posting.opportunityType.toLowerCase()) {
      case 'internship':
        return Colors.purple.shade200;
      case 'job':
        return Colors.green;
      case 'contract':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor() {
    switch (posting.applicationStatus) {
      case ApplicationStatus.applied:
        return Colors.blue;
      case ApplicationStatus.accepted:
        return Colors.green;
      case ApplicationStatus.rejected:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          posting.jobTitle,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.business, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Text(
              posting.companyName,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_pin, size: 18, color: Colors.grey.shade600),
            const SizedBox(width: 8),
            Text(
              posting.location,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactSection(JobDetailsController controller) {
    return InkWell(
      onTap: controller.launchEmail,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: Colors.blue[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.email, color: Colors.blue),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contact Email',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Text(
                    posting.contactEmail,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailGrid(PostingModel job) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[50]?.withAlpha((0.3 * 255).toInt()),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if(job.opportunityType == 'Internship')
              _buildGridItem('Duration', job.duration ?? ''),
            if(job.opportunityType == 'Job' || job.opportunityType == 'Contract' )
              _buildGridItem('Salary', job.salaryRange ?? 'Negotiable'),
            const VerticalDivider(indent: 10, endIndent: 10),
            _buildGridItem('Type', job.employmentMode),
            const VerticalDivider(indent: 10, endIndent: 10),
            _buildGridItem(
                'Deadline', DateFormat('MMM dd').format(job.deadline)),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          title,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildChipSection(String title, List<String> items) {
    if (items.isEmpty) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items
                .map((item) => Chip(
                      label: Text(item),
                      backgroundColor: Colors.grey[650],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(PostingModel job, DateFormat dateFormat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailItem('Experience Level', job.experienceLevel),
        _buildDetailItem('Education Required', job.educationLevel),
        _buildDetailItem('Language Requirements', job.languageRequirements),
        if (job.duration != null)
          _buildDetailItem('Internship Duration', job.duration!),
        _buildDetailItem(
            'Application Deadline', dateFormat.format(job.deadline)),

        // Add new requirements sections
        if (job.minimumRequirements?.isNotEmpty ?? false)
          _buildRequirementSection(
              'Minimum Requirements', job.minimumRequirements!),

        if (job.preferredRequirements?.isNotEmpty ?? false)
          _buildRequirementSection(
              'Preferred Requirements', job.preferredRequirements!),

        if (job.additionalInfo?.isNotEmpty ?? false)
          _buildRequirementSection(
              'Additional Information', job.additionalInfo!),
      ],
    );
  }

  Widget _buildDetailItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildSectionContent(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        height: 1.6,
        color: Colors.grey.shade800,
      ),
    );
  }

  Widget _buildRequirementSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: JColors.secondary.withAlpha((0.5 * 255).toInt())),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(JobDetailsController controller) {


    return Row(
      children: [
        Expanded(
          child: Obx(() => OutlinedButton.icon(
                icon: const Icon(Icons.save),
                label:
                    Text(controller.isSaved.value ? 'Saved' : 'Save for Later'),
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.blue.shade800)),
                onPressed: controller.toggleSaved,
              )),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue[800]),
            onPressed: () {
              Get.put(UserController());
              final user = UserController.instance.user;
              if (user != null) {

                Get.to(() => ApplyPage(posting: posting, candidate: user));
              } else {
                JLoaders.warningSnackBar(
                    title: 'User not found',
                    message: 'Please wait while we load your profile.');
              }
            },
            child: const Text('Apply Now'),
          ),
        ),
      ],
    );
  }
}
