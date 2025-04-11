import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';


import 'features/Applications/models/sub_categorie_model.dart';

class UploadSubCategoriesPage extends StatelessWidget {
  const UploadSubCategoriesPage({super.key});

  // Use the mapping defined earlier
  final Map<String, List<String>> predefinedSubCategories = const {
    "Technology": [
      "Software Development",
      "Web Development",
      "Mobile App Development",
      "DevOps",
      "Cloud Computing",
      "IT Support",
      "Network Administration",
      "Database Administration",
      "Systems Engineering",
      "Game Development",
    ],
    "Business": [
      "Management",
      "Business Strategy",
      "Entrepreneurship",
      "Consulting",
      "Operations Management",
    ],
    "Design": [
      "Graphic Design",
      "UX/UI Design",
      "Product Design",
      "Interior Design",
      "Fashion Design",
    ],
    "Data Analysis": [
      "Data Science",
      "Data Engineering",
      "Business Intelligence",
      "Statistical Analysis",
      "Data Visualization",
    ],
    "Artificial Intelligence": [
      "Machine Learning",
      "Deep Learning",
      "Natural Language Processing",
      "Computer Vision",
      "AI Research",
    ],
    "Finance": [
      "Accounting",
      "Financial Analysis",
      "Auditing",
      "Investment Banking",
      "Tax Consulting",
    ],
    "Marketing": [
      "Digital Marketing",
      "Content Marketing",
      "SEO/SEM",
      "Social Media Marketing",
      "Brand Management",
    ],
    "Engineering": [
      "Civil Engineering",
      "Mechanical Engineering",
      "Electrical Engineering",
      "Chemical Engineering",
      "Environmental Engineering",
    ],
    "Education": [
      "Teaching",
      "Tutoring",
      "Curriculum Development",
      "E-Learning",
      "Research",
    ],
    "Healthcare": [
      "Nursing",
      "Medical Assistance",
      "Pharmacy",
      "Public Health",
      "Medical Administration",
    ],
    "Legal": [
      "Corporate Law",
      "Criminal Law",
      "Intellectual Property",
      "Legal Consulting",
      "Compliance",
    ],
    "Retail": [
      "Store Management",
      "Sales",
      "Merchandising",
      "E-Commerce",
      "Customer Service",
    ],
    "Media & Entertainment": [
      "Film Production",
      "Broadcasting",
      "Journalism",
      "Animation",
      "Music Production",
    ],
    "Cybersecurity": [
      "Network Security",
      "Ethical Hacking",
      "Cyber Forensics",
      "Information Security",
      "Security Compliance",
    ],
    "Customer Support": [
      "Help Desk",
      "Technical Support",
      "Live Chat",
      "Client Relations",
      "Customer Service",
    ],
    "Human Resources": [
      "Recruitment",
      "Employee Engagement",
      "Payroll",
      "HR Strategy",
      "Training and Development",
    ],
    "Supply Chain": [
      "Logistics",
      "Procurement",
      "Inventory Management",
      "Distribution",
      "Operations",
    ],
    "Arts & Culture": [
      "Fine Arts",
      "Performing Arts",
      "Museum Studies",
      "Cultural Management",
      "Art Curation",
    ],
  };

  Future<void> uploadSubCategories() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final uuid = const Uuid();

    // Loop through every main category entry.
    for (final mainCat in predefinedSubCategories.entries) {
      final String mainCategory = mainCat.key;
      final List<String> subCats = mainCat.value;

      // For each subcategory, create a SubCategoryModel and upload it.
      for (final subCat in subCats) {
        final subCategory = SubCategoryModel(
          id: uuid.v4(), // Unique subcategory ID
          name: subCat,
          parentCategory: mainCategory, // Link to main category by name
        );
        await firestore
            .collection('subcategories')
            .doc(subCategory.id)
            .set(subCategory.toJson());
      }
    }
    debugPrint("✅ Subcategories uploaded successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Subcategories")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.md),
          child: ElevatedButton(
            onPressed: () async {
              await uploadSubCategories();
              Get.snackbar("Success", "Subcategories uploaded successfully",
                  backgroundColor: Colors.green, colorText: Colors.white);
            },
            child: const Text("Upload Subcategories to Firebase"),
          ),
        ),
      ),
    );
  }
}
