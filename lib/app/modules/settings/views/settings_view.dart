import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/settings_controller.dart';
import '../../../widgets/neumorphic_card.dart';
import '../../../routes/app_pages.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            context,
            title: '功能',
            children: [
              _buildWorldClockItem(context),
            ],
          ),
          
          const SizedBox(height: 16),
          
          _buildSection(
            context,
            title: '外观',
            children: [
              _buildThemeSwitch(context),
            ],
          ),
          
          const SizedBox(height: 16),
          
          _buildSection(
            context,
            title: '反馈',
            children: [
              _buildHapticSwitch(context),
              _buildSoundSwitch(context),
            ],
          ),
          
          const SizedBox(height: 16),
          
          _buildSection(
            context,
            title: '禅意',
            children: [
              _buildQuoteSwitch(context),
            ],
          ),
          
          const SizedBox(height: 16),
          
          _buildSection(
            context,
            title: '关于',
            children: [
              _buildAboutItem(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        NeumorphicCard(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildWorldClockItem(BuildContext context) {
    return _buildSettingItem(
      context,
      icon: Icons.public,
      title: '世界时钟',
      subtitle: '查看不同时区的时间',
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Get.toNamed(Routes.WORLD_CLOCK),
    );
  }

  Widget _buildThemeSwitch(BuildContext context) {
    return Obx(() => _buildSettingItem(
      context,
      icon: controller.isDarkMode.value
          ? Icons.dark_mode
          : Icons.light_mode,
      title: '深色模式',
      trailing: Switch(
        value: controller.isDarkMode.value,
        onChanged: (value) => controller.toggleTheme(),
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    ));
  }

  Widget _buildHapticSwitch(BuildContext context) {
    return Obx(() => _buildSettingItem(
      context,
      icon: Icons.vibration,
      title: '触觉反馈',
      subtitle: '按钮按压时的震动反馈',
      trailing: Switch(
        value: controller.hapticEnabled.value,
        onChanged: (value) => controller.setHapticEnabled(value),
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    ));
  }

  Widget _buildSoundSwitch(BuildContext context) {
    return Obx(() => _buildSettingItem(
      context,
      icon: Icons.volume_up,
      title: '禅意音效',
      subtitle: '自然音效反馈',
      trailing: Switch(
        value: controller.soundEnabled.value,
        onChanged: (value) => controller.setSoundEnabled(value),
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    ));
  }

  Widget _buildQuoteSwitch(BuildContext context) {
    return Obx(() => _buildSettingItem(
      context,
      icon: Icons.format_quote,
      title: '禅意语录',
      subtitle: '显示禅意语录',
      trailing: Switch(
        value: controller.quoteEnabled.value,
        onChanged: (value) => controller.setQuoteEnabled(value),
        activeColor: Theme.of(context).colorScheme.primary,
      ),
    ));
  }

  Widget _buildAboutItem(BuildContext context) {
    return _buildSettingItem(
      context,
      icon: Icons.info_outline,
      title: 'ZenClock',
      subtitle: '版本 1.0.0',
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _showAboutDialog(context),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('关于 ZenClock'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('版本：1.0.0'),
            const SizedBox(height: 8),
            const Text('一个融合禅意美学的时钟应用'),
            const SizedBox(height: 16),
            Text(
              '在时间中寻找宁静',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
