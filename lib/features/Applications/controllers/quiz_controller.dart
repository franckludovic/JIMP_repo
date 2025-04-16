// lib/controllers/quiz_controller.dart
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../services/application_service.dart';
import '../../../services/quiz_services.dart';
import '../models/applicant_model.dart';
import '../models/quizModel.dart';
import '../models/quiz_submision_model.dart';

class QuizController extends GetxController {
  final QuizService _quizService = Get.find();
  final ApplicationService _applicationService = Get.find();

  final Rx<QuizModel?> currentQuiz = Rx<QuizModel?>(null);
  final Rx<QuizSubmission?> submission = Rx<QuizSubmission?>(null);
  final RxInt currentQuestionIndex = 0.obs;
  final RxInt timeLeft = 0.obs;
  final RxString formattedTime = '00:00'.obs;
  final RxBool isQuizComplete = false.obs;
  final RxMap<String, dynamic> answers = <String, dynamic>{}.obs;

  Timer? _timer;

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  /// Starts the quiz by setting the current quiz, time, and initializing a submission record.
  void startQuiz(QuizModel quiz) {
    currentQuiz.value = quiz;
    timeLeft.value = quiz.timeLimit * 60;
    _startTimer();
    submission.value = QuizSubmission(
      quizId: quiz.id,
      answers: {},
      score: 0,
      startedAt: Timestamp.now(),
      completedAt: Timestamp.now(),
      timeTaken: 0,
    );
  }

  /// Starts a countdown timer updating every second.
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
        // Update formatted time in mm:ss format
        formattedTime.value = DateFormat('mm:ss').format(
          DateTime.fromMillisecondsSinceEpoch(timeLeft.value * 1000),
        );
      } else {
        _timeExpired();
      }
    });
  }

  /// Called when time expires.
  void _timeExpired() {
    _timer?.cancel();
    isQuizComplete.value = true;
    Get.snackbar('Time Expired', 'Your quiz time has run out!');
  }

  /// Saves or updates an answer for a given question.
  void saveAnswer(String questionId, dynamic answer) {
    answers[questionId] = answer;
  }

  /// Submits the quiz, evaluates the submission, and marks the quiz as complete.
  Future<void> submitQuiz() async {
    if (currentQuiz.value == null || submission.value == null) return;

    final result = await _quizService.evaluateSubmission(
      submission: submission.value!.copyWith(
        answers: answers,
        // Calculate the time taken based on initial quiz time minus the remaining time.
        timeTaken: currentQuiz.value!.timeLimit * 60 - timeLeft.value,
      ),
      quiz: currentQuiz.value!,
    );

    submission.value = submission.value!.copyWith(
      score: result.score,
      completedAt: Timestamp.now(),
    );

    isQuizComplete.value = true;
    _timer?.cancel();
  }

  /// Navigates to the next question if available.
  void nextQuestion() {
    if (currentQuiz.value == null) return;
    if (currentQuestionIndex.value < currentQuiz.value!.questions.length - 1) {
      currentQuestionIndex.value++;
    }
  }

  /// Navigates to the previous question if available.
  void previousQuestion() {
    if (currentQuiz.value == null) return;
    if (currentQuestionIndex.value > 0) {
      currentQuestionIndex.value--;
    }
  }

  /// Returns a progress percentage (0.0 to 1.0) of the current quiz.
  double get progress => currentQuiz.value == null || currentQuiz.value!.questions.isEmpty
      ? 0
      : currentQuestionIndex.value / currentQuiz.value!.questions.length;

  /// Returns the current question of the quiz.
  QuizQuestion get currentQuestion {
    if (currentQuiz.value == null) {
      throw Exception("No quiz is currently active");
    }
    return currentQuiz.value!.questions[currentQuestionIndex.value];
  }
}
