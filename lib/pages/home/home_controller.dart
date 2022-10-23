import 'package:fluttertest/pages/home/home_provider.dart';
import 'package:fluttertest/pages/home/model/list_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var api = Get.put(HomeProvider());
  // final version = Get.find<VersionUpdateController>();

  var isShopCar = false.obs;
  var inviteUrl = '';
  var list = ListModel().obs;

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

  Future init() async {
    getHomeList();
  }

  Future getHomeList() async {
    var ret = await api.homelist();
    if (ret.hasError) {
    } else {
      if (ret.body?.code == 0) {
        list.value = ret.body!;
        update();
        // banner.value = ret.body!;
      } else {
        // ret.body?.msg ?? showToast(ret.body?.msg ?? '');
      }
    }
  }
}
