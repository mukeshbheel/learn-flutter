import 'package:learn_flutter/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  ///calls the http://numbersapi.com/{number} endpoint
  ///
  ///throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  ///calls the http://numbersapi.com/random endpoint
  ///
  ///throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
