import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_list.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_model.dart';

const String PropertyName = 'alpha_2_code';

/// [CountryProvider] provides helper classes that involves manipulations.
/// of Countries from [Countries.countryList]
class CountryProvider {
  static final CountryProvider _instance = CountryProvider._internal();
  CountryProvider._internal();
  factory CountryProvider() => _instance;
  List<Country> countries = [];

  /// Get data of Countries.
  ///
  /// Returns List of [Country].
  ///
  ///  * If [countries] is `null` or empty it returns a list of all [Countries.countryList].
  ///  * If [countries] is not empty it r
  /// eturns a filtered list containing
  ///    counties as specified.
  ///
  ///
  void init() {
    countries = getCountriesData(countries: []);
  }

  List<Country> reload(List<String>? chosen_strings) {
    List<Country> filteredList = countries.where((country) {
      return (chosen_strings!.where((i) => i.toString().toLowerCase().contains(country.alpha2Code!.toLowerCase())).isNotEmpty);
    }).toList();

    return filteredList;
  }

  List<Country> getCountriesData({required List<String>? countries}) {
    List jsonList = Countries.countryList;

    if (countries == null || countries.isEmpty) {
      return jsonList.map((country) => Country.fromJson(country)).toList();
    }
    List filteredList = jsonList.where((country) {
      return countries.contains(country[PropertyName]);
    }).toList();

    return filteredList.map((country) => Country.fromJson(country)).toList();
  }

  Country getCountryByDialCode(String dialCode) {
    Country result;
    //  List<Country> countries = getCountriesData(countries: []);
    result = countries.where((e) => e.dialCode!.toLowerCase().contains(dialCode)).first;
    //  log(countries.where((e) => e.dialCode!.toLowerCase().contains(dialCode)));
    return result;
  }
}
