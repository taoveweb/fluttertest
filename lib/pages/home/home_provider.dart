import 'package:fluttertest/common/model/base_model.dart';
import 'package:fluttertest/common/utils/base_connect.dart';
import 'package:fluttertest/pages/home/model/list_model.dart';
import 'package:get/get_connect.dart';

// import 'package:zero/pages/store/model/store_detail_model.dart';

class HomeProvider extends BaseConnect {
  Future<Response<ListModel>> homelist() {
    return get(
      'v1/homelist',
      decoder: (obj) => ListModel.fromJson(obj),
    );
  }

  Future<Response<BaseModel>> upload(FormData data) {
    return post('v1/upload', data);
  }
}
