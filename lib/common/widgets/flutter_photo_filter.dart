import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertest/common/utils/util.dart';
import 'package:fluttertest/common/widgets/floating_draggable_widget.dart';
import 'package:fluttertest/common/widgets/text_page.dart';
import 'package:fluttertest/pages/publish/publish_controller.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image/image.dart' as imageLib;
import 'package:path_provider/path_provider.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:draggable_widget/draggable_widget.dart';

class FluttertestPhotoFilter extends StatelessWidget {
  final imageLib.Image image;
  final String filename;
  final Filter filter;
  final BoxFit fit;
  final Widget loader;

  FluttertestPhotoFilter({
    required this.image,
    required this.filename,
    required this.filter,
    this.fit = BoxFit.fill,
    this.loader = const Center(child: CircularProgressIndicator()),
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<int>>(
      future: compute(applyFilter, <String, dynamic>{
        "filter": filter,
        "image": image,
        "filename": filename,
      }),
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return loader;
          case ConnectionState.active:
          case ConnectionState.waiting:
            return loader;
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            return Image.memory(
              snapshot.data as dynamic,
              fit: fit,
            );
        }
      },
    );
  }
}

///The fluttertestPhotoFilterSelector Widget for apply filter from a selected set of filters
class fluttertestPhotoFilterSelector extends StatefulWidget {
  final Widget title;
  final Color appBarColor;
  final List<Filter> filters;
  final imageLib.Image image;
  final Widget loader;
  final BoxFit fit;
  final String filename;
  final bool circleShape;

  const fluttertestPhotoFilterSelector({
    Key? key,
    required this.title,
    required this.filters,
    required this.image,
    this.appBarColor = Colors.blue,
    this.loader = const Center(child: CircularProgressIndicator()),
    this.fit = BoxFit.fill,
    required this.filename,
    this.circleShape = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      new _fluttertestPhotoFilterSelectorState();
}

class _fluttertestPhotoFilterSelectorState
    extends State<fluttertestPhotoFilterSelector> {
  String? filename;
  Map<String, List<int>?> cachedFilters = {};
  Filter? _filter;
  imageLib.Image? image;
  late bool loading;
  final dragController = DragController();

  @override
  void initState() {
    super.initState();
    loading = false;
    _filter = widget.filters[0];
    filename = widget.filename;
    image = widget.image;
  }

  @override
  void dispose() {
    super.dispose();
  }

  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    positionedBigImage(PublishController conroller) {
      return Positioned(
        top: 0,
        bottom: 0,
        right: 0,
        left: 0,
        child: _buildFilteredImage(_filter, image, filename, conroller),
      );
    }

    var safeArea = SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            title: widget.title,
            backgroundColor: widget.appBarColor,
            actions: <Widget>[
              loading
                  ? Container()
                  : GestureDetector(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        var imageFile = await saveFilteredImage();

                        Navigator.pop(context, {'image_filtered': imageFile});
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.w, right: 28.w),
                        child: GradientText(
                          '发布',
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
          ),
          body: GetBuilder<PublishController>(
            init: PublishController(),
            builder: (conroller) {
              var positionedText = Positioned(
                right: 15.w,
                top: 15.w,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(PageRouteBuilder(
                        opaque: false,
                        pageBuilder: ((context, animation, secondaryAnimation) {
                          return TextPage();
                        })));
                  },
                  child: Icon(
                    Icons.title,
                    color: Colors.white,
                    size: 38.w,
                  ),
                ),
              );
              return Container(
                width: double.infinity,
                height: double.infinity,
                child: loading
                    ? widget.loader
                    : Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.w),
                              child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 41.w, vertical: 30.w),
                                  child: Stack(
                                    children: [
                                      positionedBigImage(conroller),
                                      positionedText,
                                    ],
                                  )),
                            ),
                          ),
                          Container(
                            height: 118.w,
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 41.w, vertical: 0.w),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.filters.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        _buildFilterThumbnail(
                                            widget.filters[index],
                                            image,
                                            filename),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          widget.filters[index].name,
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () => setState(() {
                                    _filter = widget.filters[index];
                                  }),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              );
            },
          )),
    );
    return GetBuilder<PublishController>(
        init: PublishController(),
        builder: ((controller) {
          return FloatingDraggableWidget(
            floatingWidget: GestureDetector(
              onTap: () {},
              child: Text(
                key: globalKey,
                controller.text.value,
                style: TextStyle(fontSize: 24.sp, color: Colors.white),
              ),
            ),
            floatingWidgetHeight: controller.floatHeight,
            floatingWidgetWidth: controller.floatWight,
            dx: controller.dx.value,
            dy: controller.dy.value,
            // deleteWidgetDecoration: const BoxDecoration(
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(50),
            //     topRight: Radius.circular(50),
            //   ),
            // ),
            deleteWidgetPadding: EdgeInsets.only(bottom: 185.w),
            deleteWidget: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(width: 2, color: Colors.black87),
              ),
              child: const Icon(Icons.delete_forever, color: Colors.black87),
            ),
            onDeleteWidget: () {
              controller.text.value = '';
              controller.update();
              debugPrint('Widget deleted');
            },
            mainScreenWidget: safeArea,
          );
        }));
  }

  _buildFilterThumbnail(
      Filter filter, imageLib.Image? image, String? filename) {
    if (cachedFilters[filter.name] == null) {
      return FutureBuilder<List<int>>(
        future: compute(applyFilter, <String, dynamic>{
          "filter": filter,
          "image": image,
          "filename": filename,
        }),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              return CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.white,
                child: Center(
                  child: widget.loader,
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              cachedFilters[filter.name] = snapshot.data;
              return ClipRRect(
                borderRadius: BorderRadius.circular(5.w),
                child: Container(
                  width: 48.w,
                  height: 62.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                          snapshot.data as dynamic,
                        )),
                  ),
                ),
              );
          }
          // unreachable
        },
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(5.w),
        child: Container(
          width: 48.w,
          height: 62.w,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(
                  cachedFilters[filter.name] as dynamic,
                )),
          ),
        ),
      );
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/filtered_${_filter?.name ?? "_"}_$filename');
  }

  Future<File> saveFilteredImage() async {
    var imageFile = await _localFile;
    await imageFile.writeAsBytes(cachedFilters[_filter?.name ?? "_"]!);
    return imageFile;
  }

  Widget _buildFilteredImage(Filter? filter, imageLib.Image? image,
      String? filename, PublishController conroller) {
    if (cachedFilters[filter?.name ?? "_"] == null) {
      return FutureBuilder<List<int>>(
        future: compute(applyFilter, <String, dynamic>{
          "filter": filter,
          "image": image,
          "filename": filename,
        }),
        builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return widget.loader;
            case ConnectionState.active:
            case ConnectionState.waiting:
              return widget.loader;
            case ConnectionState.done:
              if (snapshot.hasError)
                return Center(child: Text('Error: ${snapshot.error}'));
              cachedFilters[filter?.name ?? "_"] = snapshot.data;
              conroller.imagedata = snapshot.data;
              return widget.circleShape
                  ? SizedBox(
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width / 3,
                      child: Center(
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width / 3,
                          backgroundImage: MemoryImage(
                            conroller.imagedata as dynamic,
                          ),
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10.w),
                      child: Image.memory(
                        snapshot.data as dynamic,
                        fit: widget.fit,
                      ),
                    );
          }
          // unreachable
        },
      );
    } else {
      return widget.circleShape
          ? SizedBox(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: Center(
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 3,
                  backgroundImage: MemoryImage(
                    cachedFilters[filter?.name ?? "_"] as dynamic,
                  ),
                ),
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(10.w),
              child: Image.memory(
                cachedFilters[filter?.name ?? "_"] as dynamic,
                fit: widget.fit,
              ),
            );
    }
  }
}

///The global applyfilter function
FutureOr<List<int>> applyFilter(Map<String, dynamic> params) {
  Filter? filter = params["filter"];
  imageLib.Image image = params["image"];
  String filename = params["filename"];
  List<int> _bytes = image.getBytes();
  if (filter != null) {
    filter.apply(_bytes as dynamic, image.width, image.height);
  }
  imageLib.Image _image =
      imageLib.Image.fromBytes(image.width, image.height, _bytes);
  _bytes = imageLib.encodeNamedImage(_image, filename)!;

  return _bytes;
}

///The global buildThumbnail function
FutureOr<List<int>> buildThumbnail(Map<String, dynamic> params) {
  int? width = params["width"];
  params["image"] = imageLib.copyResize(params["image"], width: width);
  return applyFilter(params);
}
