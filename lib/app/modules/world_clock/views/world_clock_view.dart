import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/world_clock_controller.dart';
import '../widgets/world_clock_item.dart';
import 'city_search_view.dart';
import '../../../widgets/neumorphic_button.dart';

class WorldClockView extends GetView<WorldClockController> {
  const WorldClockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('世界时钟'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.cities.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.cities.length,
          itemBuilder: (context, index) {
            final city = controller.cities[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Dismissible(
                key: Key(city.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  controller.removeCity(city.id);
                  Get.snackbar(
                    '已删除',
                    '${city.displayName} 已从列表中移除',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  );
                },
                child: Obx(() => WorldClockItem(
                  city: city,
                  currentTime: controller.getCityTime(city),
                )),
              ),
            );
          },
        );
      }),
      floatingActionButton: NeumorphicButton(
        width: 60,
        height: 60,
        onPressed: () => Get.to(() => const CitySearchView()),
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
            Icons.public_off,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            '还没有添加城市',
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
}
