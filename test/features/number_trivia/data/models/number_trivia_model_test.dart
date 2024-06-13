import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:learn_flutter/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final tNumberTriviaModel = NumberTriviaModel(number: 1, text: 'test text');

  test('should have the same type as NumberTrivia entity', () async {
    //assert
    expect(tNumberTriviaModel, isA<NumberTrivia>());
  });

  group("fromJson", () {
    test("should return NumberTriviaModel when json number is integer",
        () async {
      //arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture("trivia.json"));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, tNumberTriviaModel);
    });

    test("should return NumberTriviaModel when json number is double",
        () async {
      //arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture("trivia_double.json"));
      //act
      final result = NumberTriviaModel.fromJson(jsonMap);
      //assert
      expect(result, tNumberTriviaModel);
    });
  });

  group("toJson", () {
    test("should return a map from model", () {
      //act
      final result = tNumberTriviaModel.toJson();
      //assert
      Map toJsonMap = {
        "text": "test text",
        "number": 1,
      };
      expect(result, toJsonMap);
    });
  });
}
