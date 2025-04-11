import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/category_icons.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel(
      {required this.id,
      required this.name,
      this.parentId = '',
      required this.image,
      required this.isFeatured});

  ///Empty helper function
  static CategoryModel empty() =>
      CategoryModel(id: '', name: '', image: '', isFeatured: false);

  ///convert to mode to Json structure so that you can store data in firebase
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Image': image,
      'ParentId': parentId,
      'IsFeatured': isFeatured,
    };
  }

  ///mat json oriented document snapshot from firebase to use model
  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      //map json record to the model
      return CategoryModel(
          id: document.id,
          name: data['Name'] ?? '',
          image: data['Image'] ?? '',
          isFeatured: data['IsFeatured'] ?? false,
          parentId: data['ParentId'] ?? ''
      );
    }else {
      return CategoryModel.empty();
    }
  }

  IconData get iconData => IconMapper.getIconFromString(image);
  Color get iconColor => IconMapper.getIconColorFromString(image);

}
