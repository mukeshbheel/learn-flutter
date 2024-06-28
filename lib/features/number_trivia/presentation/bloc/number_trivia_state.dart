part of 'number_trivia_bloc.dart';

sealed class NumberTriviaState extends Equatable {
  const NumberTriviaState();

  @override
  List<Object> get props => [];
}

final class Empty extends NumberTriviaState {}

final class Loading extends NumberTriviaState {}

final class Loaded extends NumberTriviaState {
  final NumberTrivia trivia;
  const Loaded({required this.trivia});
}

final class Error extends NumberTriviaState {
  final String message;
  const Error({required this.message});
}
