import 'package:flutter/material.dart';

class CustomChatInput extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onSendPressed;
  final FocusNode focusNode;
  final Function(String) onAttachmentSelected;

  const CustomChatInput({
    super.key,
    required this.textController,
    required this.onSendPressed,
    required this.focusNode,
    required this.onAttachmentSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {
              _showAttachmentOptions(context, onAttachmentSelected);
            },
          ),
          Expanded(
            child: TextField(
              controller: textController,
              focusNode: focusNode,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: onSendPressed,
          ),
        ],
      ),
    );
  }

  void _showAttachmentOptions(BuildContext context, Function(String) onAttachmentSelected) {
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
                  onAttachmentSelected('image');
                },
              ),
              ListTile(
                leading: const Icon(Icons.attach_file),
                title: const Text('File'),
                onTap: () {
                  Navigator.pop(context);
                  onAttachmentSelected('file');
                },
              ),
              ListTile(
                leading: const Icon(Icons.mic),
                title: const Text('Audio'),
                onTap: () {
                  Navigator.pop(context);
                  onAttachmentSelected('audio');
                },
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('Video'),
                onTap: () {
                  Navigator.pop(context);
                  onAttachmentSelected('video');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}