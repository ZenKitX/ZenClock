import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/storage_service.dart';
import '../../../services/haptic_service.dart';
import '../../../services/audio_service.dart';

class SettingsController extends GetxController {
  final _storageService = Get.find<StorageService>();
  final _hapticService = Get.find<HapticService>();
  final _audioService = Get.find<AudioService>();

  final isDarkMode = false.obs;
  final hapticEnabled = true.obs;
  final soundEnabled = true.obs;
  final quoteEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    isDarkMode.value = await _storageService.getIsDarkMode();
    hapticEnabled.value = await _storageService.getHapticEnabled();
    soundEnabled.value = await _storageService.getSoundEnabled();
    quoteEnabled.value = await _storageService.getQuoteEnabled();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
    _storageService.setIsDarkMode(isDarkMode.value);
    _hapticService.selection();
  }

  Future<void> setHapticEnabled(bool enabled) async {
    hapticEnabled.value = enabled;
    await _hapticService.setEnabled(enabled);
    if (enabled) {
      _hapticService.medium();
    }
  }

  Future<void> setSoundEnabled(bool enabled) async {
    soundEnabled.value = enabled;
    await _audioService.setEnabled(enabled);
    if (enabled) {
      _audioService.playBell();
    }
  }

  Future<void> setQuoteEnabled(bool enabled) async {
    quoteEnabled.value = enabled;
    await _storageService.setQuoteEnabled(enabled);
    _hapticService.light();
  }
}
