import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

import 'package:project_bc_tuto/utils/constants/sizes.dart';

class SendProposalPage extends StatefulWidget {
  const SendProposalPage({super.key});

  @override
  State<SendProposalPage> createState() => _SendProposalPageState();
}

class _SendProposalPageState extends State<SendProposalPage> {
  // Controllers
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _contactNameController = TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();
  final TextEditingController _contactPhoneController = TextEditingController();
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _bonusesController = TextEditingController();
  final TextEditingController _responsibilitiesController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _probationController = TextEditingController();

  // Dropdown & Selection Values
  String _selectedProposalType = 'Full Time';
  String _selectedJobCategory = 'Job';
  String _selectedLocationType = 'Remote';
  String _selectedSalaryFrequency = 'Annual';
  String _selectedExperienceLevel = 'Mid-Level';
  String _selectedNoticePeriod = '2 weeks';
  DateTime? _startDate;
  DateTime? _applicationDeadline;
  final List<String> _selectedBenefits = [];
  bool _requireNDA = false;

  // Terms & conditions
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        showBackArrow: true,
        title: Text("Send Proposal", style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. Company Details Section
              _buildSectionCard(
                title: "Company Information",
                children: [
                  _buildLogoUpload(),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  TextField(
                    controller: _companyNameController,
                    decoration: const InputDecoration(
                      labelText: "Company Name*",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  TextField(
                    controller: _contactNameController,
                    decoration: const InputDecoration(
                      labelText: "Contact Person Name*",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  TextField(
                    controller: _contactEmailController,
                    decoration: const InputDecoration(
                      labelText: "Contact Email*",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  TextField(
                    controller: _contactPhoneController,
                    decoration: const InputDecoration(
                      labelText: "Contact Phone",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // 2. Position Details Section
              _buildSectionCard(
                title: "Position Details",
                children: [
                  TextField(
                    controller: _jobTitleController,
                    decoration: const InputDecoration(
                      labelText: "Job Title*",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  _buildDropdownRow(
                    left: DropdownButtonFormField(
                      value: _selectedProposalType,
                      items: ['Full Time', 'Part Time', 'Contract', 'Internship']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedProposalType = val!),
                      decoration: const InputDecoration(labelText: "Position Type*"),
                    ),
                    right: DropdownButtonFormField(
                      value: _selectedJobCategory,
                      items: ['Job', 'Internship']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedJobCategory = val!),
                      decoration: const InputDecoration(labelText: "Job Category*"),
                    ),
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  _buildDropdownRow(
                    left: DropdownButtonFormField(
                      value: _selectedLocationType,
                      items: ['Remote', 'On-site', 'Hybrid']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedLocationType = val!),
                      decoration: const InputDecoration(labelText: "Location Type*"),
                    ),
                    right: DropdownButtonFormField(
                      value: _selectedExperienceLevel,
                      items: ['Entry-Level', 'Mid-Level', 'Senior']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) => setState(() => _selectedExperienceLevel = val!),
                      decoration: const InputDecoration(labelText: "Experience Level*"),
                    ),
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  _buildDatePickerRow(
                    leftLabel: "Start Date*",
                    leftDate: _startDate,
                    leftOnTap: () => _selectDate(context, isStartDate: true),
                    rightLabel: "Application Deadline",
                    rightDate: _applicationDeadline,
                    rightOnTap: () => _selectDate(context, isStartDate: false),
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // 3. Compensation & Benefits Section
              _buildSectionCard(
                title: "Compensation & Benefits",
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _salaryController,
                          decoration: const InputDecoration(
                            labelText: "Salary/Stipend*",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: JSizes.spaceBtwItems),
                      Expanded(
                        child: DropdownButtonFormField(
                          value: _selectedSalaryFrequency,
                          items: ['Annual', 'Monthly', 'Hourly']
                              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (val) => setState(() => _selectedSalaryFrequency = val!),
                          decoration: const InputDecoration(labelText: "Frequency*"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  TextField(
                    controller: _bonusesController,
                    decoration: const InputDecoration(
                      labelText: "Bonuses (optional)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildBenefitChip("Health Insurance"),
                      _buildBenefitChip("401k"),
                      _buildBenefitChip("Paid Time Off"),
                      _buildBenefitChip("Stock Options"),
                      _buildBenefitChip("Training Budget"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // 4. Role & Requirements Section
              _buildSectionCard(
                title: "Role & Requirements",
                children: [
                  TextField(
                    controller: _responsibilitiesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: "Key Responsibilities*",
                      border: OutlineInputBorder(),
                      hintText: "List key responsibilities...",
                    ),
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  const Text("Required Skills (comma separated):"),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "e.g., Flutter, UX Design, Project Management",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {/* Handle skills input */},
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // 5. Terms & Conditions Section
              _buildSectionCard(
                title: "Terms & Conditions",
                children: [
                  TextField(
                    controller: _probationController,
                    decoration: const InputDecoration(
                      labelText: "Probation Period (optional)",
                      border: OutlineInputBorder(),
                      hintText: "e.g., 3 months",
                    ),
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  Row(
                    children: [
                      Checkbox(
                        value: _requireNDA,
                        onChanged: (val) => setState(() => _requireNDA = val!),
                      ),
                      const Text("Require Confidentiality Agreement (NDA)"),
                    ],
                  ),
                  DropdownButtonFormField(
                    value: _selectedNoticePeriod,
                    items: ['2 weeks', '1 month', '3 months']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) => setState(() => _selectedNoticePeriod = val!),
                    decoration: const InputDecoration(labelText: "Notice Period*"),
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Terms Agreement
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged: (val) => setState(() => _agreeToTerms = val!),
                      ),
                      const Expanded(child: Text("I agree to the terms and conditions")),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Submit Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _agreeToTerms ? _handleSubmit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: JColors.primary,
                      padding: const EdgeInsets.symmetric(horizontal: JSizes.lg, vertical: JSizes.md),
                    ),
                    child: const Text("Submit Proposal"),
                  ),
                  OutlinedButton(
                    onPressed: _handleSaveDraft,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: JSizes.lg, vertical: JSizes.md),
                    ),
                    child: const Text("Save Draft"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widgets
  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: JSizes.spaceBtwItems),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildLogoUpload() {
    return GestureDetector(
      onTap: () {/* Implement image picker */},
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_upload, size: 40, color: Colors.grey),
            Text("Upload Company Logo", style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownRow({required Widget left, required Widget right}) {
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: JSizes.spaceBtwItems),
        Expanded(child: right),
      ],
    );
  }

  Widget _buildDatePickerRow({
    required String leftLabel,
    required DateTime? leftDate,
    required VoidCallback leftOnTap,
    required String rightLabel,
    required DateTime? rightDate,
    required VoidCallback rightOnTap,
  }) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: leftOnTap,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: leftLabel,
                border: const OutlineInputBorder(),
              ),
              child: Text(leftDate != null
                  ? "${leftDate.day}/${leftDate.month}/${leftDate.year}"
                  : "Select Date"),
            ),
          ),
        ),
        const SizedBox(width: JSizes.spaceBtwItems),
        Expanded(
          child: InkWell(
            onTap: rightOnTap,
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: rightLabel,
                border: const OutlineInputBorder(),
              ),
              child: Text(rightDate != null
                  ? "${rightDate.day}/${rightDate.month}/${rightDate.year}"
                  : "Select Date"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitChip(String label) {
    return FilterChip(
      label: Text(label),
      selected: _selectedBenefits.contains(label),
      onSelected: (selected) => setState(() {
        if (selected) {
          _selectedBenefits.add(label);
        } else {
          _selectedBenefits.remove(label);
        }
      }),
    );
  }

  // Date Picker Function
  Future<void> _selectDate(BuildContext context, {required bool isStartDate}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _applicationDeadline = picked;
        }
      });
    }
  }

  // Submission Handlers
  void _handleSubmit() {
    // Collect all data
    final proposalData = {
      'companyName': _companyNameController.text,
      'contactName': _contactNameController.text,
      'contactEmail': _contactEmailController.text,
      'jobTitle': _jobTitleController.text,
      'proposalType': _selectedProposalType,
      'jobCategory': _selectedJobCategory,
      'locationType': _selectedLocationType,
      'startDate': _startDate,
      'deadline': _applicationDeadline,
      'salary': _salaryController.text,
      'salaryFrequency': _selectedSalaryFrequency,
      'bonuses': _bonusesController.text,
      'benefits': _selectedBenefits,
      'probationPeriod': _probationController.text,
      'ndaRequired': _requireNDA,
      'noticePeriod': _selectedNoticePeriod,
    };

    debugPrint("Proposal Data: $proposalData");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Proposal Submitted!")),
    );
  }

  void _handleSaveDraft() {
    debugPrint("Draft Saved");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Draft Saved!")),
    );
  }
}