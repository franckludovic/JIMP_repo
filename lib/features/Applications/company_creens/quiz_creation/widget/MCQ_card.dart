import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../controllers/quizfull_controller_builder.dart';
import '../../../models/quizModel.dart';

class McqQuestionCard extends StatefulWidget {
  final VoidCallback onRemove;
  final ValueChanged<QuizQuestion?> onChanged;

  const McqQuestionCard({
    super.key,
    required this.onRemove,
    required this.onChanged,
  });

  @override
  State<McqQuestionCard> createState() => McqQuestionCardState();
}

class McqQuestionCardState extends State<McqQuestionCard> {
  final TextEditingController _questionController = TextEditingController();
  final controller = Get.put(QuizBuilderController());
  final List<TextEditingController> _optionControllers = List.generate(
    4, (index) => TextEditingController(),
  );
  final List<bool> _isOptionCorrect = [false, false, false, false];

  @override
  void initState() {
    super.initState();
    _addListeners();
  }

  void _addListeners() {
    void notifyParent() => widget.onChanged(getQuestionData());

    _questionController.addListener(notifyParent);
    for (var controller in _optionControllers) {
      controller.addListener(notifyParent);
    }
  }

  void _handleCheckboxChanged(int index, bool? value) {
    setState(() {
      _isOptionCorrect[index] = value ?? false;
    });
    widget.onChanged(getQuestionData());
  }

  QuizQuestion? getQuestionData() {
    final questionText = _questionController.text.trim();
    final options = _optionControllers.map((c) => c.text.trim()).toList();
    final correctAnswers = _isOptionCorrect
        .asMap()
        .entries
        .where((e) => e.value)
        .map((e) => options[e.key])
        .toList();

    if (questionText.isEmpty ||
        options.any((o) => o.isEmpty) ||
        correctAnswers.isEmpty) {
      return null;
    }

    return QuizQuestion(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      questionText: questionText,
      type: QuestionType.multipleChoice,
      options: options,
      correctAnswers: correctAnswers,
      points: 1,
    );
  }

  @override
  void dispose() {
    _questionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
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
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Multiple Choice Question",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: widget.onRemove,
                ),
              ],
            ),
            const SizedBox(height: 12),

            const Text("Question Text", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            TextField(
              controller: _questionController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter question text",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey.shade800,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            ...List.generate(4, (index) => _buildOptionField(index)),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionField(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Option ${index + 1}", style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _optionControllers[index],
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Enter option text",
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.grey.shade800,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Checkbox(
                value: _isOptionCorrect[index],
                onChanged: (value) => _handleCheckboxChanged(index, value),
                checkColor: Colors.white,
                activeColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
