import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modules/alarm/models/alarm_model.dart';
import '../modules/world_clock/models/timezone_model.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  // 闹钟相关
  static const String _alarmsKey = 'alarms';

  Future<List<AlarmModel>> getAlarms() async {
    final jsonString = _prefs.getString(_alarmsKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => AlarmModel.fromJson(json)).toList();
  }

  Future<void> saveAlarms(List<AlarmModel> alarms) async {
    final jsonList = alarms.map((alarm) => alarm.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await _prefs.setString(_alarmsKey, jsonString);
  }

  // 主题设置
  static const String _themeKey = 'theme_mode';

  Future<bool> getIsDarkMode() async {
    return _prefs.getBool(_themeKey) ?? false;
  }

  Future<void> setIsDarkMode(bool isDark) async {
    await _prefs.setBool(_themeKey, isDark);
  }

  // 触觉反馈设置
  static const String _hapticKey = 'haptic_enabled';

  Future<bool> getHapticEnabled() async {
    return _prefs.getBool(_hapticKey) ?? true;
  }

  Future<void> setHapticEnabled(bool enabled) async {
    await _prefs.setBool(_hapticKey, enabled);
  }

  // 音效设置
  static const String _soundKey = 'sound_enabled';

  Future<bool> getSoundEnabled() async {
    return _prefs.getBool(_soundKey) ?? true;
  }

  Future<void> setSoundEnabled(bool enabled) async {
    await _prefs.setBool(_soundKey, enabled);
  }

  // 禅意语录设置
  static const String _quoteKey = 'quote_enabled';

  Future<bool> getQuoteEnabled() async {
    return _prefs.getBool(_quoteKey) ?? true;
  }

  Future<void> setQuoteEnabled(bool enabled) async {
    await _prefs.setBool(_quoteKey, enabled);
  }

  // 世界时钟城市
  static const String _worldClockKey = 'world_clock_cities';

  Future<List<TimezoneModel>> getWorldClockCities() async {
    final jsonString = _prefs.getString(_worldClockKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => TimezoneModel.fromJson(json)).toList();
  }

  Future<void> saveWorldClockCities(List<TimezoneModel> cities) async {
    final jsonList = cities.map((city) => city.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await _prefs.setString(_worldClockKey, jsonString);
  }
}
