import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class SkillAddCard extends StatefulWidget {
  final VoidCallback onRemove; // Callback to remove this card
  final void Function(String skill, int level, int cardIndex) onSkillChanged; // Callback for skill updates
  final int cardIndex; // Index of this card in the list

  const SkillAddCard({
    super.key,
    required this.onRemove,
    required this.onSkillChanged,
    required this.cardIndex,
  });

  @override
  _SkillAddCardState createState() => _SkillAddCardState();
}

class _SkillAddCardState extends State<SkillAddCard> {
  int? selectedLevel;
  String skillText = '';

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    final unselectedColor = dark ? JColors.grey : JColors.darkGrey;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: JSizes.md, vertical: JSizes.sm),
      margin: const EdgeInsets.symmetric(vertical: JSizes.md),
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
          // Skill Input Row
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
                        onChanged: (value) {
                          setState(() {
                            skillText = value;
                          });
                          // Notify parent of the change
                          widget.onSkillChanged(skillText, selectedLevel ?? 0, widget.cardIndex);
                        },
                        decoration: InputDecoration(
                          hintText: "Enter a skill",
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
          // Skill Level Selection
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Level:", style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(width: JSizes.sm),
              // Skill Level Buttons (1 to 5)
              for (int i = 1; i <= 5; i++) ...[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedLevel = i;
                    });
                    // Notify parent of the level change
                    widget.onSkillChanged(skillText, selectedLevel!, widget.cardIndex);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    transform: selectedLevel == i ? Matrix4.identity().scaled(1.1) : Matrix4.identity(),
                    child: JRoundedContainer(
                      width: 30,
                      height: 30,
                      backgroundColor: selectedLevel == i ? JColors.primary : Colors.transparent,
                      borderColor: selectedLevel == i ? JColors.primary : unselectedColor,
                      showBorder: true,
                      borderWidth: 2,
                      child: Center(
                        child: Text(
                          "$i",
                          style: TextStyle(
                            color: selectedLevel == i ? Colors.white : (dark ? JColors.darkGrey : JColors.darkerGrey),
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
          SizedBox(height: JSizes.sm)
        ],
      ),
    );
  }
}
