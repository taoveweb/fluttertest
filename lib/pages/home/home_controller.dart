import 'package:fluttertest/pages/home/home_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var api = Get.put(HomeProvider());
  // final version = Get.find<VersionUpdateController>();

  var isShopCar = false.obs;
  var inviteUrl = '';

  @override
  void onInit() {
    //getStore();
    super.onInit();
    init();
    //init();
  }

  @override
  void onReady() {
    super.onReady();
    // version.onResumed();
  }

  Future init() async {}
}
