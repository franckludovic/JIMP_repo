import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/image_picker/imagepickerDialog.dart';
import '../../../Applications/models/user_model.dart';
import '../../../authentication/screens/Sign_up/widgets/skillAddDialog.dart';
import '../../controllers/user_controller.dart';

class ResumePage2 extends StatefulWidget {
  const ResumePage2({super.key,});



  @override
  State<ResumePage2> createState() => _ResumePageState();
}



class _ResumePageState extends State<ResumePage2> {
  int currentStep = 5;
  final String collectionName = "candidates";
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  Future<List<LanguageEntry>?> showLanguageDialog(BuildContext context, List<LanguageEntry> currentLanguages) async {
    final TextEditingController languageController = TextEditingController();
    int selectedProficiency = 1;

    return await showDialog<List<LanguageEntry>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Add Language'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: languageController,
                  decoration: const InputDecoration(
                    labelText: 'Enter a Language',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Proficiency:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [1, 2, 3].map((level) {
                    return Row(
                      children: [
                        Radio<int>(
                          value: level,
                          groupValue: selectedProficiency,
                          onChanged: (value) {
                            setState(() {
                              selectedProficiency = value!;
                            });
                          },
                        ),
                        Text('$level'),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final newLang = languageController.text.trim();
                  if (newLang.isEmpty) return;

                  final List<LanguageEntry> result = List.from(currentLanguages);

                  final index = result.indexWhere(
                        (l) => l.language.toLowerCase() == newLang.toLowerCase(),
                  );

                  if (index != -1) {
                    // Update proficiency if changed
                    if (result[index].proficiency != selectedProficiency) {
                      result[index] = LanguageEntry(language: newLang, proficiency: selectedProficiency);
                    }
                  } else {
                    // Add new language
                    result.add(LanguageEntry(language: newLang, proficiency: selectedProficiency));
                  }

                  Navigator.pop(context, result);
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<SkillEntry>?> showSkillDialog(BuildContext context) {
    return showDialog<List<SkillEntry>>(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: SkillDialogContent(),
        );
      },
    );
  }



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
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: JSizes.md, vertical: JSizes.md * 0.6)
            ),
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

  Widget buildLanguageChips() {
    return Wrap(
      spacing: 3,
      runSpacing: 3,
      children: UserController.instance.user!.languages.map((entry) {
        return Chip(
          padding: EdgeInsets.all(JSizes.xxs),
          label: Text('${entry.language} (Lv${entry.proficiency})'),
          deleteIcon: const Icon(Icons.close),
          onDeleted: () {
            UserController.instance.user!.languages.remove(entry);
          },
        );
      }).toList(),
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
            child: Text("$label $value",
                style: const TextStyle(fontSize: 14, color: Colors.black)),
          ),
          IconButton(
            icon: const Icon(Iconsax.edit, size: 20, color: JColors.primary),
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
      width: double.infinity,
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
    final controller = UserController.instance;
    return Scaffold(
      appBar: JAppbar(
        title: const Text('Your Resume'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: () async {
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
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.grey[300],
                                  child: data['ProfilePicture'] != null &&
                                          data['ProfilePicture'] != ""
                                      ? Obx(
                                          () => CircleAvatar(
                                            radius: 80,
                                            backgroundImage: NetworkImage(
                                                controller
                                                        .user?.profilePicture ??
                                                    ''),
                                          ),
                                        )
                                      : const Text("No Image"),
                                ),
                                SizedBox(
                                  height: JSizes.md,
                                )
                              ],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 10,
                              child: IconButton(
                                icon: const Icon(Iconsax.edit,
                                    color: JColors.primary, size: 30),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (_) => ImageUploadDialog(
                                    title: "Upload Profile Image",
                                    onUploadConfirmed: (url) {
                                      controller.user?.profilePicture = url;
                                      controller.update();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          controller.user?.fullName ?? "",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(controller.user?.email ?? "",
                            style: const TextStyle(
                                fontSize: 16, color: Colors.grey)),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems * 0.3),
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
                  ]),

                  buildSectionCard('Description', [
                    buildEditableInfoRow(
                      icon: Icons.text_snippet,
                      label: "",
                      value: data['SelfDescription'] != null &&
                              data['SelfDescription'].toString().isNotEmpty
                          ? data['SelfDescription']
                          : "Not provided",
                      onEdit: (newValue) async {
                        await _updateField("SelfDescription", newValue);
                        setState(() {});
                      },
                    ),
                  ]),
                  const SizedBox(height: JSizes.spaceBtwItems * 0.3),
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
                      label: "School attended",
                      value: "${data['SchoolAttended']}",
                      onEdit: (newValue) async {
                        await _updateField("SchoolAttended", newValue);
                        setState(() {});
                      },
                    ),

                    buildEditableInfoRow(
                      icon: Icons.school,
                      label: "Latest Certificate",
                      value: "${data['EducationLevel']} ",
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
                  const SizedBox(height: JSizes.spaceBtwItems * 0.3),
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
                  const SizedBox(height: JSizes.spaceBtwItems * 0.3),


                  const SizedBox(height: JSizes.spaceBtwItems * 0.3),
                  // Skills Section
                  buildSectionCard("Skills", [
                    Obx(() => Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: controller.user!.skills.map((entry) {
                            return InputChip(
                              label: Text(
                                "${entry.skill} (Lvl ${entry.level})",
                                style: TextStyle(
                                    color: Colors.black, fontFamily: 'Poppins'),
                              ),
                              onDeleted: () async {
                                final shouldDelete = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("Remove Skill"),
                                    content: Text(
                                        "Are you sure you want to remove '${entry.skill}'?"),
                                    actions: [
                                      OutlinedButton(
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: JSizes.md,
                                                  vertical: JSizes.md * 0.6)),
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: JColors.secondary,
                                                fontFamily: 'Poppins'),
                                          )),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: JSizes.md,
                                                  vertical: JSizes.md * 0.6)),
                                          onPressed: () =>
                                              Navigator.pop(context, true),
                                          child: const Text("Remove",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins'))),
                                    ],
                                  ),
                                );

                                if (shouldDelete == true) {
                                  controller.user!.skills.remove(entry);
                                }
                              },
                              deleteIcon: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.red,
                              ),
                              backgroundColor: Colors.grey.shade200,
                            );
                          }).toList(),
                        )),
                    IconButton(
                        icon: const Icon(Iconsax.edit,
                            size: 18, color: JColors.primary),
                        onPressed: () async {
                          final result = await showSkillDialog(context);
                          if (result != null && result.isNotEmpty) {
                            for (final newSkill in result) {
                              final index = controller.user!.skills.indexWhere(
                                (s) =>
                                    s.skill.toLowerCase().trim() ==
                                    newSkill.skill.toLowerCase().trim(),
                              );

                              if (index != -1) {
                                // If the skill already exists, only update if the level is different
                                if (controller.user!.skills[index].level !=
                                    newSkill.level) {
                                  controller.user!.skills[index] = newSkill;
                                }
                              } else {
                                // If it's a new skill, add it
                                controller.user!.skills.add(newSkill);
                              }
                            }

                            controller.user!.skills.refresh();
                          }
                        }),
                  ]),



                  buildSectionCard('Languages', [
                    Obx(() => Wrap(
                      spacing: 3,
                      runSpacing: 3,
                      children: controller.user!.languages.map((entry) {
                        return Chip(
                          padding: EdgeInsets.all(JSizes.xxs),
                          label: Text('${entry.language} (Lv${entry.proficiency})'),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () {
                            controller.user!.languages.remove(entry);
                          },
                        );
                      }).toList(),
                    )),
                    IconButton(
                      icon: const Icon(Iconsax.edit, color: JColors.primary, size: 18),
                      onPressed: () async {
                        final updatedLanguages = await showLanguageDialog(context, controller.user!.languages.toList());
                        if (updatedLanguages != null) {
                          controller.user!.languages.assignAll(updatedLanguages);
                        }
                      },
                    ),
                  ]),

                  const SizedBox(height: JSizes.spaceBtwItems * 0.3),
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
                      icon: const Icon(Iconsax.edit,
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
                  const SizedBox(height: JSizes.spaceBtwItems * 0.3),

                  const SizedBox(height: JSizes.spaceBtwItems * 0.3),
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

extension on List<SkillEntry> {
  void refresh() {}
}
