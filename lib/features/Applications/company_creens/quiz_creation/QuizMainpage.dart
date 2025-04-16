import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/MCQ_card.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/Problem_page.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/MCQ_page.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/TF_page.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/review%20tab%20page.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/short_ques_page.dart';
import 'package:project_bc_tuto/services/quiz_services.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../controllers/quizfull_controller_builder.dart';

class QuizCreationPage extends StatelessWidget {
  const QuizCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuizService());
    final dark = JHelperFunctions.isDarkMode(context);
    final controllers = Get.put(QuizBuilderController());

    // Controllers for the input fields
    final TextEditingController quizTitleController = TextEditingController();
    final TextEditingController passingScoreController = TextEditingController();
    final TextEditingController timeLimitController = TextEditingController();

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Create Quiz",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: dark ? Colors.white : Colors.black,
            ),
          ),
        ),
        body: Column(
          children: [
            // Quiz configuration fields
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Quiz Title
                  TextField(
                    controller: quizTitleController,
                    decoration: InputDecoration(
                      labelText: 'Quiz Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Passing Score and Time Limit
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: passingScoreController,
                          decoration: InputDecoration(
                            labelText: 'Passing Score (%)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: timeLimitController,
                          decoration: InputDecoration(
                            labelText: 'Time Limit (minutes)',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // TabBar
            const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: "Multiple Choice"),
                Tab(text: "Short Answer"),
                Tab(text: "True/False"),
                Tab(text: "Problem Solving"),
                Tab(text: "Quiz Review"),
              ],
            ),
            // TabBarView
            const Expanded(
              child: TabBarView(
                children: [
                  MultipleChoiceTabPage(),
                  ShortAnswerTabPage(),
                  TrueFalseTabPage(),
                  ProblemSolvingTabPage(),
                  ReviewQuestionsTabPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
