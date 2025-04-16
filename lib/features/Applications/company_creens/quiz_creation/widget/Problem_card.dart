import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/Applications/models/quizModel.dart';

class ProblemSolvingCard extends StatefulWidget {
  final int questionIndex;
  final VoidCallback onRemove;
  final ValueChanged<QuizQuestion?> onChanged;

  const ProblemSolvingCard({
    super.key,
    required this.questionIndex,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  State<ProblemSolvingCard> createState() => _ProblemSolvingCardState();
}

class _ProblemSolvingCardState extends State<ProblemSolvingCard> {
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _questionController.addListener(_notifyParent);
    _answerController.addListener(_notifyParent);
  }

  void _notifyParent() {
    final questionText = _questionController.text.trim();
    final solution = _answerController.text.trim();

    if (questionText.isNotEmpty && solution.isNotEmpty) {
      widget.onChanged(
        QuizQuestion(
          id: '${widget.questionIndex}_${DateTime.now().millisecondsSinceEpoch}',
          questionText: questionText,
          type: QuestionType.problemSolving,
          correctAnswers: [solution],
          solutionHint: solution,
          answerFormat: 'text',
          points: 1,
        ),
      );
    } else {
      widget.onChanged(null);
    }
  }

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

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
            Text(
              "Question ${widget.questionIndex}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
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
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
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
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
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
