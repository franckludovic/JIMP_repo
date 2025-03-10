class ChatMessage {
  final String id;
  final String text;
  final DateTime timestamp;
  final bool isSender;
  final List<ChatAttachment>? attachments;

  ChatMessage({
    required this.id,
    required this.text,
    required this.timestamp,
    required this.isSender,
    this.attachments,
  });
}

class ChatAttachment {
  final String type; // "file", "image", "audio", "link"
  final String url;
  ChatAttachment({required this.type, required this.url});
}
