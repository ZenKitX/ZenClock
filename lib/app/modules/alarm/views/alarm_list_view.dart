import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/alarm_controller.dart';
import '../widgets/alarm_item.dart';
import 'alarm_edit_view.dart';
import '../../../widgets/neumorphic_button.dart';

class AlarmListView extends GetView<AlarmController> {
  const AlarmListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('闹钟'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.alarms.isEmpty) {
          return _buildEmptyState(context);
        }
        
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.alarms.length,
          itemBuilder: (context, index) {
            final alarm = controller.alarms[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AlarmItem(
                alarm: alarm,
                onToggle: () => controller.toggleAlarm(alarm.id),
                onEdit: () => _editAlarm(alarm),
                onDelete: () => _deleteAlarm(alarm.id),
              ),
            );
          },
        );
      }),
      floatingActionButton: NeumorphicButton(
        width: 60,
        height: 60,
        onPressed: _addAlarm,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.primary,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.alarm_off,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            '还没有闹钟',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '点击下方按钮添加',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  void _addAlarm() {
    Get.to(() => const AlarmEditView());
  }

  void _editAlarm(alarm) {
    Get.to(() => AlarmEditView(alarm: alarm));
  }

  void _deleteAlarm(String id) {
    Get.dialog(
      AlertDialog(
        title: const Text('删除闹钟'),
        content: const Text('确定要删除这个闹钟吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              controller.deleteAlarm(id);
              Get.back();
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}
