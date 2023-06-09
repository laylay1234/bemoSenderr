import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_model.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/utils/test/test_helper.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/utils/util.dart';

/// Creates a list of Countries with a search textfield.
// ignore: must_be_immutable
class CountrySearchListWidget extends StatefulWidget {
  final List<Country> countries;
  final InputDecoration? searchBoxDecoration;
  final String? locale;
  final ScrollController? scrollController;
  final bool autoFocus;
  final bool? showFlags;
  final bool? useEmoji;
  bool showCountryCode = true;
  CountrySearchListWidget(this.countries, this.locale,
      {Key? key, this.searchBoxDecoration, this.scrollController, this.showCountryCode = true, this.showFlags, this.useEmoji, this.autoFocus = false})
      : super(key: key);

  @override
  _CountrySearchListWidgetState createState() => _CountrySearchListWidgetState();
}

class _CountrySearchListWidgetState extends State<CountrySearchListWidget> {
  final TextEditingController _searchController = TextEditingController();
  late List<Country> filteredCountries;

  @override
  void initState() {
    filteredCountries = filterCountries();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Returns [InputDecoration] of the search box
  InputDecoration getSearchBoxDecoration() {
    return widget.searchBoxDecoration ??
        InputDecoration(
          labelText: 'Search by country name or dial code',
          prefixStyle: Get.textTheme.headline2!.copyWith(color: kLightDisplayPrimaryAction, fontSize: 16, fontWeight: FontWeight.w500),
          contentPadding: EdgeInsets.only(left: 3.w, top: 8.0),
          fillColor: Colors.transparent,
          filled: true,
          focusedErrorBorder: errorBorderDecoration,
          errorBorder: errorBorderDecoration,
          enabledBorder: borderDecoration,
          border: borderDecoration,
          disabledBorder: borderDecoration,
          focusedBorder: primayColorborderDecoration,
        );
  }

  /// Filters the list of Country by text from the search box.
  List<Country> filterCountries() {
    final value = _searchController.text.trim();

    if (value.isNotEmpty) {
      return widget.countries
          .where((Country country) => ((country.alpha3Code!.toLowerCase().contains(value.toLowerCase()) ||
              (country.alpha2Code!.toLowerCase().contains(value.toLowerCase())) ||
              country.name!.toLowerCase().contains(value.toLowerCase()) ||
              getCountryName(country)!.toLowerCase().contains(value.toLowerCase()) ||
              country.dialCode!.contains(value.toLowerCase()))))
          .toList();
    }

    return widget.countries;
  }

  /// Returns the country name of a [Country]. if the locale is set and translation in available.
  /// returns the translated name.
  String? getCountryName(Country country) {
    if (Get.locale != null && country.nameTranslations != null) {
      String? translated = country.nameTranslations![Get.locale!.languageCode];
      if (translated != null && translated.isNotEmpty) {
        return translated;
      }
    }
    return country.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          child: TextFormField(
            key: const Key(TestHelper.CountrySearchInputKeyValue),
            decoration: getSearchBoxDecoration(),
            controller: _searchController,
            autofocus: widget.autoFocus,
            onChanged: (value) => setState(() => filteredCountries = filterCountries()),
          ),
        ),
        Container(
          height: 15.h,
        ),
        Flexible(
          child: ListView.builder(
            controller: widget.scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: filteredCountries.length,
            itemBuilder: (BuildContext context, int index) {
              Country country = filteredCountries[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(country);
                },
                behavior: HitTestBehavior.translucent,
                child: Container(
                  height: 55,
                  width: double.infinity,
                  key: Key(TestHelper.countryItemKeyValue(country.alpha2Code)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      widget.showFlags! ? _Flag(country: country, useEmoji: widget.useEmoji) : Container(),
                      widget.showCountryCode
                          ? Expanded(
                              flex: 3,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 14.0),
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text('${getCountryName(country)}', overflow: TextOverflow.ellipsis, textAlign: TextAlign.start)),
                            )
                          : Expanded(
                              flex: 3,
                              child: Container(
                                  margin: const EdgeInsets.only(left: 14.0),
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text('${getCountryName(country)}', overflow: TextOverflow.ellipsis, textAlign: TextAlign.start)),
                            ),
                      widget.showCountryCode
                          ? Expanded(
                              child: Container(
                                  // width: 100,
                                  margin: const EdgeInsets.only(left: 5.0),
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text('${country.dialCode ?? ''}',
                                      textDirection: TextDirection.ltr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start)),
                            )
                          : const SizedBox(
                              height: 0,
                              width: 0,
                            ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}

class _Flag extends StatelessWidget {
  final Country? country;
  final bool? useEmoji;

  const _Flag({Key? key, this.country, this.useEmoji}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return country != null
        ? Container(
            child: useEmoji!
                ? Text(
                    Utils.generateFlagEmojiUnicode(country?.alpha2Code ?? ''),
                    style: Theme.of(context).textTheme.headline5,
                  )
                : country?.flagUri != null
                    ? CircleAvatar(
                        backgroundImage: AssetImage(
                          country!.flagUri,
                          package: 'intl_phone_number_input',
                        ),
                      )
                    : const SizedBox.shrink(),
          )
        : const SizedBox.shrink();
  }
}
