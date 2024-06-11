import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_flutter/core/error/failure.dart';
import 'package:learn_flutter/core/usecases/usecase.dart';
import 'package:learn_flutter/features/number_trivia/domain/entities/number_trivia.dart';

import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia implements Usecase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;
  const GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  int number;
  Params({required this.number});

  @override
  List<Object?> get props => [number];
}
