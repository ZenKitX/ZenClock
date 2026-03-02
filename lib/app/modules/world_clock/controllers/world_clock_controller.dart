import 'dart:async';
import 'package:get/get.dart';
import '../models/timezone_model.dart';
import '../../../services/storage_service.dart';

class WorldClockController extends GetxController {
  final cities = <TimezoneModel>[].obs;
  final currentTime = DateTime.now().obs;
  final _storageService = Get.find<StorageService>();
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _loadCities();
    _startTimer();
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

  Future<void> _loadCities() async {
    final savedCities = await _storageService.getWorldClockCities();
    if (savedCities.isEmpty) {
      // 默认添加几个城市
      cities.value = [
        TimezoneModel.popularCities[0], // 北京
        TimezoneModel.popularCities[1], // 东京
        TimezoneModel.popularCities[2], // 伦敦
      ];
      await _saveCities();
    } else {
      cities.value = savedCities;
    }
  }

  Future<void> addCity(TimezoneModel city) async {
    if (!cities.any((c) => c.id == city.id)) {
      cities.add(city);
      await _saveCities();
    }
  }

  Future<void> removeCity(String id) async {
    cities.removeWhere((city) => city.id == id);
    await _saveCities();
  }

  Future<void> _saveCities() async {
    await _storageService.saveWorldClockCities(cities);
  }

  DateTime getCityTime(TimezoneModel city) {
    final utcTime = currentTime.value.toUtc();
    return city.getLocalTime(utcTime);
  }

  List<TimezoneModel> get availableCities {
    return TimezoneModel.popularCities
        .where((city) => !cities.any((c) => c.id == city.id))
        .toList();
  }
}
