// lib/services/quiz_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../data/repositories/quiz_repository/quiz_evaluation.dart';
import '../features/Applications/models/quizModel.dart';
import '../features/Applications/models/quiz_submision_model.dart';


class QuizService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createQuiz(QuizModel quiz, String companyId) async {
    await _firestore
        .collection('companies')
        .doc(companyId)
        .collection('quizzes')
        .doc(quiz.id)
        .set(quiz.toJson());
  }

  Future<QuizModel?> getQuizById(String quizId, String companyId) async {
    final doc = await _firestore
        .collection('companies')
        .doc(companyId)
        .collection('quizzes')
        .doc(quizId)
        .get();
    return doc.exists ? QuizModel.fromJson(doc.data()!) : null;
  }

  /// Evaluates a full quiz submission.
  Future<QuizResult> evaluateSubmission({
    required QuizSubmission submission,
    required QuizModel quiz,
  }) async {
    int totalPoints = 0;
    int earnedPoints = 0;

    for (final question in quiz.questions) {
      totalPoints += question.points;
      final userAnswer = submission.answers[question.id];
      if (userAnswer == null) continue;

      try {
        // Use unified evaluation; multiply fractional score by question points.
        final fraction = QuizEvaluationService.evaluateQuestion(question, userAnswer);
        earnedPoints += (fraction * question.points).round();
      } catch (e) {
        debugPrint('Error evaluating question ${question.id}: $e');
      }
    }

    final score = totalPoints > 0
        ? (earnedPoints / totalPoints) * 100
        : 0.0;

    return QuizResult(
      passed: score >= quiz.passingScore,
      score: score,
      correctAnswers: earnedPoints,
      totalQuestions: quiz.questions.length,
      timeTaken: submission.timeTaken,
    );
  }

  Future<void> updateQuiz(QuizModel quiz, String companyId) async {
    await _firestore
        .collection('companies')
        .doc(companyId)
        .collection('quizzes')
        .doc(quiz.id)
        .update(quiz.toJson());
  }

  Future<bool> checkQuizExists(String quizId, String companyId) async {
    final doc = await _firestore
        .collection('companies')
        .doc(companyId)
        .collection('quizzes')
        .doc(quizId)
        .get();
    return doc.exists;
  }
}
