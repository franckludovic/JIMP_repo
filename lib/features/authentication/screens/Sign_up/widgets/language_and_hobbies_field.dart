import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

enum EntryType { language, hobby }

class LanguageAndHobbies extends StatefulWidget {
  final VoidCallback onRemove;

  const LanguageAndHobbies({super.key, required this.onRemove});

  @override
  _LanguageAndHobbiesState createState() => _LanguageAndHobbiesState();
}

class _LanguageAndHobbiesState extends State<LanguageAndHobbies> {
  int? selectedLevel;
  EntryType selectedType = EntryType.language;
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    final unselectedColor = dark ? JColors.grey : JColors.darkGrey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: JSizes.sm * 1.2, vertical: JSizes.sm),
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      decoration: BoxDecoration(
        border: Border.all(color: dark ? JColors.grey : JColors.black),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          // Type Selection Row
          Row(
            children: EntryType.values.map((type) {
              return Padding(
                padding: const EdgeInsets.only(right: JSizes.sm),
                child: ChoiceChip(
                  label: Text(type.toString().split('.').last),
                  selected: selectedType == type,
                  onSelected: (selected) {
                    setState(() {
                      selectedType = type;
                      if (type == EntryType.hobby) {
                        selectedLevel = null;
                      }
                    });
                  },
                  selectedColor: JColors.primary,
                  labelStyle: TextStyle(
                    color: selectedType == type
                        ? Colors.white
                        : (dark ? JColors.white : JColors.dark),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: JSizes.sm),

          // Input Row
          Row(
            children: [
              Flexible(
                flex: 10,
                child: Row(
                  children: [
                    const Icon(Iconsax.arrow_right_4, size: 30),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: selectedType == EntryType.language
                              ? "Enter a language"
                              : "Enter a hobby",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: widget.onRemove,
                icon: const Icon(Iconsax.trash, size: 30, color: Colors.red),
              )
            ],
          ),

          const Divider(thickness: 2),
          SizedBox(height: JSizes.md),

          // Conditional Level Selection
          Visibility(
            visible: selectedType == EntryType.language,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Proficiency Level:", style: Theme.of(context).textTheme.headlineSmall),
                    SizedBox(width: JSizes.sm),
                    // Level Buttons
                    for (int i = 1; i <= 5; i++) ...[
                      GestureDetector(
                        onTap: () => setState(() => selectedLevel = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          transform: selectedLevel == i
                              ? Matrix4.identity().scaled(1.1)
                              : Matrix4.identity(),
                          child: JRoundedContainer(
                            width: 30,
                            height: 30,
                            backgroundColor: selectedLevel == i
                                ? JColors.primary
                                : Colors.transparent,
                            borderColor: selectedLevel == i
                                ? JColors.primary
                                : unselectedColor,
                            showBorder: true,
                            borderWidth: 2,
                            child: Center(
                              child: Text(
                                "$i",
                                style: TextStyle(
                                  color: selectedLevel == i
                                      ? Colors.white
                                      : (dark ? JColors.darkGrey : JColors.darkerGrey),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: JSizes.md),
                    ],
                  ],
                ),
                SizedBox(height: JSizes.sm),
              ],
            ),
          ),
        ],
      ),
    );
  }
}