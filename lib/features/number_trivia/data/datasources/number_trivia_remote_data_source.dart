import 'dart:convert';

import 'package:learn_flutter/core/error/exceptions.dart';
import 'package:learn_flutter/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;

abstract class NumberTriviaRemoteDataSource {
  ///calls the http://numbersapi.com/{number} endpoint
  ///
  ///throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  ///calls the http://numbersapi.com/random endpoint
  ///
  ///throws a [ServerException] for all error codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;
  NumberTriviaRemoteDataSourceImpl({required this.client});

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) =>
      _getConcreteOrRandom("http://numbersapi.com/$number");

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() =>
      _getConcreteOrRandom("http://numbersapi.com/random");

  Future<NumberTriviaModel> _getConcreteOrRandom(String urlString) async {
    final url = Uri.parse(urlString);
    final response =
        await client.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return NumberTriviaModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
