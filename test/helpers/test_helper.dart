import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:learn_flutter/core/network/network_info.dart';
import 'package:learn_flutter/core/utils/input_converter.dart';
import 'package:learn_flutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:learn_flutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:learn_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:learn_flutter/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:learn_flutter/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  NumberTriviaRepository,
  NumberTriviaLocalDataSource,
  NumberTriviaRemoteDataSource,
  NetworkInfo,
  InternetConnectionChecker,
  SharedPreferences,
  http.Client,
  GetConcreteNumberTrivia,
  GetRandomNumberTrivia,
  InputConverter
])
void main() {}
