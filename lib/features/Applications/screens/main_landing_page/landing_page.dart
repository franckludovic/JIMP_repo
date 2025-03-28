import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/layout/matrix_layout.dart';
import 'package:project_bc_tuto/common/widgets/testimonies_messages/message_carousel.dart';
import 'package:project_bc_tuto/features/Applications/screens/main_landing_page/widget/benefits_chips.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/job_and_internship_card/carousel_slider_interships.dart';
import '../../../../common/widgets/job_and_internship_card/intership_cards.dart';
import '../../../../common/widgets/testimonies_messages/messages.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../personilization/screens/settings/settings.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Intro Section
              _buildHeroSection(context),

              // 2. Key Benefits
              _buildKeyBenefitsSection(context),

              // 3. Popular Job Fields
              _buildPopularJobFields(context),

              // 4. Testimonials

              _buildTestimonialsSection(context),

              // 5. How It Works
              _buildHowItWorksSection(context),

              // 6. Footer
              _buildFooterSection(context),
            ],
          ),
        ),
      ),
    );
  }

  /// 1. Hero / Intro Section
  Widget _buildHeroSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: JSizes.spaceBtwSections),
      color: JColors.primary.withAlpha((0.2 * 255).toInt()),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          Text(
            "Unlock Your Dream Career:\nExciting Jobs & Internships",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: JColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            "Tailored jobs and internships at your fingertips. Discover new opportunities and accelerate your growth.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey[700],
                ),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: JColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  "Find Opportunities",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  side: BorderSide(color: JColors.primary),
                ),
                child: Text(
                  "Post a Job",
                  style: TextStyle(color: JColors.primary),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }

  /// 2. Key Benefits Section
  Widget _buildKeyBenefitsSection(BuildContext context) {

    return Column(
      children: [

          Text(
          "Key Benefits",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: JColors.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: JSizes.spaceBtwItems,),

        Container(
          padding: EdgeInsets.symmetric(horizontal: JSizes.sm),
          child: MatrixGrid(
              items: [
                Benefits(title: "AI-Powered Matching", subTitle: "Find tailored matches based on your profile.", icons: FontAwesomeIcons.brain),
                Benefits(title: "Skill Verification", subTitle: "Validate skills with quizzes & tests.", icons: FontAwesomeIcons.checkDouble),
                Benefits(title:"Personalized Profiles", subTitle: "Highlight your unique strengths & achievements.", icons: FontAwesomeIcons.userLarge),
                Benefits(title:"Seamless Applications", subTitle: "Apply quickly & track your progress easily.", icons: Iconsax.flash),
              ]
          ),
        ),

        SizedBox(height: JSizes.spaceBtwItems,)
      ],
    );
  }

  /// 3. Popular Job Fields
  Widget _buildPopularJobFields(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(JSizes.md),
      child: InternshipCarousel(
        autoplay: true,
          jobs: [
            HorizontalJInternshipCard(
              companyLogo: JImages.google,
              companyName: "Google",
              duration: "5 - 6 month",
              jobTitle: "SoftWare Engineer",
              location: "London",
              skills: ["python", "java", "C++"],
              jobType: 'JOB',
              completionDate: DateTime(2023, 12, 15),
            ),
            HorizontalJInternshipCard(
              companyLogo: JImages.nvidia,
              companyName: "Nvidia",
              duration: "8 - 9 month",
              jobTitle: "Database admin",
              location: "Douala",
              skills: ["C#", "java", "C"],
              completionDate: DateTime(2023, 12, 15),
            ),
            HorizontalJInternshipCard(
              companyLogo: JImages.google,
              companyName: "Skyhub",
              duration: "1 - 4 month",
              jobTitle: "Data analyst",
              location: "Buea",
              skills: ["Python", "R", "ML", "DL"],
              completionDate: DateTime(2023, 12, 15),
            ),
            HorizontalJInternshipCard(
              companyLogo: JImages.apple,
              companyName: "Apple",
              duration: "5 - 6 month",
              jobTitle: "Web Developer",
              location: "Nigeria",
              skills: ["ReactJS", "javascript", "flutter"],
              completionDate: DateTime(2023, 12, 15),
            ),
            HorizontalJInternshipCard(
              companyLogo: JImages.facebook,
              companyName: "Facebook",
              duration: "1 - 3 month",
              jobTitle: "Network admin",
              location: "Libya",
              skills: ["Cisco", "javascript", "Linux"],
              completionDate: DateTime(2023, 12, 15),
            ),
      ]
      ),
    );
  }

  /// 4. Testimonials
  Widget _buildTestimonialsSection(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            "Testimonials & Success Stories",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: JColors.primary,
              fontSize: 23,
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
        SizedBox(height: JSizes.md,),
        MessageCarousel(
            message: [
              Testimonies(message: "JIMP helped me land my dream job in just two weeks!", author: "Franck Licht"),
              Testimonies(message:"We found top-tier talent faster and more efficiently!", author: "Lisa, HR Manager"),
              Testimonies(message: "JIMP helped me land my dream job in just two weeks!", author: "Franck Licht"),
              Testimonies(message:"We found top-tier talent faster and more efficiently!", author: "Lisa, HR Manager"),
            ]
        ),
      ],
    );
  }

  /// 5. How It Works
  Widget _buildHowItWorksSection(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: JSizes.md),
      child: Column(
        children: [

          SizedBox(height: JSizes.spaceBtwSections, ),

          Text("How it Works",   style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: JColors.primary,
            fontSize: 23,
            fontWeight: FontWeight.bold,)
          ),

          SizedBox(height: JSizes.spaceBtwSections, ),

          Text("1. Create Your Profile : Sign up and showcase your brand or Skills.", style: Theme.of(context).textTheme.titleLarge ),
          SizedBox(height: JSizes.spaceBtwItems, ),
          Text("2. Find the Right Match : Explore curated job & internship postings",  style: Theme.of(context).textTheme.titleLarge ),
          SizedBox(height: JSizes.spaceBtwItems,),
          Text("3. Apply & Track : Apply and track your applications seamlessly.",  style: Theme.of(context).textTheme.titleLarge ),

          SizedBox(height: JSizes.spaceBtwSections, ),
        ],
      ),
    );
  }



  /// 6. Footer
  Widget _buildFooterSection(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Text(
            "Ready to Find Your Dream Opportunity? Join JIMP Today!",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
              color: Colors.black
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // TODO: Sign Up
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: JColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: JSizes.lg, vertical: JSizes.md)
                ),
                child: const Text("Sign Up"),
              ),
              OutlinedButton(
                onPressed: () {
                  // TODO: Privacy Policy
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: JColors.secondary),
                ),
                child: Text(
                  "Privacy Policy",
                  style: TextStyle(color: JColors.secondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "About Us | Contact Support | Terms of Service",
            style: TextStyle(color: JColors.darkerGrey),
          ),
        ],
      ),
    );
  }
}

