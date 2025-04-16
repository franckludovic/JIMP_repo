import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/Applications/models/quizModel.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

class TfQuestionCard extends StatefulWidget {
  final int questionIndex;
  final VoidCallback onRemove;
  final ValueChanged<QuizQuestion?> onChanged;

  const TfQuestionCard({
    super.key,
    required this.questionIndex,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  State<TfQuestionCard> createState() => _TfQuestionCardState();
}

class _TfQuestionCardState extends State<TfQuestionCard> {
  final TextEditingController _questionController = TextEditingController();
  // Track selected answer: "true" or "false" (null if none selected)
  String? _selectedAnswer;

  @override
  void initState() {
    super.initState();
    _questionController.addListener(_notifyParent);
  }

  void _notifyParent() {
    widget.onChanged(getQuestionData());
  }

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
    });
    widget.onChanged(getQuestionData());
  }

  /// Builds a QuizQuestion object from current input data.
  /// Returns null if either question text or the selected answer is missing.
  QuizQuestion? getQuestionData() {
    final questionText = _questionController.text.trim();
    if (questionText.isEmpty || _selectedAnswer == null) {
      return null;
    }
    return QuizQuestion(
      id: '${widget.questionIndex}_${DateTime.now().millisecondsSinceEpoch}',
      questionText: questionText,
      type: QuestionType.trueFalse,
      correctAnswers: [_selectedAnswer!],
      points: 1,
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: dark ? Colors.grey.shade900 : JColors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question label
            Text(
              "Question ${widget.questionIndex}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            // Question text field
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
            const SizedBox(height: JSizes.spaceBtwSections),
            // True / False buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnswerButton("TRUE"),
                const SizedBox(width: JSizes.spaceBtwSections),
                _buildAnswerButton("FALSE"),
              ],
            ),
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

  /// Builds an elevated button for a given answer.
  /// Highlights the button if it's currently selected.
  Widget _buildAnswerButton(String label) {
    final bool isSelected = (_selectedAnswer == label.toLowerCase());
    return ElevatedButton(
      onPressed: () => _selectAnswer(label.toLowerCase()),
      style: ElevatedButton.styleFrom(
        side: BorderSide(
          color: isSelected ? JColors.primary : Colors.grey.shade700,
        ),
        padding: EdgeInsets.symmetric(
          vertical: JSizes.md,
          horizontal: JSizes.xl,
        ),
        backgroundColor: isSelected ? JColors.primary : Colors.grey.shade700,
      ),
      child: Text(
        label,
        style: const TextStyle(fontFamily: 'Poppins'),
      ),
    );
  }
}
