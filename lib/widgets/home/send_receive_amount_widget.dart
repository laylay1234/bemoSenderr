// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/widgets/dialogs/select_country_dialog_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'dart:math' as math;
import '../../controllers/transaction_controller.dart';

class SendRecieveAmountWidget extends StatelessWidget {
  const SendRecieveAmountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    TransactionController transactionController = Get.find<TransactionController>();

    return Obx(() {
      return Container(
        height: 151.h,
        margin: EdgeInsets.only(left: 0.03.sw, right: 0.03.sw),
        child: Stack(
          children: [
            sendMoneyController.isSwaped.value == false
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 65.h,
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5)]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                  child: SvgPicture.asset(
                                "assets/flags/${sendMoneyController.originCountry.value!.iso_code.toLowerCase()}.svg",
                                height: 55.h,
                                width: 55.w,
                              )),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 0.04.sw, top: 8.h),
                              child: Text('send.money.iSend'.tr.capitalizeFirst!,
                                  overflow: TextOverflow.visible, textAlign: TextAlign.center, style: XemoTypography.captionDefault(context)),
                            ),
                          ),
                          Container(
                            width: 117.w,
                            height: 43.h,
                            child: TextField(
                              controller: sendMoneyController.sendEditingController.value,
                              enabled: !sendMoneyController.isSwaped.value,
                              textAlign: TextAlign.right,
                              style: XemoTypography.bodySmallSemiBald(context),
                              onChanged: (val) {
                                if (val.isNotEmpty) {
                                  sendMoneyController.calculateTotal();
                                  transactionController.checkAndHandleTransactionLimitsByUserInput();
                                } else {
                                  //sendMoneyController.sendEditingController.value.text = "";
                                  sendMoneyController.calculateTotal();
                                  transactionController.checkAndHandleTransactionLimitsByUserInput();
                                }
                              },
                              inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(top: 14, bottom: 12, left: 5, right: 5),

                                fillColor: kLightDisplayPrimaryAction,
                                filled: true,
                                //   counter: SizedBox.shrink(),
                                isDense: true,
                                suffixText: sendMoneyController.originCurrency.value!.short_sign.toUpperCase(),

                                suffixStyle: XemoTypography.bodySmallSemiBald(context),
                                border: const OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(const Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                disabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 65.h,
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5)]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 4.h),
                                width: 65.w,
                                height: 58.h,
                                child: Stack(
                                  children: [
                                    ClipOval(
                                        child: SvgPicture.asset(
                                      "assets/flags/${sendMoneyController.selectedDestinationCountry!.value.iso_code.toLowerCase()}.svg",
                                      height: 55.h,
                                      width: 55.w,
                                    )),
                                    Positioned(
                                      right: 0,
                                      left: 35.w,
                                      top: 18.h,
                                      child: GestureDetector(
                                        onTap: () async {
                                          //showDialog(context: context, builder: (context) => SelectCountryDialogWidget());
                                          await selectCountryDialog();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(35),
                                          ),
                                          child: Container(
                                            height: 20.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(boxShadow: [
                                              BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(1, 2))
                                            ], color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 1)),
                                            child: SvgPicture.asset(
                                              'assets/xemo/icon-dropdown.svg',
                                              height: 30.h,
                                              width: 30.w,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 0.01.sw, top: 8.h),
                              child: Text('send.money.sending'.tr.capitalizeFirst!,
                                  overflow: TextOverflow.visible, textAlign: TextAlign.center, style: XemoTypography.captionDefault(context)),
                            ),
                          ),
                          Container(
                            width: 117.w,
                            height: 43.h,
                            child: TextField(
                              enabled: sendMoneyController.isSwaped.value,
                              controller: sendMoneyController.receiveEditingController.value,
                              textAlign: TextAlign.right,
                              style: XemoTypography.bodySmallSemiBald(context),
                              inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              onChanged: (val) async {
                                await Future.wait([sendMoneyController.calculateTotal()]);
                                transactionController.checkAndHandleTransactionLimitsByUserInput();
                              },
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(top: 14, bottom: 12, left: 5, right: 5),
                                isDense: true,
                                fillColor: kLightDisplayPrimaryAction,
                                filled: true,
                                suffixText: sendMoneyController.destinationCurrency!.value.short_sign.toUpperCase(),
                                suffixStyle: XemoTypography.bodySmallSemiBald(context),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                disabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            sendMoneyController.isSwaped.value == true
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 65.h,
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5)]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                ClipOval(
                                    child: SvgPicture.asset(
                                  "assets/flags/${sendMoneyController.originCountry.value!.iso_code.toLowerCase()}.svg",
                                  height: 55.h,
                                  width: 55.w,
                                )),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 8.h, left: 0.03.sw),
                              alignment: Alignment.centerLeft,
                              // width: 0.39.sw,
                              //  height: 75.h,
                              child: Text('send.money.willReceive'.tr.capitalizeFirst!,
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: XemoTypography.captionDefault(context)),
                            ),
                          ),
                          SizedBox(
                            width: 117.w,
                            height: 43.h,
                            child: TextField(
                              controller: sendMoneyController.sendEditingController.value,
                              enabled: !sendMoneyController.isSwaped.value,
                              textAlign: TextAlign.right,
                              inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: XemoTypography.bodySmallSemiBald(context),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(top: 14, bottom: 12, left: 5, right: 5),
                                isDense: true,
                                fillColor: Get.theme.primaryColorLight,
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                suffixText: sendMoneyController.originCurrency.value!.short_sign.toUpperCase(),
                                suffixStyle: XemoTypography.bodySmallSemiBald(context),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                disabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 65.h,
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5)]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 65.w,
                                height: 58.h,
                                padding: EdgeInsets.only(top: 5.h),
                                child: Stack(
                                  children: [
                                    ClipOval(
                                        child: SvgPicture.asset(
                                      "assets/flags/${sendMoneyController.selectedDestinationCountry!.value.iso_code.toLowerCase()}.svg",
                                      height: 55.h,
                                      width: 55.w,
                                    )),
                                    Positioned(
                                      right: 0,
                                      left: 35.w,
                                      top: 18.h,
                                      child: GestureDetector(
                                        onTap: () async {
                                          //showDialog(context: context, builder: (context) => SelectCountryDialogWidget());
                                          await selectCountryDialog();
                                          //sendMoneyController.loadAndSetSendMoneyData();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(35),
                                          ),
                                          child: Container(
                                            height: 20.h,
                                            width: 30.w,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(-1, 1))
                                                ],
                                                border: Border.all(color: Colors.black, width: 1)),
                                            child: SvgPicture.asset(
                                              'assets/xemo/icon-dropdown.svg',
                                              height: 30.h,
                                              width: 30.w,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 0.02.sw, top: 8.h),
                              child: Text('send.money.willReceive'.tr.capitalizeFirst!,
                                  overflow: TextOverflow.visible, textAlign: TextAlign.center, style: XemoTypography.captionDefault(context)),
                            ),
                          ),
                          SizedBox(
                            width: 117.w,
                            height: 43.h,
                            child: TextField(
                              enabled: sendMoneyController.isSwaped.value,
                              controller: sendMoneyController.receiveEditingController.value,
                              textAlign: TextAlign.right,
                              style: XemoTypography.bodySmallSemiBald(context),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(top: 14, bottom: 12, left: 5, right: 5),
                                isDense: true,
                                fillColor: Get.theme.primaryColorLight,
                                filled: true,
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                suffixText: sendMoneyController.destinationCurrency!.value.short_sign.toUpperCase(),
                                suffixStyle: XemoTypography.bodySmallSemiBald(context),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                                disabledBorder: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            GestureDetector(
              onTap: () {
                sendMoneyController.isSwaped.value = !(sendMoneyController.isSwaped.value);
                sendMoneyController.calculateTotal();
                transactionController.checkAndHandleTransactionLimitsByUserInput();

                //log('hello');
              },
              child: Align(
                alignment: Alignment.center,
                child: ClipOval(
                  child: Container(
                      height: 40.h,
                      width: 40.w,
                      //  color: Get.theme.primaryColorLight,
                      child: SvgPicture.asset(
                        'assets/xemo/icon-amount_switch_3x.svg',
                        height: 40.h,
                        width: 40.w,
                      )),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange}) : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") && value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
