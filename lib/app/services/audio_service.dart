import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'storage_service.dart';

class AudioService extends GetxService {
  final _storageService = Get.find<StorageService>();
  final isEnabled = true.obs;
  final _player = AudioPlayer();

  Future<AudioService> init() async {
    isEnabled.value = await _storageService.getSoundEnabled();
    await _player.setVolume(0.7);
    return this;
  }

  Future<void> setEnabled(bool enabled) async {
    isEnabled.value = enabled;
    await _storageService.setSoundEnabled(enabled);
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
  }

  // 竹子敲击声 - 用于数字按钮
  Future<void> playBambooTap() async {
    if (!isEnabled.value) return;
    // TODO: 添加音效文件后实现
    // await _player.play(AssetSource('sounds/bamboo_tap.mp3'));
  }

  // 水滴声 - 用于运算符
  Future<void> playWaterDrop() async {
    if (!isEnabled.value) return;
    // TODO: 添加音效文件后实现
    // await _player.play(AssetSource('sounds/water_drop.mp3'));
  }

  // 钟声 - 用于等号、完成
  Future<void> playBell() async {
    if (!isEnabled.value) return;
    // TODO: 添加音效文件后实现
    // await _player.play(AssetSource('sounds/bell.mp3'));
  }

  // 风铃声 - 用于清除
  Future<void> playWindChime() async {
    if (!isEnabled.value) return;
    // TODO: 添加音效文件后实现
    // await _player.play(AssetSource('sounds/wind_chime.mp3'));
  }

  // 柔和提示音 - 用于通知
  Future<void> playNotification() async {
    if (!isEnabled.value) return;
    // TODO: 添加音效文件后实现
    // await _player.play(AssetSource('sounds/notification.mp3'));
  }

  @override
  void onClose() {
    _player.dispose();
    super.onClose();
  }
}
