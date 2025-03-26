import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Hero / Intro Section
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
      color: JColors.primary.withAlpha((0.1 * 255).toInt()),
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
    final benefits = [
      {
        "title": "AI-Powered Matching",
        "subtitle": "Find tailored matches based on your profile."
      },
      {
        "title": "Skill Verification",
        "subtitle": "Validate skills with quizzes & tests."
      },
      {
        "title": "Personalized Profiles",
        "subtitle": "Highlight your unique strengths & achievements."
      },
      {
        "title": "Seamless Applications",
        "subtitle": "Apply quickly & track your progress easily."
      },
    ];

    return Container(

      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 10),
      child: Column(
        children: [
          Text(
            "Key Benefits",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: JColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: JSizes.sm),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: benefits.map((benefit) {
              return SizedBox(
                width: 150,
                height: 180,
                child: Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(JSizes.sm),
                    child: Column(
                      children: [
                        Text(
                          benefit["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          benefit["subtitle"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// 3. Popular Job Fields
  Widget _buildPopularJobFields(BuildContext context) {
    // TODO: Replace with your custom job cards
    final jobs = [
      {
        "companyName": "Design & Creative",
        "title": "UI/UX Designer Intern",
        "location": "Remote",
        "buttonText": "Apply Now",
      },
      {
        "companyName": "Software Development",
        "title": "Junior Frontend Developer",
        "location": "On-site",
        "buttonText": "Apply Now",
      },
    ];

    return Container(
      color: JColors.secondary.withAlpha((0.05 * 255).toInt()),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          Text(
            "Popular Job Fields",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: JColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: jobs.map((job) {
              // Example of a custom job card
              return Container(
                width: 250,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      job["companyName"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      job["title"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      job["location"]!,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to details
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: JColors.secondary,
                        ),
                        child: Text(job["buttonText"]!),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// 4. Testimonials
  Widget _buildTestimonialsSection(BuildContext context) {
    final testimonials = [
      {
        "quote": '"JIMP helped me land my dream job in just two weeks!"',
        "author": "Jane Doe",
      },
      {
        "quote": '"We found top-tier talent faster and more efficiently!"',
        "author": "Lisa, HR Manager",
      },
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          Text(
            "Testimonials & Success Stories",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: JColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: testimonials.map((testimony) {
              return Container(
                width: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: JColors.primary.withAlpha((0.05 * 255).toInt()),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      testimony["quote"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '- ${testimony["author"]}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// 5. How It Works
  Widget _buildHowItWorksSection(BuildContext context) {
    final steps = [
      {
        "title": "Create Your Profile",
        "subtitle": "Sign up and showcase your brand."
      },
      {
        "title": "Find the Right Match",
        "subtitle": "Explore curated job & internship postings."
      },
      {
        "title": "Apply & Track",
        "subtitle": "Apply and track your applications seamlessly."
      },
    ];

    return Container(
      color: JColors.secondary.withAlpha((0.05 * 255).toInt()),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          Text(
            "How It Works",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: JColors.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: steps.map((step) {
              return Container(
                width: 250,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      step["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      step["subtitle"]!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
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
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
