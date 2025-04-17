import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/Applications/screens/applications_applied/widgets/cart_checkout_item.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../personilization/controllers/user_controller.dart';
import '../../controllers/applicant_controller.dart';
import '../../models/applicant_model.dart';

class MyApplicationsScreen extends StatefulWidget {
  const MyApplicationsScreen({super.key});

  @override
  State<MyApplicationsScreen> createState() => _MyApplicationsScreenState();
}

class _MyApplicationsScreenState extends State<MyApplicationsScreen> {
  final controller = Get.put(ApplicantController());
  final userController = Get.put(UserController());

  ApplicantApplicationStatus? selectedFilter;

  @override
  void initState() {
    super.initState();
    _loadApplications();
  }

  Future<void> _loadApplications() async {
     controller.loadUserApplications(userController.user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text(
          'My Applications',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadApplications,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(JSizes.defaultSpace),
              child: DropdownButton<ApplicantApplicationStatus?>(
                value: selectedFilter,
                hint: const Text("Filter by Status"),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    selectedFilter = value;
                  });
                },
                items: [
                  const DropdownMenuItem(
                    value: null,
                    child: Text("All"),
                  ),
                  ...ApplicantApplicationStatus.values.map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status.name.capitalizeFirst ?? status.name),
                    );
                  }).toList(),
                ],
              ),
            ),

            // ListView inside Expanded so it can layout properly
            Expanded(
              child: Obx(() {
                final filteredApps = selectedFilter == null
                    ? controller.applications
                    : controller.applications
                    .where((app) => app.status == selectedFilter)
                    .toList();

                if (filteredApps.isEmpty) {
                  return const Center(child: Text("No applications found."));
                }

                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: JSizes.md),
                  itemCount: filteredApps.length,
                  itemBuilder: (context, index) {
                    final application = filteredApps[index];
                    return StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('applicants')
                          .doc(application.id)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const SizedBox.shrink();
                        }

                        final data = snapshot.data!.data() as Map<String, dynamic>;
                        final updatedApplication =
                        ApplicantModel.fromMap(snapshot.data!.id, data);

                        return ApplicationCard(application: updatedApplication);
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
