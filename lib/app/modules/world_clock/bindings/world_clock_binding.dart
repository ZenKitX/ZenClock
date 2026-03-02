import 'package:get/get.dart';
import '../controllers/world_clock_controller.dart';

class WorldClockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorldClockController>(
      () => WorldClockController(),
    );
  }
}
