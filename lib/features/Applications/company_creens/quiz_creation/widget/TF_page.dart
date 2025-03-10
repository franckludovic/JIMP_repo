import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import 'TF_card.dart';


class TrueFalseTabPage extends StatefulWidget {
  const TrueFalseTabPage({super.key});

  @override
  State<TrueFalseTabPage> createState() => _TrueFalseTabPageState();
}

class _TrueFalseTabPageState extends State<TrueFalseTabPage> {
  final List<Widget> _tfQuestions = [];

  @override
  void initState() {
    super.initState();
    // Initialize with 5 questions by default
    for (int i = 0; i < 5; i++) {
      _tfQuestions.add(_buildQuestionCard(i + 1));
    }
  }

  Widget _buildQuestionCard(int index) {
    return TfQuestionCard(
      questionIndex: index,
      onRemove: () => _removeQuestion(index),
    );
  }

  void _addQuestion() {
    setState(() {
      int nextIndex = _tfQuestions.length + 1;
      _tfQuestions.add(_buildQuestionCard(nextIndex));
    });
  }

  void _removeQuestion(int index) {
    if (_tfQuestions.length <= 1) {
      // Optionally prevent removal if there's only one question left
      return;
    }
    setState(() {
      _tfQuestions.removeAt(index - 1);
    });
  }

  void _submitQuestions() {
    // Process or validate the T/F questions
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("True/False questions submitted!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Scrollable list of T/F question cards
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _tfQuestions,
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
