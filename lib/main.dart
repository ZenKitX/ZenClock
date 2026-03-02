import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/config/theme/app_theme.dart';
import 'app/services/storage_service.dart';
import 'app/services/haptic_service.dart';
import 'app/services/audio_service.dart';
import 'app/services/zen_quote_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 初始化服务
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => HapticService().init());
  await Get.putAsync(() => AudioService().init());
  Get.put(ZenQuoteService());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ZenClock',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
