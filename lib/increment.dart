library increment;

class Increment{
  static const int _32bitSignedMax = 0x7fffffff;
  static const int _zero = 0;

  int _currentMax = _32bitSignedMax;
  int _currentValue = -1;

  Increment({final int max = _32bitSignedMax}){
    _currentMax = max;
  }

  int get _reset {
    _currentValue = _zero;
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
  set value(final int newValue) => newValue >= _currentMax || newValue < _zero
      ? _reset
      : _currentValue = newValue;

  int get max => _currentMax;
  set max(final int newMax) {
    assert(newMax >= _zero, "max cannot be less than zero");
    _currentMax = newMax;
    if(_currentValue >= newMax)
      _reset;
  }
}