import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoryModel {
  final String id;
  final String name;
  final String parentCategory; // Use main category name or ID

  SubCategoryModel({
    required this.id,
    required this.name,
    required this.parentCategory,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json, String id) {
    return SubCategoryModel(
      id: id,
      name: json['name'] ?? '',
      parentCategory: json['parentCategory'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'parentCategory': parentCategory,
  };

  static SubCategoryModel empty() =>
      SubCategoryModel(id: '', name: '', parentCategory: '');
}
