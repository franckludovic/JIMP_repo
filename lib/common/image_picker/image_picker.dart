import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

/// CloudinaryService handles uploading images to Cloudinary.
class CloudinaryService {

  final String cloudName = 'dh8rvdhpt';
  final String uploadPreset = 'kzwsgasx';

  // Cloudinary upload endpoint.
  String get uploadUrl =>
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

  /// Uploads an image file and returns the secure URL.
  Future<String?> uploadImage(File imageFile) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
        'upload_preset': uploadPreset,
      });
      Response response = await dio.post(uploadUrl, data: formData);
      if (response.statusCode == 200) {
        return response.data['secure_url'];
      }
      return null;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }
}


class ImageUploadWidget extends StatefulWidget {
  final String title;
  final Function(String) onUploadCompleted;
  final String hintText;
  final IconData prefixIcon;

  const ImageUploadWidget({
    Key? key,
    required this.title,
    required this.onUploadCompleted,
    this.hintText = "PNG, JPEG, JPG accepted",
    this.prefixIcon = Icons.image,
  }) : super(key: key);

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  final ImagePicker _picker = ImagePicker();
  final CloudinaryService _cloudinaryService = CloudinaryService();
  String? _uploadedImageUrl;
  bool _uploading = false;

  // This text controller is only used for a placeholder if needed.
  final TextEditingController _textController = TextEditingController();

  Future<void> _pickAndUploadImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _uploading = true;
      });
      File imageFile = File(pickedFile.path);
      String? url = await _cloudinaryService.uploadImage(imageFile);
      if (url != null) {
        setState(() {
          _uploadedImageUrl = url;
          _textController.text = "Image uploaded"; // or clear it
          _uploading = false;
        });
        widget.onUploadCompleted(url); // store the URL in your model
      } else {
        setState(() {
          _uploading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to upload image")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickAndUploadImage,
      child: AbsorbPointer(
        child: _uploadedImageUrl != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(15),
              child: Image.network(_uploadedImageUrl!,
                  height: 100, width: 100, fit: BoxFit.cover,),
            )
            : TextField(
                controller: _textController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: Icon(widget.prefixIcon),
                  suffixIcon: _uploading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.upload),
                ),
              ),
      ),
    );
  }
}
