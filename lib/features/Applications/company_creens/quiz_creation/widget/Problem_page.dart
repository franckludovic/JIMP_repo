import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/services/quiz_services.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../controllers/posting_controller.dart';
import '../../../controllers/quizfull_controller_builder.dart';
import '../../../models/quizModel.dart';
import 'problem_card.dart';

class ProblemSolvingTabPage extends StatefulWidget {
// Optional

  const ProblemSolvingTabPage({
    super.key,
  });

  @override
  State<ProblemSolvingTabPage> createState() => _ProblemSolvingTabPageState();
}

class _ProblemSolvingTabPageState extends State<ProblemSolvingTabPage> {
  final QuizService _quizService = Get.find();
  final QuizBuilderController _quizController = QuizBuilderController.instance;


  final TextEditingController _quizTitleController = TextEditingController();

  final List<QuizQuestion?> _questions = [];

  @override
  void initState() {
    super.initState();
    _addQuestion(); // Start with 1 question
  }

  void _addQuestion() {
    setState(() {
      _questions.add(null);
    });
  }

  void _removeQuestion(int index) {
    if (_questions.length <= 1) return;
    setState(() {
      _questions.removeAt(index);
    });
  }

  void _handleQuestionChange(int index, QuizQuestion? question) {
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
      _quizTitleController.clear();
      _questions.clear();
      _addQuestion();
    });
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
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return ProblemSolvingCard(
                    questionIndex: index + 1,
                    onRemove: () => _removeQuestion(index),
                    onChanged: (question) => _handleQuestionChange(index, question),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
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
                  child: const Text("Submit Quiz"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
