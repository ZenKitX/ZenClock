import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/countdown_controller.dart';
import '../../../widgets/neumorphic_card.dart';
import '../../../widgets/neumorphic_button.dart';

class CountdownView extends GetView<CountdownController> {
  const CountdownView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('倒计时'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          
          // 时间显示和进度环
          Obx(() => NeumorphicCard(
            height: 280,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 进度环
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: controller.progress,
                    strokeWidth: 8,
                    backgroundColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                // 时间文字
                Text(
                  controller.formattedTime,
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.w300,
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          )),
          
          const SizedBox(height: 32),
          
          // 快速设置按钮
          Obx(() {
            if (!controller.isRunning.value && controller.remainingTime.value == Duration.zero) {
              return _buildQuickButtons(context);
            }
            return _buildControls(context);
          }),
          
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildQuickButtons(BuildContext context) {
    final presets = [
      {'label': '1分钟', 'duration': const Duration(minutes: 1)},
      {'label': '3分钟', 'duration': const Duration(minutes: 3)},
      {'label': '5分钟', 'duration': const Duration(minutes: 5)},
      {'label': '10分钟', 'duration': const Duration(minutes: 10)},
      {'label': '15分钟', 'duration': const Duration(minutes: 15)},
      {'label': '30分钟', 'duration': const Duration(minutes: 30)},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Text(
            '快速设置',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: presets.map((preset) {
              return NeumorphicButton(
                width: 100,
                height: 50,
                onPressed: () {
                  controller.setTime(preset['duration'] as Duration);
                },
                child: Text(
                  preset['label'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Obx(() {
      final isRunning = controller.isRunning.value;
      final hasTime = controller.remainingTime.value > Duration.zero;
      
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 重置按钮
            NeumorphicButton(
              width: 80,
              height: 80,
              onPressed: hasTime ? controller.reset : controller.clear,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.refresh,
                    color: Theme.of(context).colorScheme.primary,
                    size: 32,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    hasTime ? '重置' : '清除',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
            
            // 开始/暂停按钮
            NeumorphicButton(
              width: 100,
              height: 100,
              onPressed: hasTime
                  ? (isRunning ? controller.pause : controller.start)
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isRunning ? Icons.pause : Icons.play_arrow,
                    color: hasTime
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    size: 40,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isRunning ? '暂停' : '开始',
                    style: TextStyle(
                      fontSize: 14,
                      color: hasTime
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
