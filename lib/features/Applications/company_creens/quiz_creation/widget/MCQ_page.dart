import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/services/quiz_services.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../controllers/posting_controller.dart';
import '../../../controllers/quizfull_controller_builder.dart';
import '../../../models/quizModel.dart';
import 'MCQ_card.dart';

class MultipleChoiceTabPage extends StatefulWidget {
  const MultipleChoiceTabPage({super.key});

  @override
  State<MultipleChoiceTabPage> createState() => _MultipleChoiceTabPageState();
}

class _MultipleChoiceTabPageState extends State<MultipleChoiceTabPage> {
  final List<GlobalKey<McqQuestionCardState>> _questionKeys = [];
  final QuizBuilderController _quizController = QuizBuilderController.instance;
  final controller = Get.put(QuizBuilderController());

  final QuizService _quizService = Get.find();
  final TextEditingController _quizTitleController = TextEditingController();
  final List<QuizQuestion?> _questions = [];

  void _addQuestion() {
    setState(() {
      _questionKeys.add(GlobalKey<McqQuestionCardState>());
      _questions.add(null);
    });
  }

  void _removeQuestion(int index) {
    if (_questionKeys.length <= 1) return;
    setState(() {
      _questionKeys.removeAt(index);
      _questions.removeAt(index);
    });
  }

  void _handleQuestionUpdate(int index, QuizQuestion? question) {
    setState(() {
      _questions[index] = question;
    });
  }

  Future<void> _submitQuestions() async {

    if (_questions.any((q) => q == null)) {
      Get.snackbar('Error', 'Please complete all questions');
      return;
    }

    // Add each valid question to the central controller
    for (var question in _questions) {
      if (question != null) {
        _quizController.addQuestion(question);
      }
    }

    Get.snackbar('Success', 'Questions added to the quiz!');
    _resetForm();
  }



  void _resetForm() {
    setState(() {
      _questionKeys.clear();
      _questions.clear();
      _quizTitleController.clear();
      _addQuestion();
    });
  }

  @override
  void initState() {
    super.initState();
    _addQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _questionKeys.asMap().entries.map((entry) {
                    final index = entry.key;
                    return McqQuestionCard(
                      key: entry.value,
                      onRemove: () => _removeQuestion(index),
                      onChanged: (question) => _handleQuestionUpdate(index, question),
                    );
                  }).toList(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(JSizes.md)),
                  onPressed: _addQuestion,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Question"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(JSizes.md)),
                  onPressed: _submitQuestions,
                  child: const Text("Save Quiz"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
