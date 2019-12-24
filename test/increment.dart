import 'dart:typed_data';

import 'package:increment/increment.dart';
import 'package:test/test.dart';

void main() {
  test('paradigm', () {
    //to check if 0x7FFFFFFF is an actual limit for a 32 bit signed int

    //can be encoded in 32 bit
    const int lim = 0x7FFFFFFF;
    final Uint8List encodedLimit = Uint8List(4)..buffer.asByteData().setInt32(0, lim);
    expect(encodedLimit.buffer.asByteData().getInt32(0), equals(lim));

    //incremented by 1
    final int limIncremented = lim+1;

    //cannot be encoded in 32 bit
    final Uint8List encodedLimitIncremented = Uint8List(4)..buffer.asByteData().setInt32(0, limIncremented);
    expect(encodedLimitIncremented.buffer.asByteData().getInt32(0), isNot(equals(limIncremented)));

    //can be encoded in 64 bit
    final Uint8List encodedLimitIncremented64 = Uint8List(8)..buffer.asByteData().setInt64(0, limIncremented);
    expect(encodedLimitIncremented64.buffer.asByteData().getInt64(0), equals(limIncremented));
  });
  test('increment', () {
    final Increment increment = Increment();
    expect(increment.next, equals(0));
    expect(increment.next, equals(1));
  });
  test('limit', (){
    final _IncrementTest increment = _IncrementTest();
    for(int i=0; i<10; i++){
      expect(increment.nextTest, equals(i));
    }
    expect(increment.nextTest, equals(0));
  });
}

class _IncrementTest{
  int _index = 0;
  //replacing the limit with 10 for testing
  int get nextTest => this._index == 10 ? _index = 0 : _index++;
}