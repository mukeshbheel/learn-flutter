import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/core/network/network_info.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group("is Connected", () {
    final tHasConnectionFuture = Future.value(true);
    test("should forward the call to internectConnectionChecker.hasConnection",
        () {
      //arrange
      when(mockInternetConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);
      //act
      final result = networkInfoImpl.isConnected;
      //assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, tHasConnectionFuture);
    });
  });
}
