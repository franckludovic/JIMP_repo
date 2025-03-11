import 'package:flutter/material.dart';

/// Model to hold each custom question's data.
class CustomQuestion {
  String question;
  String answer;
  String hint;
  bool isExpanded;

  CustomQuestion({
    this.question = "",
    this.answer = "",
    this.hint = "",
    this.isExpanded = false,
  });
}

/// The CustomQuestionsTabPage: a creative quiz builder for custom questions.
class CustomQuestionsTabPage extends StatefulWidget {
  const CustomQuestionsTabPage({super.key});

  @override
  State<CustomQuestionsTabPage> createState() => _CustomQuestionsTabPageState();
}

class _CustomQuestionsTabPageState extends State<CustomQuestionsTabPage> {
  // List to store custom questions.
  final List<CustomQuestion> _questions = [];

  @override
  void initState() {
    super.initState();
    // Start with one default custom question.
    _questions.add(CustomQuestion());
  }

  /// Adds a new custom question.
  void _addQuestion() {
    setState(() {
      _questions.add(CustomQuestion());
    });
  }

  /// Removes a question at the given index.
  void _removeQuestion(int index) {
    if (_questions.length <= 1) return; // Ensure at least one remains.
    setState(() {
      _questions.removeAt(index);
    });
  }

  /// Handles submission of the custom quiz.
  void _submitQuiz() {
    // Process the custom questions.
    for (int i = 0; i < _questions.length; i++) {
      final q = _questions[i];
      debugPrint("Question ${i + 1}: ${q.question}");
      debugPrint("Answer ${i + 1}: ${q.answer}");
      debugPrint("Hint ${i + 1}: ${q.hint}");
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Custom quiz submitted!")),
    );
  }

  /// Builds the individual custom question card as an ExpansionTile.
  Widget _buildQuestionCard(int index) {
    final questionData = _questions[index];
    return Container(
      key: ValueKey("custom_question_$index"),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        initiallyExpanded: questionData.isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            questionData.isExpanded = expanded;
          });
        },
        title: Text(
          questionData.question.isEmpty
              ? "Custom Question ${index + 1}"
              : questionData.question,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => _removeQuestion(index),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Question input field.
                TextField(
                  onChanged: (value) {
                    setState(() {
                      questionData.question = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Enter Question",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                // Answer input field.
                TextField(
                  onChanged: (value) {
                    setState(() {
                      questionData.answer = value;
                    });
                  },
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: "Enter Answer",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                // Optional instructions/hint field.
                TextField(
                  onChanged: (value) {
                    setState(() {
                      questionData.hint = value;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Additional Instructions (Optional)",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      body: SafeArea(
        child: Column(
          children: [
            // Reorderable list of custom question cards.
            Expanded(
              child: ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) {
                      newIndex -= 1;
                    }
                    final item = _questions.removeAt(oldIndex);
                    _questions.insert(newIndex, item);
                  });
                },
                children: [
                  for (int i = 0; i < _questions.length; i++)
                    _buildQuestionCard(i),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Row with "Add Question" and "Submit" buttons.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: _addQuestion,
                    icon: const Icon(Icons.add),
                    label: const Text("Add Question"),
                  ),
                  ElevatedButton(
                    onPressed: _submitQuiz,
                    child: const Text("Submit Quiz"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
