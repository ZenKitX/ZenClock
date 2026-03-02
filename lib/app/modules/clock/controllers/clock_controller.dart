import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClockController extends GetxController {
  final currentTime = DateTime.now().obs;
  final isDarkMode = false.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
    _initTheme();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentTime.value = DateTime.now();
    });
  }

  void _initTheme() {
    isDarkMode.value = Get.isDarkMode;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
