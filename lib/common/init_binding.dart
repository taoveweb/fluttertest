import 'package:fluttertest/pages/publish/publish_controller.dart';
import 'package:get/instance_manager.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PublishController());
  }
}
