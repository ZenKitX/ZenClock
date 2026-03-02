import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/clock_controller.dart';
import '../widgets/digital_clock.dart';
import '../../../widgets/neumorphic_card.dart';
import '../../../widgets/neumorphic_button.dart';
import '../../../widgets/zen_quote_widget.dart';
import '../../../routes/app_pages.dart';
import '../../../services/haptic_service.dart';
import '../../../services/zen_quote_service.dart';

class ClockView extends GetView<ClockController> {
  const ClockView({super.key});

  @override
  Widget build(BuildContext context) {
    final haptic = Get.find<HapticService>();
    
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // 顶部工具栏
              _buildTopBar(context, haptic),
              
              const Spacer(),
              
              // 时钟显示区域
              Obx(() => NeumorphicCard(
                height: 320,
                child: DigitalClock(
                  time: controller.currentTime.value,
                  showSeconds: true,
                ),
              )),
              
              const SizedBox(height: 16),
              
              // 禅意语录
              ZenQuoteWidget(
                context: _getQuoteContext(),
                autoRefresh: true,
                refreshInterval: const Duration(minutes: 5),
              ),
              
              const Spacer(),
              
              // 底部功能按钮
              _buildBottomButtons(context, haptic),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, HapticService haptic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        NeumorphicButton(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(12),
          onPressed: () {
            haptic.light();
            Get.toNamed(Routes.SETTINGS);
          },
          child: Icon(
            Icons.settings_outlined,
            color: Theme.of(context).colorScheme.onSurface,
            size: 24,
          ),
        ),
        Obx(() => NeumorphicButton(
          width: 50,
          height: 50,
          padding: const EdgeInsets.all(12),
          onPressed: () {
            haptic.selection();
            controller.toggleTheme();
          },
          child: Icon(
            controller.isDarkMode.value
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            color: Theme.of(context).colorScheme.onSurface,
            size: 24,
          ),
        )),
      ],
    );
  }

  Widget _buildBottomButtons(BuildContext context, HapticService haptic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildFeatureButton(
          context,
          haptic,
          icon: Icons.alarm,
          label: '闹钟',
          onPressed: () {
            haptic.medium();
            Get.toNamed(Routes.ALARM);
          },
        ),
        _buildFeatureButton(
          context,
          haptic,
          icon: Icons.timer_outlined,
          label: '计时器',
          onPressed: () {
            haptic.medium();
            Get.toNamed(Routes.TIMER);
          },
        ),
        _buildFeatureButton(
          context,
          haptic,
          icon: Icons.hourglass_empty,
          label: '倒计时',
          onPressed: () {
            haptic.medium();
            Get.toNamed(Routes.COUNTDOWN);
          },
        ),
      ],
    );
  }

  Widget _buildFeatureButton(
    BuildContext context,
    HapticService haptic, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        NeumorphicButton(
          width: 70,
          height: 70,
          onPressed: onPressed,
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  QuoteContext _getQuoteContext() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return QuoteContext.morning;
    } else if (hour >= 18 && hour < 23) {
      return QuoteContext.evening;
    }
    return QuoteContext.random;
  }
}
