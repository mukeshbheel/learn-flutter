import 'package:dartz/dartz.dart';
import 'package:learn_flutter/core/error/exceptions.dart';

import 'package:learn_flutter/core/error/failure.dart';
import 'package:learn_flutter/core/network/network_info.dart';
import 'package:learn_flutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:learn_flutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:learn_flutter/features/number_trivia/data/models/number_trivia_model.dart';

import 'package:learn_flutter/features/number_trivia/domain/entities/number_trivia.dart';

import '../../domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChoose();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaLocalDataSource numberTriviaLocalDataSource;
  final NumberTriviaRemoteDataSource numberTriviaRemoteDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.numberTriviaLocalDataSource,
      required this.numberTriviaRemoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return _getTrivia(() async {
      return await numberTriviaRemoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return _getTrivia(() async {
      return await numberTriviaRemoteDataSource.getRandomNumberTrivia();
    });
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChoose getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        numberTriviaLocalDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia =
            await numberTriviaLocalDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return left(CacheFailure());
      }
    }
  }
}
