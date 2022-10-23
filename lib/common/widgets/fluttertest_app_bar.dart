import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

AppBar FlutterTestAppBar({
  String? title,
  bool noBack = false,
  Function? onBack,
  List<Widget>? actions,
}) =>
    AppBar(
      centerTitle: true,
      title: Text(
        title ?? '',
        style: TextStyle(
          fontSize: 24.sp,
        ),
      ),
      elevation: 0,
      leading: noBack
          ? null
          : InkWell(
              onTap: () {
                if (onBack != null) {
                  onBack();
                } else {
                  Get.back();
                }
              },
              radius: 0,
              highlightColor: Colors.transparent,
              child: Icon(
                Icons.arrow_back_ios_rounded,
              ),
            ),
      actions: actions ?? [],
      // scrolledUnderElevation: 1.0,
    );
