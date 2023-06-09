import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/models/ModelProvider.dart';

import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_model.dart' as cm;

import '../../utils/countries_tr_helper.dart';

// ignore: must_be_immutable
class CountryReceptionWidget extends StatelessWidget {
  Country? availableCountry;
  bool? fromContact = false;
  CountryReceptionWidget({Key? key, this.availableCountry, this.fromContact = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    final ContactsController contactsController = Get.find<ContactsController>();
    cm.Country? tmp = CountriesTrHelper().getCountryTrDataByIsoCode(availableCountry!.iso_code.toLowerCase());
    return Obx(() {
      return Column(
        children: [
          Opacity(
            opacity: (availableCountry!.active) ? 1 : 0.2,
            child: Container(
              height: 85,
              width: 85,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: Offset(0, 3))]),
              child: ClipOval(
                  child: (availableCountry!.active)
                      ? SvgPicture.asset(
                          'assets/flags/${availableCountry!.iso_code.toLowerCase()}.svg',
                          fit: BoxFit.fill,
                        )
                      : SizedBox(
                          height: 80.h,
                          child: Stack(
                            alignment: Alignment.center,
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              SvgPicture.asset(
                                "assets/flags/${availableCountry!.iso_code.toLowerCase()}.svg",
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: SvgPicture.asset(
                                  'assets/xemo/soon_flag.svg',
                                  height: 60.h,
                                  width: 45.w,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        )),
            ),
          ),
          Opacity(
            opacity: (fromContact ?? false)
                ? 1
                : !(availableCountry!.active)
                    ? 0.2
                    : 1,
            child: Container(
              margin: EdgeInsets.only(top: 3.h),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: fromContact!
                      ? contactsController.selectedTempoCountry!.value != null
                          ? contactsController.selectedTempoCountry!.value!.equals(availableCountry!)
                              ? kLightDisplayPrimaryAction
                              : const Color(0xFFE8E8E8)
                          : const Color(0xFFE8E8E8)
                      : sendMoneyController.selectedTempoCountry!.value.equals(availableCountry!)
                          ? kLightDisplayPrimaryAction
                          : const Color(0xFFE8E8E8)),
              padding: EdgeInsets.only(left: 12.w, right: 12.w, top: 4.0, bottom: 4),
              child: Center(
                child: Text(
                  tmp == null ? availableCountry!.name.tr : CountriesTrHelper().getCountryName(tmp)!,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Get.textTheme.headline3!.copyWith(
                      fontSize: 15.5.sp,
                      fontWeight: FontWeight.bold,
                      color: fromContact!
                          ? contactsController.selectedTempoCountry!.value != null
                              ? contactsController.selectedTempoCountry!.value!.equals(availableCountry!)
                                  ? Colors.white
                                  : Colors.black
                              : Colors.black
                          : sendMoneyController.selectedTempoCountry!.value.equals(availableCountry!)
                              ? Colors.white
                              : Colors.black),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
