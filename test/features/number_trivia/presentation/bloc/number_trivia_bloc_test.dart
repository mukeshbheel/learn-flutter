import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/core/utils/input_converter.dart';
import 'package:learn_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:learn_flutter/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:learn_flutter/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      random: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test("initial state should be empty", () {
    //assert
    expect(bloc.initialState, equals(Empty()));
  });

  group("GetTriviaForConcreteNumber", () {
    final tNumberString = "1";
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(text: "test text", number: 1);

    void setUpMockInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInteger(any))
            .thenReturn(Right(tNumberParsed));

    test(
        "should call the input converter to validate and convert string to an unsigned integer",
        () async* {
      //arrange
      setUpMockInputConverterSuccess();
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockInputConverter.stringToUnsignedInteger(any));
      //assert
      verify(mockInputConverter.stringToUnsignedInteger(tNumberString));
    });

    test("should emit [Error] when the input is invalid", () async* {
      //arrange
      when(mockInputConverter.stringToUnsignedInteger(any))
          .thenReturn(left(InvaildInputFailure()));
      //assert Later
      final expected = [
        Empty(),
        Error(message: INVAILD_INPUT_FAILURE_MESSAGE),
      ];
      expectLater(
        bloc.state,
        emitsInOrder(expected),
      );
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
    });

    test("should run getConcreteNumberTrivia usecase when the input is valid",
        () async* {
      //arrange
      setUpMockInputConverterSuccess();
      when(mockGetConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(tNumberTrivia));
      //act
      bloc.add(GetTriviaForConcreteNumber(tNumberString));
      await untilCalled(mockGetConcreteNumberTrivia(any));
      //assert
      verify(mockGetConcreteNumberTrivia(Params(number: tNumberParsed)));
    });
  });
}
