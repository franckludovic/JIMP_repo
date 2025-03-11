import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';
import 'Problem_card.dart';


class ProblemSolvingTabPage extends StatefulWidget {
  const ProblemSolvingTabPage({super.key});

  @override
  State<ProblemSolvingTabPage> createState() => _ProblemSolvingTabPageState();
}

class _ProblemSolvingTabPageState extends State<ProblemSolvingTabPage> {
  final List<Widget> _psQuestions = [];

  @override
  void initState() {
    super.initState();
    // Initialize with 1 question by default
    _psQuestions.add(_buildQuestionCard(1));
  }

  Widget _buildQuestionCard(int index) {
    return ProblemSolvingCard(
      questionIndex: index,
      onRemove: () => _removeQuestion(index),
    );
  }

  void _addQuestion() {
    setState(() {
      int newIndex = _psQuestions.length + 1;
      _psQuestions.add(_buildQuestionCard(newIndex));
    });
  }

  void _removeQuestion(int index) {
    // Optionally ensure at least 1 question remains
    if (_psQuestions.length <= 1) return;

    setState(() {
      _psQuestions.removeAt(index - 1);
    });
  }

  void _submitQuestions() {
    // Process or validate the problem solving questions
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Problem solving questions submitted!")),
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
            // Scrollable list of problem solving question cards
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: _psQuestions,
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
