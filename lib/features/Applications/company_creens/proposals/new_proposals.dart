import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class SendProposalPage extends StatefulWidget {
  const SendProposalPage({super.key});

  @override
  State<SendProposalPage> createState() => _SendProposalPageState();
}

class _SendProposalPageState extends State<SendProposalPage> {
  // Controllers for text fields
  final TextEditingController _proposalTitleController = TextEditingController();
  final TextEditingController _candidateNameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();


  String _selectedProposalType = 'Job';


  // Terms & conditions
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        showBackArrow: true,
        title:  Text("Send Proposal", style: Theme.of(context).textTheme.headlineMedium,),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. Proposal Details Card
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // A placeholder image or company logo
                      Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                            image: AssetImage(JImages.google), // Replace with your asset or network image
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Proposal Title
                      TextField(
                        controller: _proposalTitleController,
                        decoration: const InputDecoration(
                          labelText: "Proposal Title",
                          hintText: "Enter a title for this proposal",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Candidate Name
                      TextField(
                        controller: _candidateNameController,
                        decoration: const InputDecoration(
                          labelText: "Candidate Name",
                          hintText: "John Smith",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Position / Proposal Type
                      TextField(
                        controller: _positionController,
                        decoration: const InputDecoration(
                          labelText: "Position",
                          hintText: "Software Engineer",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),


                      _buildProposalTypeSelector(),


                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 2. Description Field
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      hintText: "Enter the details of your proposal...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 16),

              // 4. Terms & Conditions
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _agreeToTerms,
                        onChanged: (val) {
                          setState(() {
                            _agreeToTerms = val ?? false;
                          });
                        },
                      ),
                      const Expanded(
                        child: Text("I agree to the terms and conditions"),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 5. Submit & Save Draft Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Submit
                  ElevatedButton(
                    onPressed: _agreeToTerms ? _handleSubmit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: JColors.primary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: JSizes.lg,
                        vertical: JSizes.md,
                      ),
                    ),
                    child: const Text("Submit Proposal"),
                  ),
                  // Save Draft
                  OutlinedButton(
                    onPressed: _handleSaveDraft,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: JSizes.lg,
                        vertical: JSizes.md,
                      ),
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

  /// A helper widget for selecting proposal type
  Widget _buildProposalTypeSelector() {
    return Row(
      children: [
        const Text("Proposal Type:  "),
        DropdownButton<String>(
          value: _selectedProposalType,
          items: const [
            DropdownMenuItem(value: "Job", child: Text("Job")),
            DropdownMenuItem(value: "Internship", child: Text("Internship")),
          ],
          onChanged: (val) {
            setState(() {
              _selectedProposalType = val ?? "Job";
            });
          },
        ),
      ],
    );
  }




  /// Called when user taps "Submit Proposal"
  void _handleSubmit() {
    // Gather data
    final proposalTitle = _proposalTitleController.text.trim();
    final candidateName = _candidateNameController.text.trim();
    final position = _positionController.text.trim();
    final description = _descriptionController.text.trim();
    final proposalType = _selectedProposalType;

    // Validate or send to your DB / API
    // For now, just print
    debugPrint("Submitting proposal:\n"
        "Title: $proposalTitle\n"
        "Candidate: $candidateName\n"
        "Position: $position\n"
        "Type: $proposalType\n"
        "Description: $description\n"
        "Agreed to T&C: $_agreeToTerms");

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Proposal Submitted!")),
    );
  }

  /// Called when user taps "Save Draft"
  void _handleSaveDraft() {
    // You can store the input in a DB or local storage
    debugPrint("Draft saved locally or in DB");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Draft Saved!")),
    );
  }
}
