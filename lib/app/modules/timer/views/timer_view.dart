import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';
import '../../../widgets/neumorphic_card.dart';
import '../../../widgets/neumorphic_button.dart';

class TimerView extends GetView<TimerController> {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('计时器'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 32),
          
          // 时间显示
          Obx(() => NeumorphicCard(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: Text(
                controller.formattedTime,
                style: TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).colorScheme.onSurface,
                  letterSpacing: 2,
                ),
              ),
            ),
          )),
          
          const SizedBox(height: 32),
          
          // 控制按钮
          _buildControls(context),
          
          const SizedBox(height: 24),
          
          // 计次列表
          Expanded(
            child: Obx(() {
              if (controller.laps.isEmpty) {
                return Center(
                  child: Text(
                    '点击"计次"记录时间',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                );
              }
              
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: controller.laps.length,
                itemBuilder: (context, index) {
                  final lap = controller.laps[index];
                  return _buildLapItem(context, lap);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(BuildContext context) {
    return Obx(() {
      final isRunning = controller.isRunning.value;
      final hasStarted = controller.elapsedTime.value > Duration.zero;
      
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 重置/计次按钮
            NeumorphicButton(
              width: 80,
              height: 80,
              onPressed: hasStarted
                  ? (isRunning ? controller.lap : controller.reset)
                  : null,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isRunning ? Icons.flag : Icons.refresh,
                    color: hasStarted
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    size: 32,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isRunning ? '计次' : '重置',
                    style: TextStyle(
                      fontSize: 12,
                      color: hasStarted
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
            ),
            
            // 开始/暂停按钮
            NeumorphicButton(
              width: 100,
              height: 100,
              onPressed: isRunning ? controller.pause : controller.start,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isRunning ? Icons.pause : Icons.play_arrow,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isRunning ? '暂停' : '开始',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
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

  Widget _buildLapItem(BuildContext context, lap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '计次 ${lap.lapNumber}',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Row(
            children: [
              Text(
                lap.lapTimeString,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                lap.totalTimeString,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
