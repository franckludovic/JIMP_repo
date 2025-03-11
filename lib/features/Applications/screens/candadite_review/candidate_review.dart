import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/Percentage indicator/circular_pencentage_indicator.dart';

class CandidateReviewPage extends StatelessWidget {
  const CandidateReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text(
          'Candidate',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                padding: const EdgeInsets.all(10),
                width: 200,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.grey[300],
                          child: const Text("Profile image"),
                        ),

                        Positioned(
                          bottom: -13,
                          left: 120,
                          child: IconButton(
                            icon: const Icon(Iconsax.edit),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    const Text(
                      "Licht Lucieniel",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),


              buildInfoCard(
                context,
                [
                  infoRow(Icons.person, "Licht Lucieniel"),
                  infoRow(Icons.email, "lichtlucien@gmail.com"),
                  infoRow(Icons.phone, "+654 78 96 38"),
                  infoRow(Icons.lock, "**********"),
                ],
              ),


              buildInfoCard(
                context,
                [
                  infoRow(Icons.location_on, "Cameroon, Littoral, Douala"),
                  infoRow(Icons.school, "BTech CSE (in progress)"),
                  infoRow(Icons.business, "Institut Universitaire de la Côte"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      "Job Preference:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("• Bioinformatic Engineer"),
                        Text("• Biotech Engineer"),
                      ],
                    ),
                  ),
                ],
              ),


              buildInfoCard(
                context,
                [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Life is a characteristic distinguishing physical entities having biological processes...",
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildUploadButton("Resume"),
                      buildUploadButton("Cover Letter"),
                    ],
                  ),
                ],
              ),

              SizedBox(height: JSizes.spaceBtwItems     ),

              // Skills & Languages

              JRoundedContainer(
                backgroundColor: Colors.grey.shade200,
                child: Column(
                  children: [
                    JRoundedContainer(
                      height: 156,
                        backgroundColor: Colors.grey.shade200,
                      padding: EdgeInsets.symmetric(vertical: JSizes.md),
                      child: ListView.builder(
                        itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index){
                        return
                          SizedBox(child: JCircularSkillIndicator(percentage: 0.5, bottomText: 'python', ));
                      }
                      )
                    ),
                    SizedBox(height: JSizes.spaceBtwSections),
                    const Text("Languages:", style: TextStyle(fontSize: 16, color: Colors.black)),
                    SizedBox(height: JSizes.sm,),
                    const Text("🔘 French  🔘 English  🔘 Latin", style: TextStyle(color: Colors.black),),
                    SizedBox(height: JSizes.spaceBtwSections),
                  ],
                ),
              ),

              // Finish Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "FINISH",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoCard(BuildContext context, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  // Helper method to create an info row with an icon.
  Widget infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 14)),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.edit, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // Helper method to create an upload button.
  Widget buildUploadButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      ),
      onPressed: () {},
      child: Text(text, style: const TextStyle(color: Colors.black)),
    );
  }

}
