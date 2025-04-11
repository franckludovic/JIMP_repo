import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import 'features/Applications/models/categorie_model.dart';

class UploadCategoriesPage extends StatelessWidget {
  const UploadCategoriesPage({super.key});

  // Predefined list of categories.
  final List<Map<String, dynamic>> predefinedCategories = const [
    {"name": "Technology", "icon": "code", "isFeatured": true},
    {"name": "Business", "icon": "business", "isFeatured": true},
    {"name": "Design", "icon": "design", "isFeatured": true},
    {"name": "Data Analysis", "icon": "data", "isFeatured": true},
    {"name": "Artificial Intelligence", "icon": "ai", "isFeatured": true},
    {"name": "Finance", "icon": "finance", "isFeatured": true},
    {"name": "Marketing", "icon": "marketing", "isFeatured": true},
    {"name": "Engineering", "icon": "engineering", "isFeatured": true},
    {"name": "Education", "icon": "education", "isFeatured": true},
    {"name": "Healthcare", "icon": "health", "isFeatured": true},
    {"name": "Legal", "icon": "legal", "isFeatured": true},
    {"name": "Retail", "icon": "retail", "isFeatured": true},
    {"name": "Media & Entertainment", "icon": "media", "isFeatured": true},
    {"name": "Cybersecurity", "icon": "security", "isFeatured": true},
    {"name": "Customer Support", "icon": "support", "isFeatured": true},
    {"name": "Human Resources", "icon": "human_resources", "isFeatured": true},
    {"name": "Supply Chain", "icon": "local_shipping", "isFeatured": true},
    {"name": "Arts & Culture", "icon": "palette", "isFeatured": true},
  ];

  Future<void> uploadCategories() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final uuid = const Uuid();

    for (final cat in predefinedCategories) {
      // If you renamed the field in your model to iconKey, use that.
      final category = CategoryModel(
        id: uuid.v4(), // generate a new unique id
        name: cat['name'],
        image: cat['icon'],
        isFeatured: cat['isFeatured'],
        parentId: '',
      );
      await firestore
          .collection('categories')
          .doc(category.id)
          .set(category.toJson());
    }
    debugPrint("✅ Categories uploaded successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Categories"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.md),
          child: ElevatedButton(
            onPressed: () async {
              await uploadCategories();
              Get.snackbar("Success", "Categories uploaded successfully",
                  backgroundColor: Colors.green, colorText: Colors.white);
            },
            child: const Text("Upload Categories to Firebase"),
          ),
        ),
      ),
    );
  }
}
