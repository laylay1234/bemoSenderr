import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_amplifysdk/localization.dart';
import 'package:get/get.dart';

class LocaleStrings extends Translations {
  Map<String, String>? enKeys;
  Map<String, String>? frKeys;

  Future<LocaleStrings> init() async {
    enKeys = await getENkeys();
    frKeys = await getFRkeys();
    return this;
  }

  getSDKENkeys() {
    Map<String, String> sdkLocal = SDKLocaleStrings().getENkeys();
    return sdkLocal;
  }

  getSDKFRkeys() {
    Map<String, String> sdkLocal = SDKLocaleStrings().getFRkeys();
    return sdkLocal;
  }

  Future<Map<String, String>> getENkeys() async {
    return Map<String, String>.from(json.decode(await rootBundle.loadString('assets/flutter_i18n/en.json')));
  }

  Future<Map<String, String>> getFRkeys() async {
    return Map<String, String>.from(json.decode(await rootBundle.loadString('assets/flutter_i18n/fr.json')));
  }

  @override
  Map<String, Map<String, String>> get keys {
    return {
      'en_US': mergeMaps(enKeys!, getSDKENkeys()),
      'fr_CA': mergeMaps(frKeys!, getSDKFRkeys()),
    };
  }

  static List<Locale> localeList = [
    Locale('en', 'US'),
    Locale('fr', 'CA'),
  ];
}
