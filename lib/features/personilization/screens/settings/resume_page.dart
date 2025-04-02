import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class ResumePage extends StatefulWidget {
  const ResumePage({super.key});

  @override
  State<ResumePage> createState() => _ResumePageState();
}

class _ResumePageState extends State<ResumePage> {
  int currentStep = 5;
  final String collectionName = "candidates";
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  /// Helper method to show an edit dialog.
  /// When updated, the field in Firestore is updated.
  void showEditDialog({
    required String fieldName,
    required String currentValue,
    required Function(String newValue) onUpdate,
    bool multiline = false,
  }) {
    final TextEditingController dialogController =
        TextEditingController(text: currentValue);
    Get.defaultDialog(
      title: "Edit $fieldName",
      content: Column(
        children: [
          TextField(
            controller: dialogController,
            maxLines: multiline ? 5 : 1,
            decoration: InputDecoration(
              labelText: fieldName,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              await onUpdate(dialogController.text);
              Get.back();
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  /// Helper widget for an editable info row.
  Widget buildEditableInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Function(String newValue) onEdit,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Expanded(
            child: Text("$label: $value",
                style: const TextStyle(fontSize: 14, color: Colors.black)),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 18, color: JColors.primary),
            onPressed: () {
              showEditDialog(
                fieldName: label,
                currentValue: value,
                onUpdate: onEdit,
                multiline: label == "Self Description",
              );
            },
          ),
        ],
      ),
    );
  }

  /// Helper widget to build a section card.
  Widget buildSectionCard(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: JColors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }

  /// Generates a PDF document from the user data.
  Future<pw.Document> _generatePdf(Map<String, dynamic> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Center(
                child: pw.Text(
              "${data['FirstName']} ${data['LastName']}",
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            )),
            pw.SizedBox(height: 10),
            pw.Center(
                child: pw.Text(data['Email'] ?? "",
                    style: pw.TextStyle(fontSize: 16))),
            pw.Divider(),
            pw.Text("Phone: ${data['PhoneNumber']}",
                style: pw.TextStyle(fontSize: 14)),
            pw.Text(
                "Location: ${data['City']}, ${data['Region']}, ${data['Country']}",
                style: pw.TextStyle(fontSize: 14)),
            pw.Text(
                "Education: ${data['EducationLevel']} at ${data['SchoolAttended']}",
                style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 10),
            pw.Text("Job Preference: ${data['JobTypePreference']}",
                style: pw.TextStyle(fontSize: 14)),
            pw.Text(
                "Opportunity: ${data['OpportunityType']} - ${data['JobCategory']}",
                style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 10),
            pw.Text("Self Description: ${data['SelfDescription']}",
                style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 10),
            pw.Text("Skills: ${data['Skills'].toString()}",
                style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 10),
            pw.Text("Languages: ${data['Languages'].toString()}",
                style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 10),
            pw.Text("Hobbies: ${data['Hobbies'].toString()}",
                style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 10),
            pw.Text("LinkedIn: ${data['Linkedin']}",
                style: pw.TextStyle(fontSize: 14)),
            pw.Text("GitHub: ${data['Github']}",
                style: pw.TextStyle(fontSize: 14)),
            pw.Text("Portfolio: ${data['Portfolio']}",
                style: pw.TextStyle(fontSize: 14)),
            pw.SizedBox(height: 20),
            pw.Text("Generated on: ${DateTime.now()}",
                style: pw.TextStyle(fontSize: 12, color: PdfColors.grey)),
          ];
        },
      ),
    );

    return pdf;
  }

  /// Shares the generated PDF.
  Future<void> _sharePdf(Map<String, dynamic> data) async {
    final pdf = await _generatePdf(data);
    await Printing.sharePdf(bytes: await pdf.save(), filename: "resume.pdf");
  }

  /// Updates a field in Firestore for the current user.
  Future<void> _updateField(String field, String newValue) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(uid)
        .update({
      field: newValue,
      'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: const Text('Your Resume'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
              // Generate and share PDF when pressed.
              DocumentSnapshot doc = await FirebaseFirestore.instance
                  .collection(collectionName)
                  .doc(uid)
                  .get();
              if (doc.exists) {
                _sharePdf(doc.data() as Map<String, dynamic>);
              }
            },
          ),
        ],
        showBackArrow: true,
      ),
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection(collectionName)
              .doc(uid)
              .get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.data!.exists) {
              return const Center(child: Text("No data found"));
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(JSizes.defaultSpace),
              child: Column(
                children: [
                  // Profile Section
                  Container(
                    width: 200,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.grey[300],
                          child: data['ProfilePicture'] != null &&
                                  data['ProfilePicture'] != ""
                              ? CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      NetworkImage(data['ProfilePicture']),
                                )
                              : const Text("No Image"),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${data['FirstName']} ${data['LastName']}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(data['Email'] ?? "",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey)),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            showEditDialog(
                              fieldName: "Profile Picture URL",
                              currentValue: data['ProfilePicture'] ?? "",
                              onUpdate: (newValue) async {
                                await _updateField("ProfilePicture", newValue);
                                setState(() {});
                              },
                            );
                          },
                          icon: const Icon(Icons.edit),
                          label: const Text("Edit Picture"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  // Basic Information Section
                  buildSectionCard("Basic Information", [
                    buildEditableInfoRow(
                        icon: Icons.person,
                        label: "Name",
                        value: "${data['FirstName']} ${data['LastName']}",
                        onEdit: (newValue) async {
                          await _updateField("FirstName", newValue);
                          // Optionally update LastName similarly\n                        setState(() {});\n                      },
                        }),
                    buildEditableInfoRow(
                      icon: Icons.email,
                      label: "Email",
                      value: data['Email'] ?? "",
                      onEdit: (newValue) async {
                        await _updateField("Email", newValue);
                        setState(() {});
                      },
                    ),
                    buildEditableInfoRow(
                      icon: Icons.phone,
                      label: "Phone",
                      value: data['PhoneNumber'] ?? "",
                      onEdit: (newValue) async {
                        await _updateField("PhoneNumber", newValue);
                        setState(() {});
                      },
                    ),
                    buildEditableInfoRow(
                      icon: Icons.lock,
                      label: "Password",
                      value: "********",
                      onEdit: (newValue) async {
                        await _updateField("Password", newValue);
                        setState(() {});
                      },
                    ),
                  ]),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  // Location & Education Section
                  buildSectionCard("Location & Education", [
                    buildEditableInfoRow(
                      icon: Icons.flag,
                      label: "Country",
                      value: data['Country'] ?? "",
                      onEdit: (newValue) async {
                        await _updateField("Country", newValue);
                        setState(() {});
                      },
                    ),
                    buildEditableInfoRow(
                      icon: Icons.map,
                      label: "Region",
                      value: data['Region'] ?? "",
                      onEdit: (newValue) async {
                        await _updateField("Region", newValue);
                        setState(() {});
                      },
                    ),
                    buildEditableInfoRow(
                      icon: Icons.location_city,
                      label: "City",
                      value: data['City'] ?? "",
                      onEdit: (newValue) async {
                        await _updateField("City", newValue);
                        setState(() {});
                      },
                    ),
                    buildEditableInfoRow(
                      icon: Icons.home,
                      label: "Local Address",
                      value: data['LocalAddress'] ?? "",
                      onEdit: (newValue) async {
                        await _updateField("LocalAddress", newValue);
                        setState(() {});
                      },
                    ),
                    buildEditableInfoRow(
                      icon: Icons.school,
                      label: "Education",
                      value:
                          "${data['EducationLevel']} at ${data['SchoolAttended']}",
                      onEdit: (newValue) async {
                        await _updateField("EducationLevel", newValue);
                        setState(() {});
                      },
                    ),
                    buildEditableInfoRow(
                      icon: Icons.business,
                      label: "Job Preference",
                      value: data['JobTypePreference'] ?? "",
                      onEdit: (newValue) async {
                        await _updateField("JobTypePreference", newValue);
                        setState(() {});
                      },
                    ),
                  ]),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  // Opportunity Section
                  buildSectionCard("Opportunity", [
                    buildEditableInfoRow(
                      icon: Icons.work,
                      label: "Opportunity Type",
                      value: data['OpportunityType'] ?? "",
                      onEdit: (newValue) async {
                        await _updateField("OpportunityType", newValue);
                        setState(() {});
                      },
                    ),
                    buildEditableInfoRow(
                      icon: Icons.category,
                      label: "Job Category",
                      value: data['JobCategory'] ?? "",
                      onEdit: (newValue) async {
                        await _updateField("JobCategory", newValue);
                        setState(() {});
                      },
                    ),
                  ]),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  // Self Description & Resume Section
                  buildSectionCard("Profile Details", [
                    buildEditableInfoRow(
                      icon: Icons.text_snippet,
                      label: "Self Description",
                      value: data['SelfDescription'] != null &&
                              data['SelfDescription'].toString().isNotEmpty
                          ? data['SelfDescription']
                          : "Not provided",
                      onEdit: (newValue) async {
                        await _updateField("SelfDescription", newValue);
                        setState(() {});
                      },
                    ),
                    buildEditableInfoRow(
                      icon: Icons.upload_file,
                      label: "Resume",
                      value: data['Resume'] != null &&
                              data['Resume'].toString().isNotEmpty
                          ? data['Resume']
                          : "Not provided",
                      onEdit: (newValue) async {
                        await _updateField("Resume", newValue);
                        setState(() {});
                      },
                    ),
                  ]),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  // Skills Section
                  buildSectionCard("Skills", [
                    Text(
                      data['Skills'] != null &&
                              (data['Skills'] as List).isNotEmpty
                          ? (data['Skills'] as List)
                              .map((s) => s.toString())
                              .join(" | ")
                          : "No skills provided",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit,
                          size: 18, color: JColors.primary),
                      onPressed: () {
                        Get.snackbar("Edit Skills",
                            "Implement skill editing dialog here");
                      },
                    ),
                  ]),
                  const SizedBox(height: JSizes.spaceBtwItems),
                  // Hobbies Section
                  buildSectionCard("Hobbies", [
                    Text(
                      data['Hobbies'] != null &&
                              (data['Hobbies'] as List).isNotEmpty
                          ? (data['Hobbies'] as List).join(" | ")
                          : "No hobbies provided",
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit,
                          size: 18, color: JColors.primary),
                      onPressed: () {
                        showEditDialog(
                          fieldName: "Hobbies",
                          currentValue: data['Hobbies'] != null
                              ? (data['Hobbies'] as List).join(", ")
                              : "",
                          onUpdate: (newValue) async {
                            await _updateField(
                                "Hobbies",
                                newValue
                                    .split(",")
                                    .map((s) => s.trim())
                                    .toList()
                                    .toString());
                            setState(() {});
                          },
                          multiline: true,
                        );
                      },
                    ),
                  ]),
                  const SizedBox(height: JSizes.spaceBtwItems),

                  const SizedBox(height: JSizes.spaceBtwItems),
                  // Finish Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () async {
                        // You can add any additional final actions here
                        Get.snackbar(
                            "Finished", "Your resume has been updated!");
                      },
                      child: const Text(
                        "FINISH",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: JSizes.spaceBtwSections, top: JSizes.md),
        child: SizedBox(
          height: 50,
          child: StepIndicator(currentIndex: currentStep, totalSteps: 5),
        ),
      ),
    );
  }
}
