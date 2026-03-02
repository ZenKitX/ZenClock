part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const CLOCK = _Paths.CLOCK;
  static const ALARM = _Paths.ALARM;
  static const TIMER = _Paths.TIMER;
  static const COUNTDOWN = _Paths.COUNTDOWN;
  static const SETTINGS = _Paths.SETTINGS;
  static const WORLD_CLOCK = _Paths.WORLD_CLOCK;
}

abstract class _Paths {
  _Paths._();
  static const CLOCK = '/clock';
  static const ALARM = '/alarm';
  static const TIMER = '/timer';
  static const COUNTDOWN = '/countdown';
  static const SETTINGS = '/settings';
  static const WORLD_CLOCK = '/world_clock';
}
