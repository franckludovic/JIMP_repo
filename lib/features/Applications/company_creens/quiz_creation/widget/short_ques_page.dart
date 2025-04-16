import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/short_ques_card.dart';
import 'package:project_bc_tuto/features/Applications/controllers/posting_controller.dart';
import '../../../../../services/quiz_services.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/quizfull_controller_builder.dart';
import '../../../models/quizModel.dart';


class ShortAnswerTabPage extends StatefulWidget {
  const ShortAnswerTabPage({super.key});

  @override
  State<ShortAnswerTabPage> createState() => _ShortAnswerTabPageState();
}

class _ShortAnswerTabPageState extends State<ShortAnswerTabPage> {
  // Controllers for quiz details
  final TextEditingController _quizTitleController = TextEditingController();
  final QuizBuilderController _quizController = QuizBuilderController.instance;


  // List to store the current state of each quiz question.
  List<QuizQuestion?> _questions = [];

  // Get your QuizService instance from GetX
  final QuizService _quizService = Get.find();

  @override
  void initState() {
    super.initState();
    // Initialize with 5 empty questions.
    _questions = List.generate(5, (_) => null);
  }

  /// Builds a ShortAnswerCard for a given index.
  Widget _buildQuestionCard(int index) {
    return ShortAnswerCard(
      questionIndex: index,
      onRemove: () => _removeQuestion(index),
      onChanged: (question) {
        setState(() {
          _questions[index] = question;
        });
      },
    );
  }

  /// Adds a new question card.
  void _addQuestion() {
    setState(() {
      _questions.add(null);
    });
  }

  /// Removes the question at the specified index.
  void _removeQuestion(int index) {
    if (_questions.length <= 1) {
      // Prevent removal if there's only one question.
      return;
    }
    setState(() {
      _questions.removeAt(index);
    });
  }

  /// Resets the form by clearing the quiz title and questions.
  void _resetForm() {
    setState(() {
      _questions.clear();
      _quizTitleController.clear();
      _questions = List.generate(5, (_) => null);
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


  @override
  Widget build(BuildContext context) {
    return Container(
      // Uses the current theme's background color.
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _questions.length,
                itemBuilder: (context, index) => _buildQuestionCard(index),
              ),
            ),
            const SizedBox(height: 16),
            // Row with "Add Question" and "Submit" buttons.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(JSizes.md),
                  ),
                  onPressed: _addQuestion,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Question"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(JSizes.md),
                  ),
                  onPressed: _submitQuestions,
                  child: const Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
