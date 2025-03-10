import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

class TfQuestionCard extends StatefulWidget {
  final int questionIndex;
  final VoidCallback onRemove;

  const TfQuestionCard({
    super.key,
    required this.questionIndex,
    required this.onRemove,
  });

  @override
  State<TfQuestionCard> createState() => _TfQuestionCardState();
}

class _TfQuestionCardState extends State<TfQuestionCard> {
  final TextEditingController _questionController = TextEditingController();

  // Track selected answer: "true" or "false" (null if none selected)
  String? _selectedAnswer;

  void _selectAnswer(String answer) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  @override
  Widget build(BuildContext context) {

    final dark = JHelperFunctions.isDarkMode(context);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: dark ? Colors.grey.shade900 : JColors.grey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question label
            Text(
              "Question ${widget.questionIndex}",
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),

            // Question text field
            TextField(
              controller: _questionController,
              maxLines: 1,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter question",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey.shade800,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: JSizes.spaceBtwSections),

            // True / False buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnswerButton("TRUE"),
                const SizedBox(width: JSizes.spaceBtwSections),
                _buildAnswerButton("FALSE"),
              ],
            ),


            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: widget.onRemove,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Builds either the "True" or "False" button with highlight if selected
  Widget _buildAnswerButton(String label) {
    final bool isSelected = (_selectedAnswer == label.toLowerCase());
    return ElevatedButton(
      onPressed: () => _selectAnswer(label.toLowerCase()),
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: isSelected ? JColors.primary : Colors.grey.shade700,),
        padding: EdgeInsets.symmetric(vertical: JSizes.md, horizontal: JSizes.xl),
        backgroundColor: isSelected ? JColors.primary : Colors.grey.shade700,
      ),
      child: Text(label, style: TextStyle(fontFamily: 'Poppins'),),
    );
  }
}
