import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';


class JProfileMenu extends StatelessWidget {
  const JProfileMenu({
    super.key,
    this.icon = Iconsax.arrow_right_34,
    required this.title,
    required this.value,
    required this.onPressed,
  });

  final IconData icon;
  final String title, value;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: JSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(flex: 3,
                child: Text(title, style: Theme.of(context).textTheme.bodySmall, overflow: TextOverflow.ellipsis)),
            Expanded(flex: 5,
                child: Text(value, style: Theme.of(context).textTheme.bodyMedium, overflow: TextOverflow.ellipsis)),
            Expanded(child: Icon(icon, size: 18 )),
          ],
        ),
      ),
    );
  }
}
