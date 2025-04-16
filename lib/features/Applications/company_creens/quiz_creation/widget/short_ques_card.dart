import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../models/quizModel.dart';

class ShortAnswerCard extends StatefulWidget {
  final int questionIndex;
  final VoidCallback onRemove;
  final ValueChanged<QuizQuestion?> onChanged;

  const ShortAnswerCard({
    super.key,
    required this.questionIndex,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  State<ShortAnswerCard> createState() => _ShortAnswerCardState();
}

class _ShortAnswerCardState extends State<ShortAnswerCard> {
  final TextEditingController _questionController = TextEditingController();
  final List<TextEditingController> _answerControllers = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  void _addListeners() {
    void notifyParent() => widget.onChanged(getQuestionData());
    _questionController.addListener(notifyParent);
    for (var controller in _answerControllers) {
      controller.addListener(notifyParent);
    }
  }

  /// Adds a new answer field and attaches the listener.
  void _addAnswerField() {
    setState(() {
      final newController = TextEditingController();
      newController.addListener(() => widget.onChanged(getQuestionData()));
      _answerControllers.add(newController);
    });
  }

  /// Removes an answer field if more than one exists.
  void _removeAnswerField(int index) {
    if (_answerControllers.length > 1) {
      setState(() {
        _answerControllers.removeAt(index);
        widget.onChanged(getQuestionData());
      });
    }
  }

  /// Builds a QuizQuestion object from the current inputs.
  /// Returns null if any required field is empty.
  QuizQuestion? getQuestionData() {
    final questionText = _questionController.text.trim();
    // Collect all answer variants.
    final answers = _answerControllers.map((controller) => controller.text.trim()).toList();

    if (questionText.isEmpty || answers.any((a) => a.isEmpty)) {
      return null;
    }

    // Create a unique id based on index and timestamp.
    return QuizQuestion(
      id: '${widget.questionIndex}_${DateTime.now().millisecondsSinceEpoch}',
      questionText: questionText,
      type: QuestionType.shortAnswer,
      correctAnswers: answers,
      points: 1,
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Adopt color scheme from theme
    final theme = Theme.of(context);
    final cardColor = theme.cardColor;
    final hintStyle = theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor);
    final textStyle = theme.textTheme.bodySmall;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with question index and remove button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Question ${widget.questionIndex + 1}",
                  style: textStyle?.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: JColors.error),
                  onPressed: widget.onRemove,
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Input for question text.
            TextField(
              controller: _questionController,
              style: textStyle,
              decoration: InputDecoration(
                hintText: "Enter question text",
                hintStyle: hintStyle,
                filled: true,
                fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey.shade800,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Build answer fields.
            ...List.generate(_answerControllers.length, (index) => _buildAnswerField(index, theme, hintStyle, textStyle)),
            const SizedBox(height: 8),
            // Button to add new answer field.
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add, size: 18),
                label: const Text("Add Answer Variation", style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),),
                onPressed: _addAnswerField,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: JSizes.md, vertical: JSizes.md * 0.6),
                  backgroundColor: theme.primaryColor,
                  foregroundColor: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds a single answer text field with a remove button.
  Widget _buildAnswerField(int index, ThemeData theme, TextStyle? hintStyle, TextStyle? textStyle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _answerControllers[index],
              style: textStyle,
              decoration: InputDecoration(
                hintText: "Acceptable answer ${index + 1}",
                hintStyle: hintStyle,
                filled: true,
                fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey.shade800,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove_circle, color: JColors.error),
            onPressed: () => _removeAnswerField(index),
          ),
        ],
      ),
    );
  }
}
