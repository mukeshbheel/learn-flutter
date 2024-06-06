import 'package:dartz/dartz.dart';
import 'package:learn_flutter/core/error/failure.dart';
import 'package:learn_flutter/features/number_trivia/domain/entities/number_trivia.dart';

import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia{
  final NumberTriviaRepository repository;
  const GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute({required int number}) async{
    return await repository.getConcreteNumberTrivia(number);
  }
}