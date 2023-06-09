import 'dart:developer';

import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:get/get.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_model.dart' as cm;
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/providers/country_provider.dart' as cp;

class CountriesTrHelper {
  static final CountriesTrHelper _instance = CountriesTrHelper._internal();
  CountriesTrHelper._internal();
  factory CountriesTrHelper() => _instance;

  cm.Country? getCountryTrDataByIsoCode(String source_country_iso_code) {
    final value = source_country_iso_code;

    if (value.isNotEmpty) {
      return cp.CountryProvider().countries.where((element) => element.alpha2Code!.toUpperCase() == source_country_iso_code.toUpperCase()).first;
    }
  }

  cm.Country? getCountryTrDataByName(String source_country_name) {
    RxString value = source_country_name.obs;
    if (value.toLowerCase().contains('morroco')) {
      value.value = 'morocco';
    }
    if (value.value.isNotEmpty) {
      try {
        var result = cp.CountryProvider().countries.where((element) => element.name!.toUpperCase().contains(value.value.toUpperCase())).first;
        return result;
      } catch (e) {
        dbg(e.toString(), isError: true);
        log(e.toString());
      }
    }
  }

  String? getCountryName(cm.Country country) {
    if (Get.locale != null && country.nameTranslations != null) {
      String? translated = country.nameTranslations![Get.locale!.languageCode];
      if (translated != null && translated.isNotEmpty) {
        return translated;
      }
    }
    return country.name;
  }
}
