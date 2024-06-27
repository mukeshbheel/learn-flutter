import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/core/error/exceptions.dart';
import 'package:learn_flutter/core/error/failure.dart';
import 'package:learn_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:learn_flutter/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:learn_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late NumberTriviaRepositoryImpl repositoryImpl;
  late MockNumberTriviaLocalDataSource mockNumberTriviaLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockNumberTriviaRemoteDataSource mockNumberTriviaRemoteDataSource;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockNumberTriviaLocalDataSource = MockNumberTriviaLocalDataSource();
    mockNumberTriviaRemoteDataSource = MockNumberTriviaRemoteDataSource();
    repositoryImpl = NumberTriviaRepositoryImpl(
      networkInfo: mockNetworkInfo,
      numberTriviaLocalDataSource: mockNumberTriviaLocalDataSource,
      numberTriviaRemoteDataSource: mockNumberTriviaRemoteDataSource,
    );
  });

  group("getConcreteNumberTrivia", () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel(text: "text trivia", number: tNumber);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    setUp(() {
      when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => tNumberTriviaModel);
    });
    test("should check if the device is online", () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repositoryImpl.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    group("device is online", () {
      final tNumber = 1;
      final tNumberTriviaModel =
          NumberTriviaModel(text: "text trivia", number: tNumber);
      final NumberTrivia tNumberTrivia = tNumberTriviaModel;
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        //arrange
        when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(
            mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Right(tNumberTrivia)));
      });

      test(
          "should cache remote data when the call to remote data source is successful",
          () async {
        //arrange
        when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        await repositoryImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(
            mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(mockNumberTriviaLocalDataSource
            .cacheNumberTrivia(tNumberTriviaModel));
      });

      test(
          "should throw serverException when the call to remote data source is unsuccessful",
          () async {
        //arrange
        when(mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(
            mockNumberTriviaRemoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Left(ServerFailure())));
        verifyZeroInteractions(mockNumberTriviaLocalDataSource);
      });
    });

    group("device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test("should return last locally cached data if data is present",
          () async {
        //arrange
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        expect(result, Right(tNumberTrivia));
      });

      test("should return CachedFailure when data is not present", () async {
        //arrange
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repositoryImpl.getConcreteNumberTrivia(tNumber);
        //assert
        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        expect(result, Left(CacheFailure()));
      });
    });
  });

  group("getRandomNumberTrivia", () {
    final tNumberTriviaModel =
        NumberTriviaModel(text: "text trivia", number: 123);
    final NumberTrivia tNumberTrivia = tNumberTriviaModel;
    setUp(() {
      when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
          .thenAnswer((_) async => tNumberTriviaModel);
    });
    test("should check if the device is online", () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repositoryImpl.getRandomNumberTrivia();
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    group("device is online", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
          "should return remote data when the call to remote data source is successful",
          () async {
        //arrange
        when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repositoryImpl.getRandomNumberTrivia();
        //assert
        verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
        expect(result, equals(Right(tNumberTrivia)));
      });

      test(
          "should cache remote data when the call to remote data source is successful",
          () async {
        //arrange
        when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        await repositoryImpl.getRandomNumberTrivia();
        //assert
        verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
        verify(mockNumberTriviaLocalDataSource
            .cacheNumberTrivia(tNumberTriviaModel));
      });

      test(
          "should throw serverException when the call to remote data source is unsuccessful",
          () async {
        //arrange
        when(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        //act
        final result = await repositoryImpl.getRandomNumberTrivia();
        //assert
        verify(mockNumberTriviaRemoteDataSource.getRandomNumberTrivia());
        expect(result, equals(Left(ServerFailure())));
        verifyZeroInteractions(mockNumberTriviaLocalDataSource);
      });
    });

    group("device is offline", () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      test("should return last locally cached data if data is present",
          () async {
        //arrange
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => tNumberTriviaModel);
        //act
        final result = await repositoryImpl.getRandomNumberTrivia();
        //assert
        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        expect(result, Right(tNumberTrivia));
      });

      test("should return CachedFailure when data is not present", () async {
        //arrange
        when(mockNumberTriviaLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        //act
        final result = await repositoryImpl.getRandomNumberTrivia();
        //assert
        verify(mockNumberTriviaLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockNumberTriviaRemoteDataSource);
        expect(result, Left(CacheFailure()));
      });
    });
  });
}
