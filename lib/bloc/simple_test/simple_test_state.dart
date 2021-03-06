part of 'simple_test_bloc.dart';

@immutable
abstract class SimpleTestState extends Equatable {}

class SimpleTestLoading extends SimpleTestState {
  final String? message;

  SimpleTestLoading({this.message});

  @override
  List<Object?> get props => [message];
}

enum TetsStatus { running, finished }

class SimpleTestRunning extends SimpleTestState {
  final TetsStatus status;
  // Test setup
  final List<Question> questions;
  final int index;
  // Test stats
  final int correctCount;
  final int mistakeCount;

  SimpleTestRunning({
    this.status = TetsStatus.running,
    required this.questions,
    required this.index,
    required this.correctCount,
    required this.mistakeCount,
  });
  @override
  List<Object?> get props => [questions, index, status];

  Question getQuestion() => questions[index];

  SimpleTestRunning copyWith({
    TetsStatus? status,
    List<Question>? questions,
    int? index,
    int? correctCount,
    int? mistakeCount,
    String? currentQuestion,
    List<String>? currentAnswers,
    String? currentImage,
  }) {
    return SimpleTestRunning(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      index: index ?? this.index,
      correctCount: correctCount ?? this.correctCount,
      mistakeCount: mistakeCount ?? this.mistakeCount,
    );
  }
}
