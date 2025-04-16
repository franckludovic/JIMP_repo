// lib/models/quiz_submission_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class QuizSubmission {
  final String quizId;
  final Map<String, dynamic> answers;
  final double score;
  final Timestamp startedAt;
  final Timestamp completedAt;
  final int timeTaken; // In seconds

  const QuizSubmission({
    required this.quizId,
    required this.answers,
    required this.score,
    required this.startedAt,
    required this.completedAt,
    required this.timeTaken,
  })  : assert(score >= 0 && score <= 100, 'Score must be between 0-100'),
        assert(timeTaken >= 0, 'Time taken cannot be negative');


  QuizSubmission copyWith({
    String? quizId,
    Map<String, dynamic>? answers,
    double? score,
    Timestamp? startedAt,
    Timestamp? completedAt,
    int? timeTaken,
  }) {
    return QuizSubmission(
      quizId: quizId ?? this.quizId,
      answers: answers ?? this.answers,
      score: score ?? this.score,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      timeTaken: timeTaken ?? this.timeTaken,
    );
  }

  factory QuizSubmission.fromMap(Map<String, dynamic> map) {
    return QuizSubmission(
      quizId: map['quizId'] as String,
      answers: Map<String, dynamic>.from(map['answers']),
      score: (map['score'] as num).toDouble(),
      startedAt: map['startedAt'] as Timestamp,
      completedAt: map['completedAt'] as Timestamp,
      timeTaken: map['timeTaken'] as int,
    );

  }

  Map<String, dynamic> toMap() => {
    'quizId': quizId,
    'answers': answers,
    'score': score,
    'startedAt': startedAt,
    'completedAt': completedAt,
    'timeTaken': timeTaken,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is QuizSubmission &&
        other.quizId == quizId &&
        mapEquals(other.answers, answers) &&
        other.score == score;
  }

  @override
  int get hashCode => quizId.hashCode ^ answers.hashCode ^ score.hashCode;
}



class QuizResult {
  final bool passed;
  final double score;
  final int correctAnswers;
  final int totalQuestions;
  final int timeTaken;

  const QuizResult({
    required this.passed,
    required this.score,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeTaken,
  });
}