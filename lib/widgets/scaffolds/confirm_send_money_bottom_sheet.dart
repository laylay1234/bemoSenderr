import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../constants/format.dart';

void confirmSendMoneyBottomSheet() {
  Get.bottomSheet(ConfirmSendMoneySheetWidget());
}

// ignore: must_be_immutable
class ConfirmSendMoneySheetWidget extends StatelessWidget {
  ConfirmSendMoneySheetWidget({Key? key}) : super(key: key);
  var f = NumberFormat('#.00##', 'en_Us');

  @override
  Widget build(BuildContext context) {
    String lang = Get.locale!.languageCode.toLowerCase();
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    return Container(
      //height: 0.9.sh,
      color: Colors.white,
      padding: EdgeInsets.only(top: 15.h, right: 12.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(
                      flex: 5,
                    ),
                    Text(
                      'send.money.checkout.transferConfirmation'.tr,
                      style: XemoTypography.bodySmall(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        size: 50,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                //money to send
                Padding(
                  padding: EdgeInsets.only(top: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.w),
                        child: Text('send.money.simulation.amountSent'.tr, style: XemoTypography.bodySmallSecondary(context)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15.w),
                        child: Text(
                          "" +
                              formatByCurrency(sendMoneyController.sendEditingController.value.text,
                                  sendMoneyController.originCurrency.value!.iso_code.toUpperCase()) +
                              " " +
                              sendMoneyController.originCurrency.value!.iso_code.toUpperCase(),
                          style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(fontSize: 14.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.w),
                        child: Text('send.money.simulation.exchangeRate'.tr, style: XemoTypography.bodySmallSecondary(context)),
                      ),
                      Text(
                        formatByCurrency('1', sendMoneyController.originCurrency.value!.iso_code.toUpperCase()) +
                            ' ' +
                            sendMoneyController.originCurrency.value!.iso_code.toUpperCase() +
                            " = " +
                            (sendMoneyController.exchangeRate.value.rate != null
                                ? double.parse(sendMoneyController.exchangeRate.value.rate!).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS)
                                : '') +
                            " " +
                            sendMoneyController.destinationCurrency!.value.iso_code.toString().toUpperCase(),
                        textAlign: TextAlign.center,
                        style: XemoTypography.bodySemiBoldComplementry(context)!.copyWith(fontSize: 14.sp),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.w),
                        child: Text('send.money.simulation.amountSent'.tr, style: XemoTypography.bodySmallSecondary(context)),
                      ),
                      Text(
                        sendMoneyController.receiveEditingController.value.text +
                            " ${sendMoneyController.destinationCurrency!.value.iso_code.toUpperCase()}",
                        textAlign: TextAlign.center,
                        style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(fontSize: 14.sp),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.w),
                        width: lang == 'fr' ? 0.5.sw : 0.6.sw,
                        child: Text('send.money.simulation.fees'.tr + ' (' + sendMoneyController.selectedCollectMethod.value.getCurrentName() + ')',
                            maxLines: 2, style: XemoTypography.bodySmallSecondary(context)),
                      ),
                      Text(
                        "+\$" +
                            sendMoneyController.selectedCollectMethod.value.fee! +
                            " ${sendMoneyController.originCurrency.value!.iso_code.toUpperCase()}",
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: XemoTypography.bodySemiBoldComplementry(context)!.copyWith(fontSize: 14.sp),
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15.w, left: 16.w, right: 1.w),
                    child: Container(
                      height: 2,
                      color: const Color(0x39393940),
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 7.w, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15.w),
                        child: Text('common.total_to_pay'.tr, style: XemoTypography.bodySmallSecondary(context)),
                      ),
                      Text(
                        "" +
                            formatByCurrency(sendMoneyController.totalAmount.value.toString(), sendMoneyController.originCurrency.value!.iso_code) +
                            " ${sendMoneyController.originCurrency.value!.iso_code.toUpperCase()}",
                        textAlign: TextAlign.center,
                        style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(fontSize: 14.sp),
                      )
                    ],
                  ),
                ),
              ],
            ),
            /*
            Container(
              margin: EdgeInsets.only(bottom: 15.h, left: 12.0, top: 15.h),
              child: (appSettings["legislation"] as Map<String, dynamic>).containsKey(target_country_iso.toUpperCase())
                  ? Text(
                      (appSettings["legislation"] as Map<String, dynamic>)[target_country_iso.toUpperCase()][Get.locale!.languageCode.toLowerCase()],
                      textAlign: TextAlign.center,
                      style: XemoTypography.captionDefault(context)!.copyWith(color: kLightComplementryAction),
                    )
                  : Text(
                      (appSettings["legislation"] as Map<String, dynamic>)['default'][Get.locale!.languageCode.toLowerCase()] as String,
                      textAlign: TextAlign.center,
                      style: XemoTypography.captionDefault(context)!.copyWith(color: kLightComplementryAction),
                    ),
            ),
            */
            GestureDetector(
              onTap: () {
                log('clicked');
                sendMoneyController.selectReceiverState.enter();
                sendMoneyController.nextStep();
              },
              child: Container(
                //width: 195.w,
                height: 58.h,
                margin: EdgeInsets.only(bottom: 22.w, left: 12.0, top: 8.0),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: kLightDisplayPrimaryAction,
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
                child: Center(
                  child: Text(
                    'common.confirm'.tr.toUpperCase(),
                    style: XemoTypography.buttonAllCapsWhite(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatByCurrency(String number, String currency_iso) {
    double amount = double.parse(number);
    String formated = NumberFormat.simpleCurrency(
      name: currency_iso.toUpperCase(),
    ).format(amount);
    return formated;
  }
}
