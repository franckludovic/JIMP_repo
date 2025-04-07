import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:open_file/open_file.dart';

import '../../../utils/constants/colors.dart';

class DocumentUploadWidget extends StatefulWidget {
  final String title;
  final String documentType;
  final void Function(String filePath)? onFileUploaded; // Callback for file upload

  const DocumentUploadWidget({
    super.key,
    this.title = "Upload Document",
    this.documentType = "Document type PDF, DOC, DOCX, PNG, JPEG, JPG",
    this.onFileUploaded,
  });

  @override
  State<DocumentUploadWidget> createState() => _DocumentUploadWidgetState();
}

class _DocumentUploadWidgetState extends State<DocumentUploadWidget> {
  File? selectedFile;

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpeg', 'jpg'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
      // Notify parent about the selected file path
      if (widget.onFileUploaded != null && selectedFile != null) {
        widget.onFileUploaded!(selectedFile!.path);
      }
    }
  }

  void openDocument() {
    if (selectedFile != null) {
      OpenFile.open(selectedFile!.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          widget.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: pickDocument,
          onLongPress: openDocument,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: JColors.grey),
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                Icon(Iconsax.document_upload, color: Colors.blue, size: 30),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    selectedFile != null
                        ? selectedFile!.path.split('/').last
                        : widget.documentType,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        if (selectedFile != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "File Selected:",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  selectedFile!.path.split('/').last,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.green,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
