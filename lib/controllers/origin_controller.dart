import 'dart:convert';

import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter_amplifysdk/controllers/generic.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_amplifysdk/utils/rest_service/rest_service.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/entities/available_origin_country_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/error_alerts_utils.dart';

class OriginController extends GenericController {
  //key string for caching the countries data
  static const shared_pereference_key = "available_origin_countries";
  RxList<AvailableOriginCountry> available_origin_countries = <AvailableOriginCountry>[].obs;
  Rx<String> version = ''.obs;
  Rx<String> buildNumber = ''.obs;
  Rx<String> origin_country_name = ''.obs;
  Rx<String> origin_calling_code = ''.obs;
  Rx<String> origin_country_iso = ''.obs;

  SendMoneyController get sendMoneyController {
    return Get.find<SendMoneyController>();
  }

  //

  RxList origin_countries = [].obs;
  //

  Future<void> getAvailableOriginCountries() async {
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    try {
      Response response = await getConnect.get("${RestService.instance.url}/get-origin-countries", headers: {
        'Content-Type': 'application/json',
      });
      //log("=>" + response.);
      String receivedJson = response.bodyString!;
      available_origin_countries.value = List.from(json.decode(receivedJson)).map((e) => AvailableOriginCountry.fromJson(e)).toList();
      log(available_origin_countries.length);
      cachAvailableOriginCountries();
    } catch (e, stackTrace) {
      log(e.toString());
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      //await getAvailableOriginCountriesFromCach();
    }
  }

  Future<void> cachAvailableOriginCountries() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(shared_pereference_key, json.encode(available_origin_countries.map((e) => e.toJson()).toList()));
  }

  Future<void> getAvailableOriginCountriesFromCach() async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String receivedJson = sharedPreferences.getString(shared_pereference_key) ?? '';
      available_origin_countries.value = List.from(json.decode(receivedJson)).map((e) => AvailableOriginCountry.fromJson(e)).toList();
    } catch (error, stackTrace) {
//
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
    }
  }

  Future<void> saveUserConsentResult({required bool result}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("user_consent_result", result);
  }

  Future<bool> getUserConsentResult() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = (sharedPreferences.getBool("user_consent_result") ?? false);
    return result;
  }

  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  @override
  void handleOnPop(Route route, Route? previousRoute) {
    // TODO: implement handleOnPop
  }

  @override
  void initVariables() {
    // TODO: implement initVariables
  }

  @override
  void resetVariables() {
    // TODO: implement resetVariables
  }
}
