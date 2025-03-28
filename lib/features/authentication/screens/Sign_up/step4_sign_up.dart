import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/step5_sign_up.dart';

import '../../../../common/widgets/sign_upButtons/signUpNavButtons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../compamy_screens/sign_up/widget/step_indicator.dart';

class CandidateRegisterScreen4 extends StatefulWidget {
  const CandidateRegisterScreen4({super.key});

  @override
  _CandidateRegisterScreen4State createState() => _CandidateRegisterScreen4State();
}

class _CandidateRegisterScreen4State extends State<CandidateRegisterScreen4> {
  // List to hold languages with proficiency
  List<LanguageEntry> languages = [];
  int currentStep = 3;

  // List to hold hobbies
  List<String> hobbies = [];

  @override
  void initState() {
    super.initState();
    // Optionally, start with one language row and one hobby row
    languages.add(LanguageEntry(language: '', proficiency: 1));
    hobbies.add('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(title: Text('Language and Hobbies', style: Theme.of(context).textTheme.headlineMedium,) ,),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ---------- LANGUAGES SECTION ----------
            _buildLanguagesSection(),

            const SizedBox(height: 32),

            // ---------- HOBBIES SECTION ----------
            _buildHobbiesSection(),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          SignUpNavigationButtons(onPressed:() => Get.to(() => CandidateRegisterScreen5()) ),

          Padding(
            padding: const EdgeInsets.only(bottom: JSizes.spaceBtwSections, top: JSizes.md),
            child: Positioned(
                bottom: JDeviceUtils.getBottomNavigationBarHeight(),
                left: 0,
                right: 0,
                child: StepIndicator(currentIndex: currentStep, totalSteps: 5)
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------
  //   WIDGET: Languages Section
  // -----------------------------------
  Widget _buildLanguagesSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Languages',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Build a list of language fields
            Column(
              children: List.generate(languages.length, (index) {
                return _buildLanguageRow(index);
              }),
            ),
            const SizedBox(height: 16),
            // "Add Language" button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: JSizes.sm, vertical: JSizes.md)
                  ),
                  onPressed: () {
                    setState(() {
                      languages.add(LanguageEntry(language: '', proficiency: 1));
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Language'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Build each row for a language
  Widget _buildLanguageRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First row: TextField + Remove button
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter a Language',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: languages[index].language,
                  onChanged: (value) {
                    setState(() {
                      languages[index].language = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () {
                  setState(() {
                    languages.removeAt(index);
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Second row: Proficiency level
          Row(
            children: [
              const Text('Proficiency: '),
              _buildProficiencyRadio(index, 1),
              _buildProficiencyRadio(index, 2),
              _buildProficiencyRadio(index, 3),
            ],
          ),
        ],
      ),
    );
  }


  // Single Radio button for proficiency
  Widget _buildProficiencyRadio(int index, int value) {
    return Row(
      children: [
        Radio<int>(
          value: value,
          groupValue: languages[index].proficiency,
          onChanged: (selected) {
            setState(() {
              languages[index].proficiency = selected ?? 1;
            });
          },
        ),
        Text('$value'),
      ],
    );
  }

  // -----------------------------------
  //   WIDGET: Hobbies Section
  // -----------------------------------
  Widget _buildHobbiesSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hobbies',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Build a list of hobby fields
            Column(
              children: List.generate(hobbies.length, (index) {
                return _buildHobbyRow(index);
              }),
            ),
            const SizedBox(height: 16),
            // "Add Hobby" button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: JSizes.sm, vertical: JSizes.md)
                  ),
                  onPressed: () {
                    setState(() {
                      hobbies.add('');
                    });
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Hobby'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Build each row for a hobby
  Widget _buildHobbyRow(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          // Text Field for Hobby
          Expanded(
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: 'Enter a Hobby',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  hobbies[index] = value;
                });
              },
              initialValue: hobbies[index],
            ),
          ),
          const SizedBox(width: 8),
          // Remove this hobby row
          IconButton(
            icon: const Icon(Icons.remove_circle, color: Colors.red),
            onPressed: () {
              setState(() {
                hobbies.removeAt(index);
              });
            },
          ),
        ],
      ),
    );
  }
}


class LanguageEntry {
  String language;
  int proficiency;

  LanguageEntry({
    required this.language,
    required this.proficiency,
  });
}
