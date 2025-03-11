import 'package:flutter/material.dart';

class ShortAnswerCard extends StatefulWidget {
  final int questionIndex;
  final VoidCallback onRemove;

  const ShortAnswerCard({
    super.key,
    required this.questionIndex,
    required this.onRemove,
  });

  @override
  State<ShortAnswerCard> createState() => _ShortAnswerCardState();
}

class _ShortAnswerCardState extends State<ShortAnswerCard> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey.shade900,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question label
            Text(
              "Question ${widget.questionIndex}",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),

            // Single-line question text field
            TextField(
              controller: _questionController,
              maxLines: 1,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter question",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey.shade800,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Two-line answer text field
            TextField(
              controller: _answerController,
              maxLines: 2,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter answer (short answer)",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey.shade800,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Remove button (optional)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: widget.onRemove,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
