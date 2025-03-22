import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../../common/widgets/Images/Jcircular_image.dart';
import '../../../authentication/compamy_screens/sign_up/widget/recuiter_info.dart';
import 'employee_model.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.employee,
    required this.onDelete,
    required this.onEdit,
  });

  final Employee employee;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const RecruiterInfo()),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.sm),
          child: Row(
            children: [
              JCircularImage(
                image: employee.avatar,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: JSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(employee.name,
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(width: JSizes.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: JSizes.sm, vertical: 2),
                          decoration: BoxDecoration(
                            color: employee.role == 'Intern'
                                ? Colors.blue.withAlpha((0.2 * 255).toInt())
                                : Colors.green.withAlpha((0.2 * 255).toInt()),
                            borderRadius: BorderRadius.circular(JSizes.xs),
                          ),
                          child: Text(employee.role,
                              style: Theme.of(context).textTheme.labelSmall),
                        ),
                      ],
                    ),
                    Text(employee.position,
                        style: Theme.of(context).textTheme.bodySmall),
                    Text(employee.email,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: onEdit,
                    child: const Text('Message', style: TextStyle(color: Colors.green)),
                  ),
                  PopupMenuItem(
                    onTap: onDelete,
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}