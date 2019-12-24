library increment;

///mutable
class Increment{
  ///32bit signed int limit
  static const int _lim = 0x7FFFFFFF;

  int _index = 0;

  int get next => _index == _lim ? _index = 0 : _index++;
}