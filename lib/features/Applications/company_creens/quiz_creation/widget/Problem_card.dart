
import 'package:flutter/material.dart';

class ProblemSolvingCard extends StatefulWidget {
  final int questionIndex;
  final VoidCallback onRemove;

  const ProblemSolvingCard({
    super.key,
    required this.questionIndex,
    required this.onRemove,
  });

  @override
  State<ProblemSolvingCard> createState() => _ProblemSolvingCardState();
}

class _ProblemSolvingCardState extends State<ProblemSolvingCard> {
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

            // Question text field (min 5 lines, max 20)
            TextField(
              controller: _questionController,
              minLines: 5,
              maxLines: 20,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter problem statement (5 - 20 lines)",
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

            // Answer text field (min 10 lines, max 20)
            TextField(
              controller: _answerController,
              minLines: 15,
              maxLines: 30,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter expected solution (10 - 20 lines)",
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

            // Remove button
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
