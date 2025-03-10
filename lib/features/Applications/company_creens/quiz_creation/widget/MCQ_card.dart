import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class McqQuestionCard extends StatefulWidget {
  final int questionIndex;
  final VoidCallback onRemove; // In case you want a remove button

  const McqQuestionCard({
    super.key,
    required this.questionIndex,
    required this.onRemove,
  });

  @override
  State<McqQuestionCard> createState() => _McqQuestionCardState();
}

class _McqQuestionCardState extends State<McqQuestionCard> {
  final TextEditingController _questionController = TextEditingController();

  // Four option text controllers
  final List<TextEditingController> _optionControllers = List.generate(
    4,
        (index) => TextEditingController(),
  );

  // Track which option is correct. If -1, none is correct.
  int _correctOptionIndex = -1;

  void _handleCheckboxChanged(int index) {
    setState(() {
      _correctOptionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey.shade900, // or your theme color
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question label
            const Text(
              "Question Text",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 4),
            // Question text field
            TextField(
              controller: _questionController,
              maxLines: 1,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter question text",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.grey.shade800,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Option fields
            for (int i = 0; i < 4; i++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Option label (e.g., "Option 1")
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Option ${i + 1}",
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(height: 4),
                        TextField(
                          controller: _optionControllers[i],
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Enter answer option",
                            hintStyle: const TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.grey.shade800,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Checkbox to mark correct answer
                  Container(
                    padding: EdgeInsets.only(top: JSizes.lg),
                    child: Checkbox(
                      value: _correctOptionIndex == i,
                      onChanged: (bool? value) {
                        _handleCheckboxChanged(i);
                      },
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],

            // Optional remove button if you want to remove this card
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
}
