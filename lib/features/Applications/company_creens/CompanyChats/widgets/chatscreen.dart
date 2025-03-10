import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mime/mime.dart';
import 'chat_input.dart';


class ChatScreen extends StatefulWidget {
  final bool isGroupChat;
  const ChatScreen({super.key, this.isGroupChat = false});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<types.Message> _messages = [];
  final types.User _currentUser = const types.User(id: 'user-1');

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  // Modified _handleSendPressed to create PartialText
  void _handleSendPressed() {
    final text = _textController.text;
    if (text.isNotEmpty) {
      final partialText = types.PartialText(text: text); // Create PartialText
      _handleSend(partialText); // Call the actual send logic
    }
  }


  // Actual send logic, now accepts PartialText
  void _handleSend(types.PartialText partialText) {
    final text = partialText.text;
    final textMessage = types.TextMessage(
      author: _currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
    );
    _addMessage(textMessage);
    _textController.clear();
    _focusNode.unfocus();
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 1440,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );

      _addMessage(message);
    }
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.isNotEmpty) {
      final filePath = result.files.single.path;
      final file = File(filePath!);
      final size = await file.length();
      final mimeType = lookupMimeType(filePath);

      final message = types.FileMessage(
        author: _currentUser,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        mimeType: mimeType,
        name: result.files.single.name,
        size: size,
        uri: filePath,
      );

      _addMessage(message);
    }
  }

  void _handleAttachmentSelected(String type) {
    switch (type) {
      case 'image':
        _handleImageSelection();
        break;
      case 'file':
        _handleFileSelection();
        break;
      case 'audio':
        Get.snackbar("Not implemented", "Audio recording feature");
        break;
      case 'video':
        Get.snackbar("Not implemented", "Video recording feature");
        break;
      default:
        Get.snackbar("Attachment Selected", "Type: $type");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isGroupChat ? "Group Chat" : "Chat"),
      ),
      body: Stack(  // Use a Stack
        children: [
          Chat(  // The Chat widget goes in the background
            messages: _messages,
            user: _currentUser,
            onSendPressed: (types.PartialText partialText) {
              // This is intentionally empty, the input is handled by CustomChatInput
            },
          ),
          Positioned(  // Position CustomChatInput on top
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomChatInput(
              textController: _textController,
              focusNode: _focusNode,
              onSendPressed: _handleSendPressed,
              onAttachmentSelected: _handleAttachmentSelected,
            ),
          ),
        ],
      ),
    );
  }
}