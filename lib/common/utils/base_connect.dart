import 'dart:convert';
//import 'dart:developer';
// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
//import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:fluttertest/common/values/values.dart';
import 'package:fluttertest/common/model/base_model.dart';

class BaseConnect extends GetConnect {
  _handleError(Response response, errMap, [int? requestNumber]) async {
    if (response.hasError) {}
    // 系统级别的报错，比如超时，无网络
    if (response.hasError && requestNumber == 2) {}
  }

  @override
  void onInit() async {
    super.onInit();

    //// test-scope-start
    if (kDebugMode) {
      findProxy = (uri) => "PROXY 192.168.0.103:8899";
    }
    // else {
    //系统代理
    // setProxy();
    // if (Storage.proxy != null) {
    // findProxy = (uri) => "${Storage.proxy}";
    // } else {
    // findProxy = null;
    // }
    // }
    //// test-scope-end

    //httpClient.maxAuthRetries = 3; //重新请求三次
    httpClient.baseUrl = Server.baseUrl;
    // maxAuthRetries = 3;
    httpClient.addRequestModifier(
      (Request req) {
        return req;
        // return req..headers["Authorization"] = '${Storage.token}';
      },
    );
    httpClient.addResponseModifier(
      (req, res) {
        final body = BaseModel.fromJson(json.decode(res.bodyString ?? ''));
        if (body.code != StatusCode.success) {
          //showToast('${body.code}\n${body.msg}');
          // hideLoading();
        }

        return res;
      },
    );
  }

  @override
  Future<Response<T>> get<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      int requestNumber = 1}) {
    return Future(() async {
      final response = await super.get<T>(
        url,
        headers: headers,
        contentType: contentType,
        query: query,
        decoder: decoder,
      );
      //重复三次请求
      if (requestNumber < 3 && response.hasError) {
        get(url,
            headers: headers,
            contentType: contentType,
            query: query,
            decoder: decoder,
            requestNumber: requestNumber + 1);
      }
      var mapError = {
        "url": url,
        "headers": headers.toString(),
        "query": query.toString(),
      };
      _handleError(response, mapError, requestNumber);
      return response;
    });
  }

  @override
  Future<Response<T>> post<T>(String? url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress,
      int requestNumber = 1}) {
    return Future(() async {
      final response = await super.post<T>(
        url,
        body,
        contentType: contentType,
        headers: headers,
        query: query,
        decoder: decoder,
        uploadProgress: uploadProgress,
      );
      var mapError = {
        "url": url,
        'body': body.toString(),
        "headers": headers.toString(),
        "query": query.toString(),
      };

      //重复三次请求
      if (requestNumber < 3 && response.hasError && url != 'order/placeOrder') {
        post(url, body,
            contentType: contentType,
            headers: headers,
            query: query,
            decoder: decoder,
            uploadProgress: uploadProgress,
            requestNumber: requestNumber + 1);
      }
      _handleError(response, mapError, requestNumber);
      return response;
    });
  }
}
