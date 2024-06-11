import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:learn_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:learn_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:learn_flutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  NumberTrivia tNumberTrivia = NumberTrivia(text: 'text', number: 1);

  test("should return a random number trivia", () async {
    //arrange
    when(mockNumberTriviaRepository.getRandomNumberTrivia())
        .thenAnswer((_) async => Right(tNumberTrivia));

    //act
    final result = await usecase();

    //assert
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
