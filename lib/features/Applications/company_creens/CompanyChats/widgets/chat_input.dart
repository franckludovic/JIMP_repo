import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import the ImagePicker
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

class CustomChatInput extends StatelessWidget {
  const CustomChatInput({
    super.key,
    required this.textController,
    required this.onSendPressed,
    required this.focusNode,
    required this.onAttachmentSelected, // Change from optional to required
  });

  final TextEditingController textController;
  final VoidCallback onSendPressed;
  final FocusNode focusNode;
  final Function(String) onAttachmentSelected; // Update type to String

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.3 * 255).toInt()),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Wrap(
                      children: <Widget>[
                        ListTile(
                          leading: const Icon(Icons.image),
                          title: const Text('Image'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(); // Call the image picker method
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.insert_drive_file),
                          title: const Text('File'),
                          onTap: () {
                            Navigator.pop(context);
                            onAttachmentSelected('file');
                          },
                        ),
                        // Add Audio and Video options if needed
                      ],
                    ),
                  );
                },
              );
            },
          ),
          Expanded(
            child: TextField(
              controller: textController,
              focusNode: focusNode,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ),
          JRoundedContainer(
            backgroundColor: JColors.white,
            radius: 60,
            margin: EdgeInsets.only(left: 5),
            padding: EdgeInsets.all(3),
            child: IconButton(
              icon: const Icon(Icons.send),
              color: JColors.primary,
              onPressed: () {
                onSendPressed();
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Send the image path to the onAttachmentSelected callback
      onAttachmentSelected(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }
}