// lib/models/quiz_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum QuestionType {
  multipleChoice,
  trueFalse,
  shortAnswer,
  problemSolving
}

@immutable
class QuizModel {
  final String id;
  final String title;
  final List<QuizQuestion> questions;
  final int passingScore; // Percentage
  final int timeLimit; // Minutes (0 = unlimited)
  final String instructions;
  final bool allowRetries;
  final int version;
  final DateTime createdAt;
  final DateTime updatedAt;

  const QuizModel({
    required this.id,
    required this.title,
    required this.questions,
    required this.passingScore,
    this.timeLimit = 30,
    this.instructions = 'Complete the quiz to apply',
    this.allowRetries = false,
    this.version = 1,
    required this.createdAt,
    required this.updatedAt,
  })  : assert(passingScore >= 0 && passingScore <= 100,
  'Passing score must be between 0-100%'),
        assert(timeLimit >= 0, 'Time limit cannot be negative');

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    id: json['id'],
    title: json['title'],
    questions: (json['questions'] as List)
        .map((q) => QuizQuestion.fromJson(q))
        .toList(),
    passingScore: json['passingScore'],
    timeLimit: json['timeLimit'] ?? 30,
    instructions: json['instructions'],
    allowRetries: json['allowRetries'] ?? false,
    version: json['version'] ?? 1,
    createdAt: (json['createdAt'] as Timestamp).toDate(),
    updatedAt: (json['updatedAt'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'questions': questions.map((q) => q.toJson()).toList(),
    'passingScore': passingScore,
    'timeLimit': timeLimit,
    'instructions': instructions,
    'allowRetries': allowRetries,
    'version': version,
    'createdAt': Timestamp.fromDate(createdAt),
    'updatedAt': Timestamp.fromDate(updatedAt),
  };

  int get totalPoints => questions.fold(
      0, (previousValue, question) => previousValue + question.points);
}

@immutable
class QuizQuestion {
  final String id;
  final String questionText;
  final QuestionType type;
  final List<String>? options;
  final List<String> correctAnswers;
  final String? solutionHint;
  final String? answerFormat;
  final int points;

   QuizQuestion({
    required this.id,
    required this.questionText,
    required this.type,
    this.options,
    required this.correctAnswers,
    this.solutionHint,
    this.answerFormat,
    this.points = 1,
  })  : assert(
  (type != QuestionType.multipleChoice ||
      (options != null && options!.length >= 2)),
  'Multiple choice requires at least 2 options'
  ),
        assert(
        (type != QuestionType.trueFalse ||
            (correctAnswers.length == 1 &&
                ['true', 'false'].contains(correctAnswers.first.toLowerCase()))),
        'True/False requires exactly one true/false answer'
        ),
        assert(
        (type != QuestionType.shortAnswer ||
            correctAnswers.isNotEmpty),
        'Short answer requires at least one correct answer variant'
        ),
        assert(
        (type != QuestionType.problemSolving ||
            solutionHint != null),
        'Problem solving requires a solution hint'
        );

  factory QuizQuestion.fromJson(Map<String, dynamic> json) => QuizQuestion(
    id: json['id'],
    questionText: json['questionText'],
    type: QuestionType.values.firstWhere(
          (e) => e.toString().split('.').last == json['type'],
      orElse: () => QuestionType.multipleChoice,
    ),
    options: json['options'] != null
        ? List<String>.from(json['options'])
        : null,
    correctAnswers: List<String>.from(json['correctAnswers']),
    solutionHint: json['solutionHint'],
    answerFormat: json['answerFormat'],
    points: json['points'] ?? 1,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'questionText': questionText,
    'type': type.name,
    'options': options,
    'correctAnswers': correctAnswers,
    'solutionHint': solutionHint,
    'answerFormat': answerFormat,
    'points': points,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is QuizQuestion &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              questionText == other.questionText;

  @override
  int get hashCode => id.hashCode ^ questionText.hashCode;
}