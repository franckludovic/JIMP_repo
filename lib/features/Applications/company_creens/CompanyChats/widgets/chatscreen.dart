import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatScreen extends StatefulWidget {
  final bool isGroupChat;
  const ChatScreen({super.key, this.isGroupChat = false});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // Dummy list of messages
  final List<types.Message> _messages = [];

  // Current user
  final types.User _currentUser = const types.User(id: 'user-1');


  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _currentUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, textMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isGroupChat ? "Group Chat" : "Chat"),
      ),
      body: Chat(
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _currentUser,
        // Customize the Chat widget as needed
      ),
    );
  }
}
