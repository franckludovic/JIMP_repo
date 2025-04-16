import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/TF_card.dart';
import 'package:project_bc_tuto/features/Applications/controllers/posting_controller.dart';
import 'package:project_bc_tuto/services/quiz_services.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/quizfull_controller_builder.dart';
import '../../../models/quizModel.dart';

class TrueFalseTabPage extends StatefulWidget {
  const TrueFalseTabPage({super.key});

  @override
  State<TrueFalseTabPage> createState() => _TrueFalseTabPageState();
}

class _TrueFalseTabPageState extends State<TrueFalseTabPage> {
  // Controllers for quiz metadata
  final TextEditingController _quizTitleController = TextEditingController();
  final QuizBuilderController _quizController = QuizBuilderController.instance;


  // List to store the current state (QuizQuestion) for each T/F question card.
  List<QuizQuestion?> _questions = [];

  // Get QuizService instance
  final QuizService _quizService = Get.find();

  @override
  void initState() {
    super.initState();
    // Initialize with 5 empty questions.
    _questions = List.generate(5, (_) => null);
  }

  /// Builds a True/False question card for a given index.
  Widget _buildQuestionCard(int index) {
    return TfQuestionCard(
      questionIndex: index,
      onRemove: () => _removeQuestion(index),
      onChanged: (QuizQuestion? updatedQuestion) {
        setState(() {
          _questions[index] = updatedQuestion;
        });
        debugPrint("Question $index updated: $updatedQuestion");
      },
    );
  }

  /// Adds a new empty question card.
  void _addQuestion() {
    setState(() {
      _questions.add(null);
    });
  }

  /// Removes the question at the specified index.
  void _removeQuestion(int index) {
    if (_questions.length <= 1) {
      // Prevent removal if there's only one question left.
      return;
    }
    setState(() {
      _questions.removeAt(index);
    });
  }

  /// Resets the quiz form.
  void _resetForm() {
    setState(() {
      _quizTitleController.clear();
      _questions.clear();
      _questions = List.generate(5, (_) => null);
    });
  }

  /// Validates and submits the True/False quiz.
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
      color: Colors.black87, // Set your background color here.
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
