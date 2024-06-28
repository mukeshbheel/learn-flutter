part of 'number_trivia_bloc.dart';

sealed class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();

  @override
  List<Object> get props => [];
}

class GetTriviaForInputNumber extends NumberTriviaEvent {
  final String numberString;
  const GetTriviaForInputNumber(this.numberString);
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {}
