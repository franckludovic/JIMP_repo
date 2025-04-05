import 'dart:io';
import 'package:dio/dio.dart';

class CloudinaryService {
  // Replace with your actual Cloudinary credentials:
  final String cloudName = 'dh8rvdhpt';
  final String uploadPreset = 'kzwsgasx';

  // Endpoint for uploading images.
  String get uploadUrl => 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

  Future<String?> uploadImage(File imageFile) async {
    try {
      final dio = Dio();

      // Prepare the multipart form data:
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
        'upload_preset': uploadPreset, // Required for unsigned uploads
      });

      final response = await dio.post(uploadUrl, data: formData);

      if (response.statusCode == 200) {
        // The response contains many fields; we need the secure URL.
        return response.data['secure_url'];
      } else {
        print("Error uploading image: ${response.statusMessage}");
        return null;
      }
    } catch (e) {
      print("Exception during image upload: $e");
      return null;
    }
  }
}