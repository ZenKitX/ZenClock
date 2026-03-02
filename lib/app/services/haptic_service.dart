import 'package:get/get.dart';
import 'package:vibration/vibration.dart';
import 'storage_service.dart';

class HapticService extends GetxService {
  final _storageService = Get.find<StorageService>();
  final isEnabled = true.obs;
  bool? _hasVibrator;

  Future<HapticService> init() async {
    isEnabled.value = await _storageService.getHapticEnabled();
    _hasVibrator = await Vibration.hasVibrator();
    return this;
  }

  Future<void> setEnabled(bool enabled) async {
    isEnabled.value = enabled;
    await _storageService.setHapticEnabled(enabled);
  }

  // 轻触反馈 - 用于数字按钮、列表项点击
  Future<void> light() async {
    if (!isEnabled.value || _hasVibrator != true) return;
    
    try {
      await Vibration.vibrate(duration: 10, amplitude: 50);
    } catch (e) {
      // 降级到系统反馈
      await Vibration.vibrate(duration: 10);
    }
  }

  // 中等反馈 - 用于运算符、功能按钮
  Future<void> medium() async {
    if (!isEnabled.value || _hasVibrator != true) return;
    
    try {
      await Vibration.vibrate(duration: 15, amplitude: 80);
    } catch (e) {
      await Vibration.vibrate(duration: 15);
    }
  }

  // 强反馈 - 用于等号、清除、重要操作
  Future<void> heavy() async {
    if (!isEnabled.value || _hasVibrator != true) return;
    
    try {
      await Vibration.vibrate(duration: 20, amplitude: 120);
    } catch (e) {
      await Vibration.vibrate(duration: 20);
    }
  }

  // 成功反馈 - 用于操作成功
  Future<void> success() async {
    if (!isEnabled.value || _hasVibrator != true) return;
    
    try {
      await Vibration.vibrate(duration: 10, amplitude: 100);
      await Future.delayed(const Duration(milliseconds: 50));
      await Vibration.vibrate(duration: 10, amplitude: 100);
    } catch (e) {
      await Vibration.vibrate(duration: 10);
    }
  }

  // 警告反馈 - 用于错误、警告
  Future<void> warning() async {
    if (!isEnabled.value || _hasVibrator != true) return;
    
    try {
      await Vibration.vibrate(duration: 30, amplitude: 150);
    } catch (e) {
      await Vibration.vibrate(duration: 30);
    }
  }

  // 选择反馈 - 用于主题切换、选项切换
  Future<void> selection() async {
    if (!isEnabled.value || _hasVibrator != true) return;
    
    try {
      await Vibration.vibrate(duration: 8, amplitude: 60);
    } catch (e) {
      await Vibration.vibrate(duration: 8);
    }
  }
}
