library increment;

///mutable
class Increment{
  ///32bit signed int limit
  static const int _defaultLim = 0x7FFFFFFF;

  final int limit;

  int _index = 0;

  Increment({this.limit = _defaultLim});

  int get next => _index == limit ? _index = 0 : _index++;
}