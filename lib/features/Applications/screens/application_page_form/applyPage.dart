import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/texts/text_fields.dart';
import 'package:project_bc_tuto/data/repositories/applicant/applicant_repository.dart';

import '../../controllers/applicant_controller.dart';
import '../../models/posting_model.dart';
import '../../models/user_model.dart';

class ApplyPage extends StatelessWidget {
  final UserModel candidate;
  final PostingModel posting;

  ApplyPage({
    Key? key,
    required this.candidate,
    required this.posting,
  }) : super(key: key);

  final TextEditingController coverletter = TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    Get.put(ApplicantController());
    Get.put(ApplicantRepository());
    final ApplicantController controller = Get.find<ApplicantController>();

    return Scaffold(
      appBar: AppBar(title: Text('Apply for ${posting.jobTitle}')),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() {

            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Text(posting.jobDescription),
                const SizedBox(height: 16),
                JTestField(labelText: 'Cover Letter', controller: coverletter),
                ElevatedButton(
                  onPressed: () {
                    controller.applyForJob(
                      candidate: candidate,
                      posting: posting,
                      coverLetterUrl: coverletter.text,
                    );
                  },
                  child: Text('Apply Now'),
                ),
                if (controller.errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      controller.errorMessage.value,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
