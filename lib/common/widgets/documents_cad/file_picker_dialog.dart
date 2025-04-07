import 'package:flutter/material.dart';
import 'dart:io';

import 'file_picker_card.dart';



class DocumentUploadDialog {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required void Function(String filePath) onSave,
  }) async {
    File? tempSelectedFile;

    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(''),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 130),
            child: StatefulBuilder(
              builder: (context, setState) {
                return SizedBox(
                  child: DocumentUploadWidget(
                    onFileUploaded: (String path) {
                      setState(() {
                        tempSelectedFile = File(path);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (tempSelectedFile != null) {
                  onSave(tempSelectedFile!.path);
                }
                Navigator.pop(ctx);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
