import 'package:flutter_test/flutter_test.dart';
import 'package:pmvvm/pmvvm.dart';

void main() {
  group('Observable tests -', () {
    test('When the observable is not initialized Then an error will be raised when the value is consumed', () {
      // ARRANGE
      final counter = Observable<int>('MyCounter');

      // ASSERT
      expect(() => counter.value, throwsException);
    });

    test('When the observable is not initialized Then hasValue will return false', () {
      // ARRANGE
      final counter = Observable<int>('MyCounter');

      // ASSERT
      expect(counter.hasValue, false);
    });

    test('When setValue is called Then the observable value changes', () {
      // ARRANGE
      final counter = Observable.initialized(0, 'MyCounter');

      // ACT
      counter.setValue(counter.value + 1, action: 'INCREASE');

      // ASSERT
      expect(counter.value, 1);
    });

    test('When the observable has one value Then prevValue will return null', () {
      // ARRANGE
      final counter = Observable.initialized(0, 'MyCounter');

      // ASSERT
      expect(counter.prevValue, null);
    });

    test('When the observable is not initialized Then valueOrNull will return null', () {
      // ARRANGE
      final counter = Observable<int>('MyCounter');

      // ASSERT
      expect(counter.valueOrNull, null);
    });
  });
}
