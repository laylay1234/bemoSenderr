import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_amplifysdk/utils/rest_service/rest_service.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/entities/device_data_entity.dart';
import 'package:mobileapp/helpers/notifications_manager.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/error_alerts_utils.dart';

class DeviceDataManager {
  static final DeviceDataManager _instance = DeviceDataManager._internal();
  DeviceDataManager._internal();
  factory DeviceDataManager() => _instance;
  //
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  DeviceDataEntity? dataEntity;

  SendMoneyController get sendMoneyController {
    return Get.find<SendMoneyController>();
  }

  AuthController get authController {
    return Get.find<AuthController>();
  }

  ProfileController get profileController {
    return Get.find<ProfileController>();
  }

  Future<void> initDeviceData() async {
    try {
      DeviceDataEntity tmp = DeviceDataEntity();
      //get the device token and device type
      tmp.device_type = NotificationsManger().getDeviceType();
      tmp.device_token = await NotificationsManger().getCurrentToken();

      Map<String, dynamic> deviceData = await getDeviceData();
      DeviceInfo deviceInfo;
      //we get the device info based on the device os
      if (Platform.isAndroid) {
        log('here' + Platform.isAndroid.toString());
        deviceInfo = DeviceInfo(
          model_name: deviceData['model'], ////////////
          platform_name: 'android', //////////////
          uuid: deviceData['androidId'], /////////////////
          manufacturer: deviceData['manufacturer'], /////////////
          version: "android " + deviceData['version.release'] + " (SDK " + deviceData['version.sdkInt'] + ")", /////////////////
          is_physical: deviceData['isPhysicalDevice'].toString(), /////////////////
          serial: 'unknown', ///////////////////
        );
        tmp.deviceInfo = deviceInfo;
      } else if (Platform.isIOS) {
        log('here' + Platform.isIOS.toString());
        deviceInfo = DeviceInfo(
          model_name: deviceData['model'], ////////////
          platform_name: 'iOS', //////////////
          uuid: deviceData['identifierForVendor'], /////////////////
          manufacturer: deviceData['manufacturer'], ////////////////
          version: deviceData['systemVersion'], /////////////////
          is_physical: deviceData['isPhysicalDevice'].toString(), /////////////////
          serial: 'unknown', ///////////////////
        );
        tmp.deviceInfo = deviceInfo;
      }
      log(tmp.deviceInfo!.toJson().toString());
      DateTime dateTime = DateTime.now();
      tmp.time_zone = dateTime.timeZoneName;
      //the last part
      tmp.gcm_senderid = await getSenderId(); //this is a part of fcm token
      tmp.installation_id = await getInstallationId(); //this probably the projet id from firebase app
      Map<String, String> app_data = await getPackageId();
      tmp.app_identifier = app_data['app_identifier']; //this is package id/name
      tmp.app_version = app_data['app_version'];
      //tmp.deviceInfo = deviceInfo;
      //we initilize the dataEntity class parameter
      dataEntity = tmp;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log('from initDeviceData ' + error.toString());
    }
  }

  Future<Map<String, String>> getPackageId() async {
    try {
      //
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      Map<String, String> result = {"app_identifier": packageName, "app_version": version};
      log(result.toString());
      log(buildNumber);
      return result;
      //

    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log(error.toString());
      return {"app_identifier": error.toString(), "app_version": error.toString()};
      //return 'error ${e.toString()}';
    }
  }

  Future<String> getSenderId() async {
    try {
      String sender_id = Firebase.app().options.messagingSenderId;
      return sender_id;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log(error.toString());

      return 'error ${error.toString()}';
    }
  }

  Future<String> getInstallationId() async {
    try {
      //String id = await FirebaseInstallations.instance.getId();
      String id = "xemodev-a21db";

      return id;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log(error.toString());

      return 'error ${error.toString()}';
    }
  }

  //
  Future<void> sendDeviceDataToBackend() async {
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    try {
      String token = await authController.getToken();
      await getConnect.post("${sendMoneyController.api}/register-device", dataEntity!.toJson(), headers: {
        'Authorization': 'Bearer $token', //sign u
        'Content-Type': 'application/json',
      });
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log('from sendDeviceDataToBackend' + error.toString());
    }
  }

  //
  //helper methods
  Future<Map<String, dynamic>> getDeviceData() async {
    Map<String, dynamic> deviceData = <String, dynamic>{};
    //
    //
    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    } else if (Platform.isIOS) {
      deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    }
    return deviceData;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    log(build.product ?? '');
    log(build.host ?? '');
    log(build.brand ?? '');
    return <String, String>{
      'version.securityPatch': build.version.securityPatch ?? '',
      'version.sdkInt': build.version.sdkInt != null ? build.version.sdkInt.toString() : '',
      'version.release': build.version.release ?? '',
      'version.previewSdkInt': build.version.previewSdkInt != null ? build.version.previewSdkInt.toString() : '',
      'version.incremental': build.version.incremental ?? '',
      'version.codename': build.version.codename ?? '',
      'version.baseOS': build.version.baseOS ?? '',
      'board': build.board ?? '',
      'bootloader': build.bootloader ?? '',
      'brand': build.brand ?? '',
      'device': build.device ?? '',
      'display': build.display ?? '',
      'fingerprint': build.fingerprint ?? '',
      'hardware': build.hardware ?? '',
      'host': build.host ?? '',
      'id': build.id ?? '',
      'manufacturer': build.manufacturer ?? '',
      'model': build.model ?? '',
      'product': build.product ?? '',
      // 'supported32BitAbis': build.supported32BitAbis,
      // 'supported64BitAbis': build.supported64BitAbis,
      //   'supportedAbis': build.supportedAbis,
      'tags': build.tags ?? '',
      'type': build.type ?? '',
      'isPhysicalDevice': build.isPhysicalDevice.toString(),
      'androidId': build.androidId ?? '',
      //  'systemFeatures': build.systemFeatures != null ? build.systemFeatures.toString() : [].T,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name ?? '',
      'systemName': data.systemName ?? '',
      'systemVersion': data.systemVersion ?? '',
      'model': data.model ?? '',
      'localizedModel': data.localizedModel ?? ' ',
      'identifierForVendor': data.identifierForVendor ?? '',
      'isPhysicalDevice': data.isPhysicalDevice.toString(),
      'utsname.sysname:': data.utsname.sysname ?? '',
      'utsname.nodename:': data.utsname.nodename ?? '',
      'utsname.release:': data.utsname.release ?? '',
      'utsname.version:': data.utsname.version ?? '',
      'utsname.machine:': data.utsname.machine ?? '',
    };
  }
}
