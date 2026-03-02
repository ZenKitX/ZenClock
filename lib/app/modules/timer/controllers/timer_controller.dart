import 'dart:async';
import 'package:get/get.dart';
import '../models/timer_record.dart';

class TimerController extends GetxController {
  final elapsedTime = Duration.zero.obs;
  final isRunning = false.obs;
  final laps = <TimerRecord>[].obs;
  
  Timer? _timer;
  DateTime? _startTime;
  Duration _previousElapsed = Duration.zero;
  Duration _lastLapTime = Duration.zero;

  void start() {
    if (isRunning.value) return;
    
    _startTime = DateTime.now();
    isRunning.value = true;
    
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      final now = DateTime.now();
      elapsedTime.value = _previousElapsed + now.difference(_startTime!);
    });
  }

  void pause() {
    if (!isRunning.value) return;
    
    _timer?.cancel();
    _previousElapsed = elapsedTime.value;
    isRunning.value = false;
  }

  void reset() {
    _timer?.cancel();
    elapsedTime.value = Duration.zero;
    _previousElapsed = Duration.zero;
    _lastLapTime = Duration.zero;
    isRunning.value = false;
    laps.clear();
  }

  void lap() {
    if (!isRunning.value) return;
    
    final currentTime = elapsedTime.value;
    final lapTime = currentTime - _lastLapTime;
    
    laps.insert(0, TimerRecord(
      lapNumber: laps.length + 1,
      lapTime: lapTime,
      totalTime: currentTime,
    ));
    
    _lastLapTime = currentTime;
  }

  String get formattedTime {
    final hours = elapsedTime.value.inHours;
    final minutes = elapsedTime.value.inMinutes.remainder(60);
    final seconds = elapsedTime.value.inSeconds.remainder(60);
    final milliseconds = (elapsedTime.value.inMilliseconds.remainder(1000) / 10).floor();

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
