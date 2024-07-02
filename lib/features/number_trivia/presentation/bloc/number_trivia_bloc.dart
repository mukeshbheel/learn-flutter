import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_flutter/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:learn_flutter/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

import '../../../../core/utils/input_converter.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server Failure";
const String CACHE_FAILURE_MESSAGE = "Cache Failure";
const String INVAILD_INPUT_FAILURE_MESSAGE =
    "Invaid Input - The number must be a positive integer or zero";

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required GetConcreteNumberTrivia concrete,
      required GetRandomNumberTrivia random,
      required this.inputConverter})
      : assert(concrete != null),
        assert(random != null),
        assert(inputConverter != null),
        getConcreteNumberTrivia = concrete,
        getRandomNumberTrivia = random,
        super(Empty()) {
    on<NumberTriviaEvent>((event, emit) async* {
      // TODO: implement event handler
      if (event is GetTriviaForConcreteNumber) {
        final inputEither =
            inputConverter.stringToUnsignedInteger(event.numberString);

        yield* inputEither!.fold(
          (failure) async* {
            yield Error(message: INVAILD_INPUT_FAILURE_MESSAGE);
          },
          (integer) {
            print("integer : $integer");
            throw UnimplementedError();
          },
        );
      }
    });
  }

  NumberTriviaState get initialState => Empty();
}
