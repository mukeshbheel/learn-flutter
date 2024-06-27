import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:learn_flutter/core/network/network_info.dart';
import 'package:learn_flutter/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:learn_flutter/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:learn_flutter/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([
  NumberTriviaRepository,
  NumberTriviaLocalDataSource,
  NumberTriviaRemoteDataSource,
  NetworkInfo,
  InternetConnectionChecker,
  SharedPreferences
])
void main() {}
