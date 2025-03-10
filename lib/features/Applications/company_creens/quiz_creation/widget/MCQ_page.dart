import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import 'MCQ_card.dart';


class MultipleChoiceTabPage extends StatefulWidget {
  const MultipleChoiceTabPage({super.key});

  @override
  State<MultipleChoiceTabPage> createState() => _MultipleChoiceTabPageState();
}

class _MultipleChoiceTabPageState extends State<MultipleChoiceTabPage> {
  // We’ll store each question card in a list.
  final List<Widget> _mcqQuestions = [];

  @override
  void initState() {
    super.initState();
    // Initialize with 5 questions
    for (int i = 0; i < 5; i++) {
      _mcqQuestions.add(_buildQuestionCard(i));
    }
  }

  Widget _buildQuestionCard(int index) {
    return McqQuestionCard(
      questionIndex: index,
      onRemove: () => _removeQuestion(index),
    );
  }

  void _addQuestion() {
    setState(() {
      int newIndex = _mcqQuestions.length;
      _mcqQuestions.add(_buildQuestionCard(newIndex));
    });
  }

  void _removeQuestion(int index) {
    if (_mcqQuestions.length <= 1) {
      // optional: do not remove if there's only one
      return;
    }
    setState(() {
      _mcqQuestions.removeAt(index);
    });
  }

  void _submitQuestions() {
    // Collect data from each McqQuestionCard
    // For now, just show a snackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("MCQ questions submitted!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87, // or your background
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // The list of question cards
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _mcqQuestions,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Row with "Add Question" & "Submit"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(JSizes.md),
                  ),
                  onPressed: _addQuestion,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Question"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(JSizes.md),
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
