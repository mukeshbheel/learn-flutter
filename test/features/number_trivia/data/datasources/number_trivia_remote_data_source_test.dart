import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/core/error/exceptions.dart';
import 'package:learn_flutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:learn_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late final MockClient mockHttpClient;
  late final NumberTriviaRemoteDataSourceImpl numberTriviaRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockClient();
    numberTriviaRemoteDataSourceImpl = NumberTriviaRemoteDataSourceImpl(
      client: mockHttpClient,
    );
  });

  void setupMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response(fixture("trivia.json"), 200));
  }

  void setupMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed("headers")))
        .thenAnswer((_) async => http.Response("Something went wrong!", 404));
  }

  group("getConcreteNumberTrivia", () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture("trivia.json")));
    // final url = Uri.parse("http://numbersapi.com/$tNumber");

    test('''should perform a get request on  a URL with number
    being the endpoint and application/json header''', () async {
      //arrange
      when(mockHttpClient.get(any, headers: anyNamed("headers")))
          .thenAnswer((_) async => http.Response(fixture("trivia.json"), 200));
      //act
      await numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockHttpClient.get(
        Uri.parse("http://numbersapi.com/$tNumber"),
        headers: {"Content-Type": "application/json"},
      ));
    });

    test('should return NumberTriviaModel when status code is 200', () async {
      //arrange
      setupMockHttpClientSuccess200();
      //act
      final result = await numberTriviaRemoteDataSourceImpl
          .getConcreteNumberTrivia(tNumber);
      //assert
      verify(mockHttpClient.get(
        Uri.parse("http://numbersapi.com/$tNumber"),
        headers: {"Content-Type": "application/json"},
      ));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should return ServerException when status code is 404', () async {
      //arrange
      setupMockHttpClientFailure404();
      //act
      final call = numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia;
      //assert
      expect(
          () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group("getRandomNumberTrivia", () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(jsonDecode(fixture("trivia.json")));
    // final url = Uri.parse("http://numbersapi.com/$tNumber");

    // test('''should perform a get request on  a URL with number
    // being the endpoint and application/json header''', () async {
    //   //arrange
    //   when(mockHttpClient.get(any, headers: anyNamed("headers")))
    //       .thenAnswer((_) async => http.Response(fixture("trivia.json"), 200));
    //   //act
    //   await numberTriviaRemoteDataSourceImpl.getConcreteNumberTrivia(tNumber);
    //   //assert
    //   verify(mockHttpClient.get(
    //     Uri.parse("http://numbersapi.com/$tNumber"),
    //     headers: {"Content-Type": "application/json"},
    //   ));
    // });

    test('should return NumberTriviaModel when status code is 200', () async {
      //arrange
      setupMockHttpClientSuccess200();
      //act
      final result =
          await numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia();
      //assert
      verify(mockHttpClient.get(
        Uri.parse("http://numbersapi.com/random"),
        headers: {"Content-Type": "application/json"},
      ));
      expect(result, equals(tNumberTriviaModel));
    });

    test('should return ServerException when status code is 404', () async {
      //arrange
      setupMockHttpClientFailure404();
      //act
      final call = numberTriviaRemoteDataSourceImpl.getRandomNumberTrivia;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
