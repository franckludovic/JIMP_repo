import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/Problem_page.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/MCQ_page.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/custom_quest_page.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/TF_page.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/quiz_creation/widget/short_ques_page.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';


class QuizCreationPage extends StatelessWidget {
  const QuizCreationPage({super.key});

  @override
  Widget build(BuildContext context) {

    final dark = JHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title:  Text("Create Quiz",  style: Theme.of(context).textTheme.headlineMedium,),
          automaticallyImplyLeading: false,
          leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back, size: 30, color: dark ? Colors.white : Colors.black,),),

          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Multiple Choice"),
              Tab(text: "Short Answer"),
              Tab(text: "True/False"),
              Tab(text: "Problem Solving"),
              Tab(text: "Custom "),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MultipleChoiceTabPage(),
            ShortQuestionsTabPage(),
            TrueFalseTabPage(),
            ProblemSolvingTabPage(),
            CustomQuestionTabPage(),
          ],
        ),
      ),
    );
  }
}
