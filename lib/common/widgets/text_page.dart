import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/common/utils/toast.dart';
import 'package:fluttertest/common/utils/util.dart';
import 'package:fluttertest/common/widgets/fluttertest_app_bar.dart';
import 'package:fluttertest/pages/publish/publish_controller.dart';
import 'package:get/get.dart';

class TextPage extends StatefulWidget {
  TextPage({Key? key}) : super(key: key);
  @override
  State<TextPage> createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  TextEditingController text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PublishController>(
        init: PublishController(),
        builder: (controller) {
          var textStyle = TextStyle(
            fontSize: 28.sp,
            color: Color.fromARGB(255, 255, 255, 255),

            // height: 1.0,
          );
          return Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              resizeToAvoidBottomInset: false,
              appBar: TextAppBar(controller, text),
              backgroundColor: Color.fromRGBO(0, 0, 0, .6),
              body: Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 1.sw,
                        height: 1.sh,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(
                                controller.imagedata,
                              )),
                        ),
                      )),
                  Positioned(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        controller: text,
                        autofocus: true,
                        style: textStyle,
                        decoration: InputDecoration(
                          hintText: '输入文本',
                          hintStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.w),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 300.w,
                      )
                    ],
                  )),
                ],
              ));
        });
  }
}

AppBar TextAppBar(PublishController controller, TextEditingController text) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: GestureDetector(
      onTap: () {
        print('object');
        Get.back();
      },
      child: Container(
        width: 100.w,
        alignment: Alignment.centerRight,
        child: Text(
          '取消',
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
      ),
    ),
    actions: [
      GestureDetector(
        onTap: () {
          if (text.text.isNotEmpty) {
            controller.text.value = text.text;
            Size size = boundingTextSize(
                text.text,
                TextStyle(
                  fontSize: 28.sp,
                  color: Color.fromARGB(255, 255, 255, 255),
                  // height: 1.0,
                ));
            controller.floatWight = size.width;
            controller.floatHeight = size.height;
            controller.isRemoved.value = false;
            controller.update();
            Get.back();
          } else {
            showToast('尚未输入文本');
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 31.w, vertical: 14.w),
          child: GradientText(
            '完成',
            textAlign: TextAlign.left,
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(80, 253, 246, 1),
                  Color.fromRGBO(56, 186, 255, 1)
                ]),
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ),
      )
    ],
  );
}
