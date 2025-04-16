import '../../../features/Applications/models/quizModel.dart';

class QuizEvaluationService {
  static double evaluateQuestion(QuizQuestion question, dynamic userAnswer) {
    switch (question.type) {
      case QuestionType.multipleChoice:
        return _evaluateMultipleChoice(question, userAnswer);

      case QuestionType.trueFalse:
        return _evaluateTrueFalse(question, userAnswer);

      case QuestionType.shortAnswer:
        return _evaluateShortAnswer(question, userAnswer);

      case QuestionType.problemSolving:
        return _evaluateProblemSolving(question, userAnswer);

      default:
        return 0.0;
    }
  }

  static double _evaluateMultipleChoice(QuizQuestion question, List<String> selectedOptions) {
    final correctAnswers = Set.from(question.correctAnswers!);
    final userAnswers = Set.from(selectedOptions);

    if (correctAnswers.difference(userAnswers).isEmpty &&
        userAnswers.difference(correctAnswers).isEmpty) {
      return 1.0; // Full points
    }
    return 0.0; // No partial credit
  }

  static double _evaluateTrueFalse(QuizQuestion question, bool userAnswer) {
    final correctAnswer = question.correctAnswers!.first.toLowerCase() == 'true';
    return userAnswer == correctAnswer ? 1.0 : 0.0;
  }

  static double _evaluateShortAnswer(QuizQuestion question, String userAnswer) {
    final normalizedUser = userAnswer.trim().toLowerCase();
    return question.correctAnswers!.any((correct) =>
    normalizedUser == correct.trim().toLowerCase()
    ) ? 1.0 : 0.0;
  }

  static double _evaluateProblemSolving(QuizQuestion question, String solution) {
    // Implement custom evaluation logic or use manual grading
    return 0.0; // Default to manual grading
  }
}