import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/short_ques_card.dart';

import '../../../../../utils/constants/sizes.dart';


class ShortAnswerTabPage extends StatefulWidget {
  const ShortAnswerTabPage({super.key});

  @override
  State<ShortAnswerTabPage> createState() => _ShortAnswerTabPageState();
}

class _ShortAnswerTabPageState extends State<ShortAnswerTabPage> {
  final List<Widget> _shortAnswerQuestions = [];

  @override
  void initState() {
    super.initState();
    // Initialize with 5 questions
    for (int i = 0; i < 5; i++) {
      _shortAnswerQuestions.add(_buildQuestionCard(i + 1));
    }
  }

  Widget _buildQuestionCard(int index) {
    return ShortAnswerCard(
      questionIndex: index,
      onRemove: () => _removeQuestion(index),
    );
  }

  void _addQuestion() {
    setState(() {
      int newIndex = _shortAnswerQuestions.length + 1;
      _shortAnswerQuestions.add(_buildQuestionCard(newIndex));
    });
  }

  void _removeQuestion(int index) {
    if (_shortAnswerQuestions.length <= 1) {
      // Optionally prevent removal if there's only one
      return;
    }
    setState(() {
      // Index in the list is (index - 1) if we used (i + 1) above
      _shortAnswerQuestions.removeAt(index - 1);
    });
  }

  void _submitQuestions() {
    // Process or validate the short answer questions
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Short answer questions submitted!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87, // or your background color
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Scrollable list of short-answer question cards
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _shortAnswerQuestions,
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
