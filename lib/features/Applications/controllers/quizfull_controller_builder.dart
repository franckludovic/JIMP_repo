// lib/controllers/quiz_builder_controller.dart

import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/models/quizModel.dart';

class QuizBuilderController extends GetxController {
  static QuizBuilderController get instance => Get.find();

  final RxList<QuizQuestion> allQuestions = <QuizQuestion>[].obs;

  final RxString quizTitle = ''.obs;
  final RxInt passingScore = 70.obs;
  final RxInt timeLimit = 30.obs;
  final RxString instructions = 'Complete the quiz to apply'.obs;
  final RxBool allowRetries = false.obs;

  void setQuizMeta({
    required String title,
    required int passing,
    required int time,
    String? note,
    bool? retries,
  }) {
    quizTitle.value = title;
    passingScore.value = passing;
    timeLimit.value = time;
    if (note != null) instructions.value = note;
    if (retries != null) allowRetries.value = retries;
  }

  void addQuestion(QuizQuestion question) {
    allQuestions.add(question);
  }

  void removeQuestionById(String questionId) {
    allQuestions.removeWhere((q) => q.id == questionId);
  }

  void clearAll() {
    allQuestions.clear();
    quizTitle.value = '';
    passingScore.value = 70;
    timeLimit.value = 30;
    instructions.value = 'Complete the quiz to apply';
    allowRetries.value = false;
  }

  QuizModel buildQuizModel(String postingId) {
    return QuizModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: quizTitle.value,
      questions: allQuestions.toList(),
      passingScore: passingScore.value,
      timeLimit: timeLimit.value,
      instructions: instructions.value,
      allowRetries: allowRetries.value,
      version: 1,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}
