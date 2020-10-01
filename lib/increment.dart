library increment;

class Increment{
  static const int _32bitSignedMax = 0x7fffffff;

  int _currentMax = _32bitSignedMax;
  int _currentValue = -1;

  Increment({final int max = _32bitSignedMax}){
    _currentMax = max;
  }

  int get _reset {
    _currentValue = 0;
    return _currentValue;
  }

  int get _increase {
    _currentValue++;
    return _currentValue;
  }

  int get next => _currentValue == _currentMax
      ? _reset
      : _increase;

  int get value => _currentValue;
  set value(final int newValue) => newValue >= _currentMax
      ? _reset
      : _currentValue = newValue;

  int get max => _currentMax;
  set max(final int newLimit) {
    _currentMax = newLimit;
    if(_currentValue >= newLimit)
      _reset;
  }
}