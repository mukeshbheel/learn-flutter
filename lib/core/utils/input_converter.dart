import 'package:dartz/dartz.dart';

import '../error/failure.dart';

class InputConverter {
  Either<Failure, int>? stringToUnsignedInteger(String inputString) {
    try {
      final intNumber = int.parse(inputString);
      if (intNumber < 0) throw const FormatException();
      return Right(intNumber);
    } on FormatException {
      return Left(InvaildInputFailure());
    }
  }
}

class InvaildInputFailure extends Failure {}
