import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../Applications/models/company_model.dart';
import '../../../../Applications/models/user_model.dart';
import 'SkillAddCard.dart';

class SkillDialogContent extends StatefulWidget {
  @override
  _SkillDialogContentState createState() => _SkillDialogContentState();
}

class _SkillDialogContentState extends State<SkillDialogContent> {
  List<Map<String, dynamic>> skills = [];
  int cardCounter = 0;

  @override
  void initState() {
    super.initState();
    _addSkillCard(); // Add initial skill card
  }

  void _addSkillCard() {
    setState(() {
      skills.add({
        'skill': '',
        'level': 0,
        'key': UniqueKey(),
      });
    });
  }

  void _removeSkillCard(int index) {
    setState(() {
      skills.removeAt(index);
    });
  }

  void _updateSkill(String skill, int level, int index) {
    setState(() {
      skills[index]['skill'] = skill;
      skills[index]['level'] = level;
    });
  }

  void _saveSkills() {
    final entries = skills.map((s) => SkillEntry(skill: s['skill'], level: s['level'])).toList();
    Navigator.of(context).pop(entries); // Return the list to the caller
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...skills.asMap().entries.map((entry) {
              int index = entry.key;
              var item = entry.value;
              return SkillAddCard(
                key: item['key'],
                cardIndex: index,
                onRemove: () => _removeSkillCard(index),
                onSkillChanged: _updateSkill,
              );
            }),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: JSizes.md , horizontal: JSizes.md)
                  ),
                  onPressed: _saveSkills,
                  icon: const Icon(Icons.save),
                  label: const Text("Save"),
                ),
                OutlinedButton.icon(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: JSizes.md , horizontal: JSizes.md)
                  ),
                  onPressed: _addSkillCard,
                  icon: const Icon(Icons.add),
                  label: const Text("Add Skill"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
