// lib/services/quiz_evaluation_service.dart
import '../../../features/Applications/models/quizModel.dart';

class QuizEvaluationService {
  /// Evaluates a question and returns a fractional score (0.0 - 1.0).
  static double evaluateQuestion(QuizQuestion question, dynamic userAnswer) {
    switch (question.type) {
      case QuestionType.multipleChoice:
        return _evaluateMultipleChoice(question, userAnswer);
      case QuestionType.trueFalse:
        return _evaluateTrueFalse(question, userAnswer);
      case QuestionType.shortAnswer:
        return _evaluateShortAnswer(question, userAnswer);
      case QuestionType.problemSolving:
      // You can plug in your custom logic here or flag for manual grading.
        return _evaluateProblemSolving(question, userAnswer);
      default:
        return 0.0;
    }
  }

  static double _evaluateMultipleChoice(QuizQuestion question, List<String> selectedOptions) {
    // Converts lists to sets for an exact match.
    final correctAnswers = Set<String>.from(question.correctAnswers);
    final userAnswers = Set<String>.from(selectedOptions);

    if (correctAnswers.difference(userAnswers).isEmpty &&
        userAnswers.difference(correctAnswers).isEmpty) {
      return 1.0; // Full credit
    }
    return 0.0; // No partial credit
  }

  static double _evaluateTrueFalse(QuizQuestion question, bool userAnswer) {
    // Assumes correctAnswers has one element: "true" or "false"
    final correctAnswer = question.correctAnswers.first.toLowerCase() == 'true';
    return userAnswer == correctAnswer ? 1.0 : 0.0;
  }

  static double _evaluateShortAnswer(QuizQuestion question, String userAnswer) {
    final normalizedUser = userAnswer.trim().toLowerCase();
    return question.correctAnswers.any((correct) =>
    normalizedUser == correct.trim().toLowerCase()) ? 1.0 : 0.0;
  }

  static double _evaluateProblemSolving(QuizQuestion question, String solution) {
    // Placeholder for a more advanced grading strategy.
    return 0.0; // Default: flagged for manual grading or requires custom logic.
  }
}
