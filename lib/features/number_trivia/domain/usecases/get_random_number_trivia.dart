import 'package:dartz/dartz.dart';
import 'package:learn_flutter/core/error/failure.dart';
import 'package:learn_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:learn_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia {
  final NumberTriviaRepository repository;

  const GetRandomNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> call() async {
    return await repository.getRandomNumberTrivia();
  }
}
