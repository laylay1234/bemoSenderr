import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_model.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/providers/country_provider.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/widgets/countries_search_list_widget.dart';

Future<Country?> showCountrySelectorDialog(BuildContext context) {
  return showDialog<Country>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) => AlertDialog(
      content: SizedBox(
        width: double.maxFinite,
        child: CountrySearchListWidget(
          CountryProvider().countries,
          Get.locale!.languageCode,
          showCountryCode: false,
          searchBoxDecoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: kLightDisplayPrimaryAction,
            ),
            //   prefixStyle: Get.textTheme.headline2!
            //       .copyWith(color: Get.theme.primaryColorLight, fontSize: 16, fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.only(left: 3.w, top: 8.0),
            fillColor: Colors.transparent,
            filled: true,
            focusedErrorBorder: errorBorderDecoration,
            errorBorder: errorBorderDecoration,
            enabledBorder: borderDecoration,
            border: borderDecoration,
            disabledBorder: borderDecoration,
            focusedBorder: primayColorborderDecoration,
          ),
          showFlags: true,
          useEmoji: true,
          autoFocus: false,
        ),
      ),
    ),
  );
}
