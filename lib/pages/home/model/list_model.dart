class ListModel {
  bool? success;
  int? code;
  String? msg;
  List<HomeData>? data;

  ListModel({this.success, this.code, this.msg, this.data});

  ListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <HomeData>[];
      json['data'].forEach((v) {
        data!.add(HomeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeData {
  String? createAt;
  String? platf;
  String? imgurl;

  HomeData({this.createAt, this.platf, this.imgurl});

  HomeData.fromJson(Map<String, dynamic> json) {
    createAt = json['createAt'];
    platf = json['platf'];
    imgurl = json['imgurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createAt'] = createAt;
    data['platf'] = platf;
    data['imgurl'] = imgurl;
    return data;
  }
}
