import 'dart:typed_data';

import 'package:increment/increment.dart';
import 'package:test/test.dart';

void main() {
  test('increment', () {
    final Increment increment = Increment();

    expect(increment.next, equals(0));
    expect(increment.next, equals(1));
  });

  group('max', (){
    test("zero max", (){
      final Increment increment = Increment(max: 0);
      expect(increment.next, equals(0));
      expect(increment.next, equals(0));
    });

    const int max = 10;

    test("reset", (){
      final Increment increment = Increment(max: max);

      for(int i=0; i<=max; i++)
        expect(increment.next, equals(i));
      expect(increment.next, equals(0));
    });

    test("set max", (){
      final Increment increment = Increment(max: max);

      increment.max = max * 2;

      expect(increment.next, equals(0));
    });

    test("set max over value", (){
      final Increment increment = Increment(max: max);

      for(int i=0; i<=max; i++)
        expect(increment.next, equals(i));

      increment.max = max~/2;

      expect(increment.value, 0);
    });

    test("set value", (){
      final Increment increment = Increment(max: max);
      const int value = max ~/ 2;

      increment.value = value;

      expect(increment.value, equals(value));
    });

    test("set value over max", (){
      final Increment increment = Increment(max: max);

      increment.value = max*2;

      expect(increment.value, 0);
    });
  });


  test("32bit limit", (){
    const int _32bitMax = 0x7fffffff;
    final Increment increment = Increment();
    increment.value = _32bitMax - 1;

    final int incrementCurrentValue = increment.next;
    expect(incrementCurrentValue, _32bitMax);
    final Uint8List encodedLimit = Uint8List(4)..buffer.asByteData().setInt32(0, incrementCurrentValue);
    expect(encodedLimit.buffer.asByteData().getInt32(0), 0x7fffffff);

    final int incrementNextValue = increment.next;
    expect(incrementNextValue, isNot(_32bitMax+1));
    final Uint8List encodedMax = Uint8List(4)..buffer.asByteData().setInt32(0, incrementNextValue);
    expect(encodedMax.buffer.asByteData().getInt32(0), isNot(anyOf(0x7fffffff, 0x80000000)));
  });
}