import 'dart:async';
import 'package:get/get.dart';
import '../../../services/haptic_service.dart';
import '../../../services/audio_service.dart';

class CountdownController extends GetxController {
  final remainingTime = Duration.zero.obs;
  final totalTime = Duration.zero.obs;
  final isRunning = false.obs;
  
  Timer? _timer;

  void setTime(Duration duration) {
    if (isRunning.value) return;
    totalTime.value = duration;
    remainingTime.value = duration;
  }

  void start() {
    if (isRunning.value || remainingTime.value == Duration.zero) return;
    
    isRunning.value = true;
    
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (remainingTime.value.inMilliseconds <= 100) {
        _onComplete();
      } else {
        remainingTime.value = Duration(
          milliseconds: remainingTime.value.inMilliseconds - 100,
        );
      }
    });
  }

  void pause() {
    if (!isRunning.value) return;
    
    _timer?.cancel();
    isRunning.value = false;
  }

  void reset() {
    _timer?.cancel();
    remainingTime.value = totalTime.value;
    isRunning.value = false;
  }

  void clear() {
    _timer?.cancel();
    remainingTime.value = Duration.zero;
    totalTime.value = Duration.zero;
    isRunning.value = false;
  }

  Future<void> _onComplete() async {
    _timer?.cancel();
    remainingTime.value = Duration.zero;
    isRunning.value = false;
    
    // 播放提示音和震动
    try {
      final haptic = Get.find<HapticService>();
      final audio = Get.find<AudioService>();
      await haptic.heavy();
      await audio.playBell();
    } catch (e) {
      // 服务未初始化时忽略
    }
    
    Get.snackbar(
      '倒计时结束',
      '时间到！',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  String get formattedTime {
    final hours = remainingTime.value.inHours;
    final minutes = remainingTime.value.inMinutes.remainder(60);
    final seconds = remainingTime.value.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get progress {
    if (totalTime.value == Duration.zero) return 0.0;
    return remainingTime.value.inMilliseconds / totalTime.value.inMilliseconds;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
