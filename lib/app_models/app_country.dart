import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_amplifysdk/models/generic_user.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:get/get.dart';
import 'package:mobileapp/errors.dart';

import '../models/ModelProvider.dart';
import '../utils/utils.dart';
import 'app_mixin.dart';

class AppCountry extends GenericUser with Status {
  static final AppCountry _appUser = AppCountry._internal();

  factory AppCountry() => _appUser;
  RxList<Country> loadedCountries = <Country>[].obs;

  AppCountry._internal() {
    primaryClassType = Country.classType;
    primaryModelName = 'Country';
    primaryIdField = Country.ID;
    primaryRelations = {};
  }

  Future<List<Country>?> listCountries() async {
    List<Country> _countries = [];
    final request = ModelQueries.list(Country.classType);
    final response = await Amplify.API.query(request: request).response;
    final result = response.data;
    if (result == null) {
      return _countries;
    } else {
      for (var element in response.data!.items) {
        if (element != null) {
          _countries.add(element);
        }
      }
    }
    loadedCountries.value = _countries;
    return _countries;
  }
}
