import 'package:get_storage/get_storage.dart';
import 'package:fluttertest/common/values/values.dart';

class Storage {
  static String? get token => GetStorage().read(SpKey.token);
  static set token(String? token) => GetStorage().write(SpKey.token, token);

  static String? get proxy => GetStorage().read(SpKey.proxy);
  static set proxy(String? proxy) => GetStorage().write(SpKey.proxy, proxy);

  static String? get skipUpdateVersion =>
      GetStorage().read(SpKey.skipUpdateVersion);
  static set skipUpdateVersion(String? skipUpdateVersion) =>
      GetStorage().write(SpKey.skipUpdateVersion, skipUpdateVersion);

  static String? get storeId => GetStorage().read(SpKey.storeId);
  static set storeId(String? storeId) =>
      GetStorage().write(SpKey.storeId, storeId);

  static int? get refreshTime => GetStorage().read(SpKey.refreshTime);
  static set refreshTime(int? refreshTime) =>
      GetStorage().write(SpKey.refreshTime, refreshTime);

  static String? get fcmToken => GetStorage().read(SpKey.fcmToken);
  static set fcmToken(String? fcmToken) =>
      GetStorage().write(SpKey.fcmToken, fcmToken);

  static bool? get versionDialog => GetStorage().read(SpKey.versionDialog);
  static set versionDialog(bool? versionDialog) =>
      GetStorage().write(SpKey.versionDialog, versionDialog);

  static bool? get notificationDialog =>
      GetStorage().read(SpKey.notificationDialog);
  static set notificationDialog(bool? notificationDialog) =>
      GetStorage().write(SpKey.notificationDialog, notificationDialog);

  static Map? get deviceInfo => GetStorage().read(SpKey.deviceInfo);
  static set deviceInfo(Map? deviceInfo) =>
      GetStorage().write(SpKey.deviceInfo, deviceInfo);

  static Map get tips => GetStorage().read(SpKey.tips);
  static set tips(Map? deviceInfo) =>
      GetStorage().write(SpKey.tips, deviceInfo);

  static String get isNewData => GetStorage().read(SpKey.isNewData);
  static set isNewData(String? isNewData) =>
      GetStorage().write(SpKey.isNewData, isNewData);
}
