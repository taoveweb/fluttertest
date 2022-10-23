import 'package:fluttertest/pages/home/home_provider.dart';
import 'package:get/get.dart';

class PublishController extends GetxController {
  var api = Get.put(HomeProvider());
  // final version = Get.find<VersionUpdateController>();
  var show = false.obs;
  var isShopCar = false.obs;
  var isRemoved = false.obs;
  var dy = (300.0).obs;
  var dx = (32.0).obs;
  var floatHeight = 1.0;
  var floatWight = 1.0;
  var text = ''.obs;
  var inviteUrl = '';
  var imagedata;

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
