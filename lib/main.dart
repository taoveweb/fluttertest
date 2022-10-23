import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:fluttertest/common/init_binding.dart';
import 'package:fluttertest/routers/router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fluttertest/routers/router_path.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/common/utils/color.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    await ScreenUtil.ensureScreenSize();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
    ));
    await SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp, // 竖屏 Portrait 模式
        DeviceOrientation.portraitDown,
      ],
    );
    // var dsn =
    //     'https://7b09a5a9e6ed4fb680d99bb1402b1047@o1203683.ingest.sentry.io/6330241';
    // if (kDebugMode) {
    //   dsn =
    //       'https://23226ef3b8f5410cb4c0a3be8a7cc457@o1203683.ingest.sentry.io/6547176';
    // }

    /*  await SentryFlutter.init(
      (options) {
        options.dsn = dsn;
      },
    ); */
    runApp(const MyApp());
  }, (error, stack) async {
    // await Sentry.captureException(error, stackTrace: stack);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    final easyload = EasyLoading.init();

    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: false,
      splitScreenMode: false,
      builder: (context, Widget? widget) {
        return GetMaterialApp(
          routingCallback: (routing) async {},
          theme: ThemeData(
            primarySwatch: createMaterialColor(const Color(0xffffffff)),
            primaryColor: const Color(0xffffffff),
            textTheme: TextTheme(
              bodyText1: TextStyle(fontSize: 16.sp),
              bodyText2: TextStyle(fontSize: 16.sp),
            ),
          ),
          initialRoute: RouterPath.initial,
          getPages: Routers.routes,
          builder: (context, widget) {
            var child = easyload(context, widget);

            return MediaQuery(
              ///设置文字大小不随系统设置改变
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child,
            );
          },
          initialBinding: InitBinding(),
        );
      },
    );
  }
}
