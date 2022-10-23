// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterlifecyclehooks/flutterlifecyclehooks.dart';
import 'package:fluttertest/common/widgets/refresh.dart';
import 'package:fluttertest/common/widgets/fluttertest_app_bar.dart';
import 'package:fluttertest/pages/home/home_controller.dart';
import 'package:fluttertest/pages/publish/publish_page.dart';
import 'package:fluttertest/routers/router_path.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final refreshController = EasyRefreshController();

refreshHome() {
  try {} catch (e) {}
}

class _HomePageState extends State<HomePage>
    with
        TickerProviderStateMixin,
        AutomaticKeepAliveClientMixin,
        WidgetsBindingObserver,
        WidgetsBindingObserver,
        LifecycleMixin {
  final cuttentTabIndex = 0.obs;

  final refreshController = EasyRefreshController();

  @override
  void dispose() {
    super.dispose();
  }

  @override

  /// WidgetsBindingObserver
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  var showTime = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            FlutterTestAppBar(title: 'Hyperbound Flutter Demo', noBack: true),
        backgroundColor: Colors.white,
        body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: refresh(
              firstRefresh: false,
              refreshController: refreshController,
              onRefresh: () async {},
              onLoad: () async {},
              child: GetBuilder<HomeController>(
                init: HomeController(),
                builder: (_) {
                  // return noMessage;

                  return SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: ListView.builder(
                        itemCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var textStyle = TextStyle(
                              fontSize: 12.sp,
                              color: Color.fromRGBO(158, 158, 158, 1));
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                height: 1,
                                color: Color.fromRGBO(232, 232, 232, 1),
                              ),
                              Padding(
                                padding: EdgeInsets.all(29.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(7.w),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        imageUrl:
                                            'https://img0.baidu.com/it/u=3222079260,4146877074&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500',
                                        width: 158.w,
                                        height: 158.w,
                                        memCacheWidth: 158,
                                        errorWidget: ErroWidget,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.w,
                                    ),
                                    Text(
                                      '2022-09-23 12:03 ios',
                                      style: textStyle,
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                  );
                },
              ),
            )),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: PublishPage());
  }

  Widget ErroWidget(a, b, c) {
    return Image.asset(
      'assets/img/no_pcture.png',
      width: 158.w,
      height: 158.w,
    );
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    refreshHome();
    // TODO: implement onResume
  }
}

Widget noMessage = Padding(
  padding: EdgeInsets.only(
    top: 300.w,
  ),
  child: Column(
    children: [
      Image.asset(
        "assets/img/no_message.png",
        width: 140.w,
        height: 140.w,
      ),
      SizedBox(
        height: 52.w,
      ),
      Text(
        'No Data',
        style: TextStyle(
          fontSize: 28.sp,
          color: Color.fromRGBO(98, 99, 102, 1),
        ),
      )
    ],
  ),
);
