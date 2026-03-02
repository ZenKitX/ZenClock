import 'package:get/get.dart';
import '../modules/clock/bindings/clock_binding.dart';
import '../modules/clock/views/clock_view.dart';
import '../modules/alarm/bindings/alarm_binding.dart';
import '../modules/alarm/views/alarm_list_view.dart';
import '../modules/timer/bindings/timer_binding.dart';
import '../modules/timer/views/timer_view.dart';
import '../modules/countdown/bindings/countdown_binding.dart';
import '../modules/countdown/views/countdown_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/world_clock/bindings/world_clock_binding.dart';
import '../modules/world_clock/views/world_clock_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.CLOCK;

  static final routes = [
    GetPage(
      name: _Paths.CLOCK,
      page: () => const ClockView(),
      binding: ClockBinding(),
    ),
    GetPage(
      name: _Paths.ALARM,
      page: () => const AlarmListView(),
      binding: AlarmBinding(),
    ),
    GetPage(
      name: _Paths.TIMER,
      page: () => const TimerView(),
      binding: TimerBinding(),
    ),
    GetPage(
      name: _Paths.COUNTDOWN,
      page: () => const CountdownView(),
      binding: CountdownBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.WORLD_CLOCK,
      page: () => const WorldClockView(),
      binding: WorldClockBinding(),
    ),
  ];
}
