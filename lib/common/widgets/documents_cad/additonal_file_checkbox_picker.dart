import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../../utils/constants/colors.dart';

class AdditionalFilesWidget extends StatefulWidget {
  const AdditionalFilesWidget({super.key});

  @override
  State<AdditionalFilesWidget> createState() => _AdditionalFilesWidgetState();
}

class _AdditionalFilesWidgetState extends State<AdditionalFilesWidget> {
  bool isAdditionalDocsVisible = false;
  String? additionalDocsPath;

  Future<void> pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        additionalDocsPath = result.files.single.path!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [
            Checkbox(
              value: isAdditionalDocsVisible,
              onChanged: (value) {
                setState(() {
                  isAdditionalDocsVisible = value ?? false;
                });
              },
            ),
            const Text("Additional Docs"),
          ],
        ),


        if (isAdditionalDocsVisible)
          GestureDetector(
            onTap: pickDocument,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: JColors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    additionalDocsPath != null
                        ? additionalDocsPath!.split('/').last
                        : "+ Upload Additional Docs",
                    style: const TextStyle(color: JColors.primary),
                  ),
                  const Icon(Icons.file_upload, color: Colors.purple),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
