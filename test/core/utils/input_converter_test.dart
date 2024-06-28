import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/core/utils/input_converter.dart';
import 'package:mockito/mockito.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  test("Should return integer when input string is valid", () {
    //arrange
    final str = "123";
    //act
    final result = inputConverter.stringToUnsignedInteger(str);
    //assert
    expect(result, Right(123));
  });

  test("Should return Failure when input string is not integer", () {
    //arrange
    final str = "abc";
    //act
    final result = inputConverter.stringToUnsignedInteger(str);
    //assert
    expect(result, Left(InvaildInputFailure()));
  });

  test("Should return Failure when input string is negative integer", () {
    //arrange
    final str = "-123";
    //act
    final result = inputConverter.stringToUnsignedInteger(str);
    //assert
    expect(result, Left(InvaildInputFailure()));
  });
}
