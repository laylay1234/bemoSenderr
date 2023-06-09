import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_amplifysdk/models/generic_user.dart';
import 'package:get/get.dart';

import '../models/ModelProvider.dart';
import 'app_mixin.dart';

class AppCurrency extends GenericUser with Status {
  static final AppCurrency _appUser = AppCurrency._internal();

  factory AppCurrency() => _appUser;
  RxList<Currency> loadedCurrencies = <Currency>[].obs;
  AppCurrency._internal() {
    primaryClassType = Currency.classType;
    primaryModelName = 'Country';
    primaryIdField = Currency.ID;
    primaryRelations = {};
  }

  Future<List<Currency>?> listCurrencies() async {
    List<Currency> _currencies = [];
    final request = ModelQueries.list(Currency.classType);
    final response = await Amplify.API.query(request: request).response;
    final result = response.data;
    if (result == null) {
      return _currencies;
    } else {
      for (var element in response.data!.items) {
        if (element != null) {
          _currencies.add(element);
        }
      }
    }
    loadedCurrencies.value = _currencies;
    return _currencies;
  }
}
