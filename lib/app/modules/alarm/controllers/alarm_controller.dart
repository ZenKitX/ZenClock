import 'package:get/get.dart';
import '../models/alarm_model.dart';
import '../../../services/storage_service.dart';

class AlarmController extends GetxController {
  final alarms = <AlarmModel>[].obs;
  final _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    _loadAlarms();
  }

  Future<void> _loadAlarms() async {
    final savedAlarms = await _storageService.getAlarms();
    alarms.value = savedAlarms;
  }

  Future<void> addAlarm(AlarmModel alarm) async {
    alarms.add(alarm);
    await _saveAlarms();
  }

  Future<void> updateAlarm(AlarmModel alarm) async {
    final index = alarms.indexWhere((a) => a.id == alarm.id);
    if (index != -1) {
      alarms[index] = alarm;
      await _saveAlarms();
    }
  }

  Future<void> deleteAlarm(String id) async {
    alarms.removeWhere((alarm) => alarm.id == id);
    await _saveAlarms();
  }

  Future<void> toggleAlarm(String id) async {
    final index = alarms.indexWhere((a) => a.id == id);
    if (index != -1) {
      alarms[index] = alarms[index].copyWith(
        isEnabled: !alarms[index].isEnabled,
      );
      await _saveAlarms();
    }
  }

  Future<void> _saveAlarms() async {
    await _storageService.saveAlarms(alarms);
  }

  List<AlarmModel> get enabledAlarms {
    return alarms.where((alarm) => alarm.isEnabled).toList();
  }

  AlarmModel? getNextAlarm() {
    if (enabledAlarms.isEmpty) return null;
    
    final now = DateTime.now();
    final sortedAlarms = List<AlarmModel>.from(enabledAlarms);
    
    sortedAlarms.sort((a, b) {
      final aTime = DateTime(now.year, now.month, now.day, a.hour, a.minute);
      final bTime = DateTime(now.year, now.month, now.day, b.hour, b.minute);
      
      if (aTime.isBefore(now)) {
        aTime.add(const Duration(days: 1));
      }
      if (bTime.isBefore(now)) {
        bTime.add(const Duration(days: 1));
      }
      
      return aTime.compareTo(bTime);
    });
    
    return sortedAlarms.first;
  }
}
