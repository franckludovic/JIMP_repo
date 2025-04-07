import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../utils/constants/sizes.dart';
import '../widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'image_picker.dart';

class ImageUploadDialog extends StatefulWidget {
  final String title;
  final Function(String) onUploadConfirmed;

  const ImageUploadDialog({
    super.key,
    required this.title,
    required this.onUploadConfirmed,
  });

  @override
  State<ImageUploadDialog> createState() => _ImageUploadDialogState();
}

class _ImageUploadDialogState extends State<ImageUploadDialog> {
  File? _selectedImage;
  final CloudinaryService _cloudinaryService = CloudinaryService();
  bool _uploading = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _confirmUpload() async {
    if (_selectedImage == null) return;

    setState(() => _uploading = true);
    try {
      final url = await _cloudinaryService.uploadImage(_selectedImage!);
      if (url != null) {
        widget.onUploadConfirmed(url);
        Navigator.pop(context);
      }
    } finally {
      setState(() => _uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: JRoundedContainer(
              width: 200,
              height: 200,
              borderColor:JColors.darkerGrey,
              backgroundColor: dark ? JColors.darkerGrey : JColors.grey,

              child: _selectedImage != null
                  ? Image.file(_selectedImage!, fit: BoxFit.cover,)
                  : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate, size: 40),
                  SizedBox(height: 10),
                  Text('Tap to select image'),
                ],
              ),
            ),
          ),
          if (_uploading) ...[
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ]
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: JSizes.md, vertical: JSizes.md * 0.6)
          ),
          onPressed: _selectedImage != null ? _confirmUpload : null,
          child: const Text('Confirm Upload'),
        ),
      ],
    );
  }
}