import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/core/error/exceptions.dart';
import 'package:learn_flutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:learn_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late NumberTriviaLocalDataSourceImpl numberTriviaLocalDataSourcesImpl;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    numberTriviaLocalDataSourcesImpl = NumberTriviaLocalDataSourceImpl(
        sharedPreferences: mockSharedPreferences);
  });

  group("getLocalNumberTrivia", () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture("trivia_cached.json")));
    test(
        "should return a NumberTrivia from shared preferences when cache data exits",
        () async {
      //arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture("trivia_cached.json"));
      //act
      final result =
          await numberTriviaLocalDataSourcesImpl.getLastNumberTrivia();
      //assert
      verify(mockSharedPreferences.getString(CACHED_NUMBER_TRIVIA));
      expect(result, tNumberTriviaModel);
    });

    test("should throw a CacheException when no cache data exits", () async {
      //arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      //act
      final call = numberTriviaLocalDataSourcesImpl.getLastNumberTrivia;
      //assert
      expect(() => call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group("cacheNumberTrivia", () {
    final tNumberTriviaModel = NumberTriviaModel(text: 'test text', number: 1);
    test("shoud cache number trivia in shared preferences", () {
      //arrange
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      //act
      numberTriviaLocalDataSourcesImpl.cacheNumberTrivia(tNumberTriviaModel);
      //assert
      final expectedCachedTriviaModel = jsonEncode(tNumberTriviaModel.toJson());
      verify(mockSharedPreferences.setString(
          CACHED_NUMBER_TRIVIA, expectedCachedTriviaModel));
    });
  });
}
