import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ApplyFormPage extends StatefulWidget {
  const ApplyFormPage({super.key, required this.requiresVerification});


  final bool requiresVerification;

  @override
  State<ApplyFormPage> createState() => _ApplyFormPageState();
}

class _ApplyFormPageState extends State<ApplyFormPage> {
  bool isAdditionalDocsVisible = false;
  bool isSkillsVerified = false;
  String? resumePath;
  String? additionalDocsPath;

  Future<void> pickDocument(Function(String?) onFilePicked) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      onFilePicked(result.files.single.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Upload Resume
            GestureDetector(
              onTap: () => pickDocument((path) {
                setState(() {
                  resumePath = path;
                });
              }),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "+ Upload Resume",
                      style: TextStyle(color: Colors.purple),
                    ),
                    const Icon(Icons.file_upload, color: Colors.purple),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Checkbox for Additional Docs
            Row(
              children: [
                Checkbox(
                  value: isAdditionalDocsVisible,
                  onChanged: (value) {
                    setState(() {
                      isAdditionalDocsVisible = value ?? false;
                    });
                  },
                ),
                const Text("+ Additional Docs"),
              ],
            ),
            if (isAdditionalDocsVisible)
              GestureDetector(
                onTap: () => pickDocument((path) {
                  setState(() {
                    additionalDocsPath = path;
                  });
                }),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "+ Upload Additional Docs",
                        style: TextStyle(color: Colors.purple),
                      ),
                      const Icon(Icons.file_upload, color: Colors.purple),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            // Name Field
            TextField(
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Email Field
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Cover Letter
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: "Cover Letter",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.purple),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Verify Skills Button
            ElevatedButton(
              onPressed: widget.requiresVerification && !isSkillsVerified
                  ? null
                  : () {
                setState(() {
                  isSkillsVerified = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.requiresVerification && !isSkillsVerified
                    ? Colors.grey
                    : Colors.blue,
              ),
              child: Text(
                widget.requiresVerification && !isSkillsVerified
                    ? "VERIFY SKILLS (Locked)"
                    : "VERIFY SKILLS",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            // Apply Internship Button
            ElevatedButton(
              onPressed: (widget.requiresVerification && !isSkillsVerified)
                  ? null
                  : () {
                // Apply logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                (widget.requiresVerification && !isSkillsVerified)
                    ? Colors.grey
                    : Colors.purple,
              ),
              child: const Text(
                "APPLY INTERNSHIP",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
