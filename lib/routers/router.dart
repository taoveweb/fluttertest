import 'package:fluttertest/pages/home/home_page.dart';
import 'package:fluttertest/pages/publish/publish_page.dart';
import 'package:fluttertest/routers/router_path.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class Routers {
  static final routes = [
    GetPage(
      name: RouterPath.home,
      page: () => new HomePage(),
    ),
    GetPage(
      name: RouterPath.publish,
      page: () => new PublishPage(),
    ),
  ];
}
