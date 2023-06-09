import 'dart:developer' as d;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/format.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/utils/countries_tr_helper.dart';
import 'package:mobileapp/views/flinks_views/flinks_success_view.dart';
import 'package:mobileapp/widgets/common/all_widgets.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/dialogs/countrt_selector_dialog_widget.dart';
import 'package:mobileapp/widgets/dialogs/select_country_dialog_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_model.dart' as cm;

class SendToWidget extends StatelessWidget {
  const SendToWidget({Key? key}) : super(key: key);
/*
GestureDetector(
                        onTap: () {
                          sendMoneyController.getDestinationCountriesByOriginCountry();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'your origin country is disactived or has no destinations',
                            textAlign: TextAlign.center,
                            style: XemoTypography.bodySmall(context),
                          ),
                        ),
                      ),
                      */
  @override
  Widget build(BuildContext context) {
    final SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    // sendMoneyController.loadAndSetSendMoneyData();
    // d.log(sendMoneyController.originCurrency.value.toString());
    Rx<cm.Country?> tmp = (null as cm.Country?).obs;

    return Obx(() {
      tmp.value = CountriesTrHelper().getCountryTrDataByIsoCode(sendMoneyController.selectedDestinationCountry!.value.iso_code.toLowerCase());
      String _countryName = CountriesTrHelper().getCountryName(tmp.value!)!;
      if (sendMoneyController.isNetworkAvailable.value) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("send.money.sendTo".tr, style: XemoTypography.titleH6BoldBlack(context)),
              GestureDetector(
                onTap: () async {
                  //   openEmailHasBeenSentDialog();
                  //Get.offNamed(FlinksSuccessView.id);
                  if (sendMoneyController.exchangeRate.value.isValid()) {
                    //
                  }
                  await selectCountryDialog(fromContact: false);
                  tmp.value =
                      CountriesTrHelper().getCountryTrDataByIsoCode(sendMoneyController.selectedDestinationCountry!.value.iso_code.toLowerCase());

                  // await sendMoneyController.loadAndSetSendMoneyData();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 18.0),
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
                  height: 50.h,
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 2))],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      sendMoneyController.exchangeRate.value.isValid()
                          ? ClipOval(
                              child: SvgPicture.asset(
                                'assets/flags/${sendMoneyController.selectedDestinationCountry!.value.iso_code.toLowerCase()}.svg',
                                height: 34.h,
                                width: 34.w,
                              ),
                            )
                          : Container(
                              height: 0,
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                          sendMoneyController.exchangeRate.value.isValid()
                              ? Text(
                                  // CountriesTrHelper().getCountryName(tmp.value!)!,
                                  _countryName,
                                  style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 14.sp),
                                )
                              : Container(
                                  height: 0,
                                ),
                          sendMoneyController.exchangeRate.value.isValid()
                              ? sendMoneyController.originCurrency.value != null
                                  ? Text(
                                      "\$1 ${sendMoneyController.originCurrency.value!.iso_code.toUpperCase()} = " +
                                          (sendMoneyController.exchangeRate.value.rate != null
                                              ? (double.parse(sendMoneyController.exchangeRate.value.rate!)
                                                      .toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                                                  " " +
                                                  (sendMoneyController.destinationCurrency != null
                                                      ? sendMoneyController.destinationCurrency!.value.iso_code.toUpperCase()
                                                      : ""))
                                              : ''),
                                      style: XemoTypography.captionLight(context)!.copyWith(fontSize: 10.sp),
                                    )
                                  : Container()
                              : Container(
                                  margin: EdgeInsets.only(bottom: 7.h),
                                  padding: EdgeInsets.only(left: 60.w, right: 60.w),
                                  child: RotatedSpinner(
                                    spinnerColor: SpinnerColor.GREEN,
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                        ]),
                      ),
                      GestureDetector(
                          onTap: () async {
                            //showDialog(context: context, builder: (context) => SelectCountryDialogWidget());
                            // openHelpAndSupportDialog();
                            if (sendMoneyController.exchangeRate.value.isValid()) {
                              await selectCountryDialog();
                              // if(sendMoneyController.isCancelCountrySelection == true) {

                              // }
                              //sendMoneyController.loadAndSetSendMoneyData();
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 4.w, right: 8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: Offset(1, 2))],
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black, width: 1)),
                              child: SvgPicture.asset(
                                'assets/xemo/icon-dropdown.svg',
                                height: 25.h,
                                width: 25.w,
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (sendMoneyController.isNetworkAvailable.value == false) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 30.0),
          child: Container(
            margin: const EdgeInsets.only(left: 18.0),
            padding: const EdgeInsets.all(5.0),
          ),
        );
      } else if (sendMoneyController.getCurrentState() == sendMoneyController.loadingState) {
        return Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 30.0),
            child: RotatedSpinner(
              spinnerColor: SpinnerColor.GREEN,
              height: 25,
              width: 25,
            ));
      } else {
        return Container();
      }
    });
  }
}
