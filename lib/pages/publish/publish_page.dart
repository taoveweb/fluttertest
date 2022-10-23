import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:photofilters/photofilters.dart';
import 'package:fluttertest/common/widgets/flutter_photo_filter.dart';
import 'package:fluttertest/common/widgets/preset_filters.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:photofilters/filters/filters.dart';

class PublishPage extends StatelessWidget {
  PublishPage({Key? key}) : super(key: key);
  late String fileName;
  List<Filter> filters = presetFiltersList;
  final picker = ImagePicker();
  late File imageFile;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          getImage(context);
        },
        child: Image.asset(
          'assets/img/add.png',
          width: 78.w,
          height: 78.w,
        ));
  }

  Future getImage(context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      fileName = basename(imageFile.path);
      var image = imageLib.decodeImage(await imageFile.readAsBytes());
      image = imageLib.copyResize(image!, width: 600);
      Map? imagefile = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => fluttertestPhotoFilterSelector(
            appBarColor: Colors.white,
            title: const Text(""),
            image: image!,
            filters: presetFiltersList,
            filename: fileName,
            loader: const Center(child: CircularProgressIndicator()),
            fit: BoxFit.fill,
          ),
        ),
      );

      if (imagefile != null && imagefile.containsKey('image_filtered')) {
        // setState(() {
        //   imageFile = imagefile['image_filtered'];
        // });
        print(imageFile.path);
      }
    }
  }
}
