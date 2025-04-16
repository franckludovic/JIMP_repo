import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Custom popup widget to allow entering a percentage value
class CustomPopup extends StatelessWidget {
  final String title;
  final String hintText;
  final Function(String) onSave;

  const CustomPopup({
    Key? key,
    required this.title,
    required this.hintText,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Controller for text input
    final TextEditingController controller = TextEditingController();
    return AlertDialog(
      title: Text(title),
      content: TextField(
        controller: controller,
        // Allow decimals in the input
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(hintText: hintText),
      ),
      actions: [
        // Close the popup without doing anything
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel'),
        ),
        // Save button returns the value to the callback
        TextButton(
          onPressed: () {
            // Return the entered text using onSave callback
            onSave(controller.text);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

/// Function to show the popup and update the skill level in Firestore.
///
/// Parameters:
/// - [candidateId]: The document ID for the candidate in Firestore.
/// - [skillName]: The name of the skill to update (this must match the `"Skill"` field in Firestore).
Future<void> showSkillUpdatePopup({
  required String candidateId,
  required String skillName,
}) async {
  // Show the custom popup and wait for a result.
  final String? result = await Get.dialog<String>(
    CustomPopup(
      title: 'Skill Percentage',
      hintText: 'Enter new percentage (0 - 100)...',
      onSave: (value) {
        // Return the value entered
        Get.back(result: value);
      },
    ),
  );

  if (result != null) {
    // Try to parse the input as a double. This allows values such as "64" or "85.5".
    double? percentage = double.tryParse(result);
    if (percentage == null || percentage < 0 || percentage > 100) {
      Get.snackbar(
        'Invalid Input',
        'Please enter a valid percentage between 0 and 100.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Convert percentage to a level from 1 to 5.
    // For example, 0-20% becomes 1, 21-40% becomes 2, etc.
    int newLevel = (percentage / 20).ceil().clamp(1, 5);

    try {
      // Reference to the candidate's document in Firestore.
      DocumentReference docRef =
      FirebaseFirestore.instance.collection('candidates').doc(candidateId);

      // Read the current document.
      DocumentSnapshot snapshot = await docRef.get();
      if (snapshot.exists) {
        // Retrieve the Skills array. If it doesn't exist, use an empty list.
        List skills = snapshot.get('Skills') ?? [];
        bool skillFound = false;

        // Look for the skill with the specified name.
        for (int i = 0; i < skills.length; i++) {
          if (skills[i]['Skill'] == skillName) {
            // Update the level.
            skills[i]['Level'] = newLevel;
            skillFound = true;
            break;
          }
        }

        // Optionally, add the skill if it does not exist.
        if (!skillFound) {
          skills.add({'Skill': skillName, 'Level': newLevel});
        }

        // Write the updated array back to Firestore.
        await docRef.update({'Skills': skills});

        Get.snackbar(
          'Success',
          'Skill level updated successfully!',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Error',
          'Candidate not found.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update skill: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
