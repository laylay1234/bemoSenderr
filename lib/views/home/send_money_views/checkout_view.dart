import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/utilities/clipers/ticket_clipper.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/widgets/common/dashed_lines_widget.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/snackbars/error_occured_snackbar.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../constants/format.dart';
import '../../../entities/exchange_data_entity.dart';

class CheckOutView extends StatelessWidget {
  static const String id = '/check-out-view';

  const CheckOutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    // Rx<bool> tmp = false.obs;
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Obx(() {
      DeliveryMethod selectedMethod = sendMoneyController.selectedCollectMethod.value;
      String selectedMethodCode = selectedMethod.code!;
      bool isBankTransfer = selectedMethodCode.toLowerCase().contains('bank');
      bool isCashPickup = selectedMethodCode.toLowerCase().contains('cash');
      return Scaffold(
        appBar: XemoAppBar(leading: true),
        bottomSheet: null,
        backgroundColor: Get.theme.primaryColorLight,
        body: SingleChildScrollView(
          child: Column(
            children: [
              isBankTransfer
                  ? Container(
                      margin: EdgeInsets.only(top: 0.05.sh, left: 0.042.sw, right: 0.028.sw),
                      child: ClipPath(
                        clipper: TicketBankTransferClipper(),
                        child: Container(
                          width: 343.w,
                          height: 640.h,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white),
                          child: Container(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 56.w,
                                    ),
                                    Column(
                                      children: [
                                        Text('send.money.WantToSend'.tr,
                                            textAlign: TextAlign.center,
                                            style: XemoTypography.bodySmallSemiBold(context)!.copyWith(fontWeight: FontWeight.w600)),
                                        Container(
                                          height: 35.h,
                                          margin: EdgeInsets.only(top: 8.h),
                                          padding: EdgeInsets.only(right: 6.w, left: 6.w),
                                          constraints: BoxConstraints(minWidth: 101.w),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)), color: kLightDisplayPrimaryAction),
                                          child: Center(
                                              child: Text(formatByCurrency(sendMoneyController.sendEditingController.value.text, '') + " \$",
                                                  //sendMoneyController.sendEditingController.value.text + ' ' + "\$",
                                                  style: XemoTypography.headLine5BoldWhite(context))),
                                        ),
                                        SizedBox(
                                          height: 56.h,
                                          child: Center(
                                              child: Text(
                                            sendMoneyController.receiveAmount.value.toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                                                ' ' +
                                                sendMoneyController.destinationCurrency!.value.iso_code.toUpperCase(),
                                            style: XemoTypography.captionSemiBoldSecondary(context)!.copyWith(fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        sendMoneyController.editAmountAndDilveryMethodState.enter();
                                        sendMoneyController.nextStep();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 8, right: 2, top: 8, bottom: 8),
                                        width: 56.w,
                                        height: 49.h,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF05137),
                                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), offset: const Offset(0, 3), blurRadius: 3)],
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
                                        child: const Icon(
                                          FontAwesomeIcons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 0.h,
                                ),
                                //dashed lines widget
                                Container(margin: EdgeInsets.only(bottom: 5.h, left: 18.w, top: 0), child: const DashedLinesWidget()),
                                SizedBox(
                                  width: 45.w,
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 35.w,
                                    ),
                                    Row(
                                      children: [
                                        ClipOval(
                                          child: SvgPicture.asset(
                                            "assets/flags/${sendMoneyController.selectedDestinationCountry!.value.iso_code.toLowerCase()}.svg",
                                            width: 38.w,
                                            height: 38.h,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(bottom: 0.0),
                                                width: 150.w,
                                                child: Text(
                                                  sendMoneyController.selectedReceiver.value!.first_name +
                                                      ' ' +
                                                      sendMoneyController.selectedReceiver.value!.last_name,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: XemoTypography.bodySemiBold(context),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 28.h,
                                                child: Center(
                                                    child: Text(
                                                  sendMoneyController.selectedReceiver.value != null
                                                      ? FormatPlainTextPhoneNumberByNumber().format(
                                                          sendMoneyController.selectedReceiver.value!.phone_number.startsWith('+')
                                                              ? sendMoneyController.selectedReceiver.value!.phone_number
                                                              : ('+' + sendMoneyController.selectedReceiver.value!.phone_number))
                                                      : '',
                                                  style:
                                                      XemoTypography.bodyDefault(context)!.copyWith(color: const Color(0xFF9B9B9B), fontSize: 16.sp),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        sendMoneyController.editReceiverState.enter();
                                        sendMoneyController.nextStep();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 8, right: 2, top: 8, bottom: 8),
                                        width: 56.w,
                                        height: 49.h,
                                        decoration: BoxDecoration(
                                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), offset: const Offset(0, 3), blurRadius: 3)],
                                            color: const Color(0xFFF05137),
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
                                        child: const Icon(
                                          FontAwesomeIcons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 19,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 45.w,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'contact.accountNumber'.tr.capitalize!,
                                          style: XemoTypography.bodySmallSemiBald(context)!.copyWith(color: kLightDisplayPrimaryAction),
                                        ),
                                        Container(
                                          padding: sendMoneyController.selectedReceiver.value!.account_number!.length > 12
                                              ? EdgeInsets.only(top: 29.h)
                                              : EdgeInsets.only(top: 8.h),
                                          child: Text(
                                            'SWIFT',
                                            style: XemoTypography.bodySmallSemiBald(context)!.copyWith(color: kLightDisplayPrimaryAction),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(left: 16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            // padding: const EdgeInsets.only(left: 8.0),
                                            child: sendMoneyController.selectedReceiver.value!.account_number!.length > 12
                                                ? Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        sendMoneyController.selectedReceiver.value!.account_number!.substring(0, 12),
                                                        style: XemoTypography.bodySmallSemiBald(context)!.copyWith(color: kLightDisplayInfoText),
                                                      ),
                                                      Text(
                                                        sendMoneyController.selectedReceiver.value!.account_number!.substring(12),
                                                        style: XemoTypography.bodySmallSemiBald(context)!.copyWith(color: kLightDisplayInfoText),
                                                      )
                                                    ],
                                                  )
                                                : Text(
                                                    sendMoneyController.selectedReceiver.value!.account_number!,
                                                    style: XemoTypography.bodySmallSemiBald(context)!.copyWith(color: kLightDisplayInfoText),
                                                  ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 10.h),
                                            child: Text(
                                              sendMoneyController.selectedReceiver.value!.bank_swift_code!,
                                              textAlign: TextAlign.start,
                                              style: XemoTypography.bodySmallSemiBald(context)!.copyWith(color: kLightDisplayInfoText),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 30.w,
                                      ),
                                      SizedBox(
                                        width: 190.w,
                                        height: 66.h,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                  height: 52.h,
                                                  width: 153.5,
                                                  margin: const EdgeInsets.only(right: 3.0, left: 3.0),
                                                  padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: kLightDisplayPrimaryAction, width: 1.3),
                                                      borderRadius: const BorderRadius.all(Radius.circular(35)),
                                                      color: Colors.white),
                                                  child: Center(
                                                    child: Text(
                                                      selectedMethod.getCurrentName(),
                                                      style: XemoTypography.captionSemiBoldPrimary(context)!
                                                          .copyWith(color: kLightDisplayPrimaryAction, fontWeight: FontWeight.w600),
                                                    ),
                                                  )),
                                            ),
                                            Positioned(
                                              left: 0.05.sw,
                                              top: 7,
                                              // child: SvgPicture.asset(
                                              //   'assets/xemo/icon-bank_transfer_small_active_3x.svg',
                                              //   height: 50.h,
                                              //   width: 50.w,
                                              // ),
                                              child: selectedMethod.getImageWidget(
                                                type: DeliveryMethodImageType.active,
                                                width: 48.w,
                                                height: 48.h,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          sendMoneyController.editAmountAndDilveryMethodState.enter();
                                          sendMoneyController.nextStep();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 8, right: 2, top: 8, bottom: 8),
                                          width: 56.w,
                                          height: 49.h,
                                          decoration: BoxDecoration(
                                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), offset: const Offset(0, 3), blurRadius: 3)],
                                              color: const Color(0xFFF05137),
                                              borderRadius:
                                                  const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: const Radius.circular(30))),
                                          child: const Icon(
                                            FontAwesomeIcons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Container(height: 0, color: Get.theme.primaryColorLight),
                                Container(
                                  margin: EdgeInsets.only(top: 25.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 45.w,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'send.money.totalIncludingFees'.tr,
                                            style: XemoTypography.captionSemiBold(context)!.copyWith(fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            height: 40.h,
                                            margin: EdgeInsets.only(top: 8.h),
                                            padding: const EdgeInsets.all(5.0),
                                            constraints: BoxConstraints(minWidth: 101.w),
                                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.black),
                                            child: Center(
                                                child: Text(
                                                    formatByCurrency(
                                                            sendMoneyController.totalAmount.value.toStringAsFixed(AMOUNT_FORMAT_DECIMALS), '') +
                                                        ' \$',
                                                    // sendMoneyController.totalAmount.value.toStringAsFixed(2) + ' \$',
                                                    style: XemoTypography.buttonWhiteDefault(context))),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width: 56.w,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Theme(
                                        data: Theme.of(context).copyWith(
                                          unselectedWidgetColor: kLightDisplayPrimaryAction,
                                        ),
                                        child: Checkbox(
                                          // title: Text('controller.mapValues[index].key'),
                                          //  value: sendMoneyController.isBankInfoConfirmed.value,
                                          value: sendMoneyController.isBankInfoConfirmed.value,
                                          onChanged: (val) {
                                            if (val != null) {
                                              // sendMoneyController.isBankInfoConfirmed.value = val;
                                              sendMoneyController.isBankInfoConfirmed.value = val;
                                            }
                                          },
                                          side: MaterialStateBorderSide.resolveWith(
                                              (states) => const BorderSide(width: 2, color: kLightDisplayPrimaryAction)),
                                          activeColor: Colors.white,
                                          checkColor: kLightDisplayPrimaryAction,
                                          focusColor: kLightDisplayPrimaryAction,
                                          hoverColor: kLightDisplayPrimaryAction,
                                        ),
                                      ),
                                      Container(
                                        width: 0.6.sw,
                                        //height: 40,
                                        child: Text(
                                          'send.money.checkout.iConfirmDataDetails'.tr,
                                          maxLines: 2,
                                          overflow: TextOverflow.visible,
                                          style: XemoTypography.bodySmallSemiBold(context)!.copyWith(color: kLightDisplayInfoText),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 10.h,
                                ),
                                Opacity(
                                  opacity: sendMoneyController.isBankInfoConfirmed.value ? 1 : 0.5,
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (sendMoneyController.isBankInfoConfirmed.value) {
                                        try {
                                          Get.dialog(
                                              WillPopScope(
                                                //no going back :)
                                                onWillPop: () {
                                                  return Future.value(false);
                                                },
                                                child: Center(
                                                  child: RotatedSpinner(
                                                    spinnerColor: SpinnerColor.GREEN,
                                                    height: 45,
                                                    width: 45,
                                                  ),
                                                ),
                                              ),
                                              barrierDismissible: false);
                                          await sendMoneyController.sendMoneyOperation();
                                          //sendMoneyController.congratState.enter();
                                          Get.back();
                                          sendMoneyController.depositState.enter();
                                          //
                                          sendMoneyController.nextStep();
                                        } catch (e) {
                                          if (Get.isOverlaysOpen) {
                                            Get.back();
                                          }
                                          //startWarningSnackbar();
                                          startErrorOccuredSnackbar();
                                        }
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 12.w, right: 12.w, bottom: 20),
                                      height: 55.h,
                                      decoration: BoxDecoration(
                                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), offset: const Offset(0, 3), blurRadius: 3)],
                                          color: kLightDisplaySecondaryBackgroundColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(12))),
                                      child: Center(
                                          child: Text(
                                        'send.money.sendMoney'.tr.toUpperCase(),
                                        style: XemoTypography.buttonAllCapsWhite(context),
                                      )),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 5.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 0.1.sh, left: 0.042.sw, right: 0.028.sw),
                      child: ClipPath(
                        clipper: TicketClipper(),
                        child: Container(
                          width: 343.w,
                          height: 480.h,
                          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white),
                          child: Container(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 56.w,
                                    ),
                                    Column(
                                      children: [
                                        Text('send.money.WantToSend'.tr,
                                            textAlign: TextAlign.center,
                                            style: XemoTypography.bodySmallSemiBold(context)!.copyWith(fontWeight: FontWeight.w600)),
                                        Container(
                                          height: 35.h,
                                          margin: EdgeInsets.only(top: 8.h),
                                          padding: EdgeInsets.only(right: 6.w, left: 6.w),
                                          constraints: BoxConstraints(minWidth: 101.w),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(5)), color: kLightDisplayPrimaryAction),
                                          child: Center(
                                              child: Text(formatByCurrency(sendMoneyController.sendEditingController.value.text, '') + " \$",
                                                  //sendMoneyController.sendEditingController.value.text + ' ' + "\$",
                                                  style: XemoTypography.headLine5BoldWhite(context))),
                                        ),
                                        SizedBox(
                                          height: 35.h,
                                          child: Center(
                                              child: Text(
                                            sendMoneyController.receiveAmount.value.toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                                                ' ' +
                                                sendMoneyController.destinationCurrency!.value.iso_code.toUpperCase(),
                                            style: XemoTypography.captionSemiBoldSecondary(context)!.copyWith(fontWeight: FontWeight.w500),
                                          )),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        sendMoneyController.editAmountAndDilveryMethodState.enter();
                                        sendMoneyController.nextStep();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 8, right: 2, top: 8, bottom: 8),
                                        width: 56.w,
                                        height: 49.h,
                                        decoration: BoxDecoration(
                                            color: Color(0xFFF05137),
                                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), offset: const Offset(0, 3), blurRadius: 3)],
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
                                        child: const Icon(
                                          FontAwesomeIcons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 0.h,
                                ),
                                //dashed lines widget
                                Container(margin: EdgeInsets.only(bottom: 0.h, left: 18.w, top: 7.0), child: const DashedLinesWidget()),
                                Container(
                                  width: 45.w,
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 35.w,
                                    ),
                                    Row(
                                      children: [
                                        ClipOval(
                                          child: SvgPicture.asset(
                                            "assets/flags/${sendMoneyController.selectedDestinationCountry!.value.iso_code.toLowerCase()}.svg",
                                            width: 38.w,
                                            height: 38.h,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 0.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(bottom: 0.0),
                                                width: 150.w,
                                                child: Text(
                                                  (sendMoneyController.selectedReceiver.value?.first_name ?? '') +
                                                      ' ' +
                                                      (sendMoneyController.selectedReceiver.value?.last_name ?? ''),
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: XemoTypography.bodySemiBold(context),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 28.h,
                                                child: Center(
                                                    child: Text(
                                                  sendMoneyController.selectedReceiver.value != null
                                                      ? FormatPlainTextPhoneNumberByNumber().format(
                                                          sendMoneyController.selectedReceiver.value!.phone_number.startsWith('+')
                                                              ? sendMoneyController.selectedReceiver.value!.phone_number
                                                              : ('+' + sendMoneyController.selectedReceiver.value!.phone_number))
                                                      : '',
                                                  style:
                                                      XemoTypography.bodyDefault(context)!.copyWith(color: const Color(0xFF9B9B9B), fontSize: 16.sp),
                                                )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        sendMoneyController.editReceiverState.enter();
                                        sendMoneyController.nextStep();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.only(left: 8, right: 2, top: 8, bottom: 8),
                                        width: 56.w,
                                        height: 49.h,
                                        decoration: BoxDecoration(
                                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), offset: const Offset(0, 3), blurRadius: 3)],
                                            color: const Color(0xFFF05137),
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
                                        child: const Icon(
                                          FontAwesomeIcons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 14.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 30.w,
                                      ),
                                      Container(
                                        width: 190.w,
                                        height: 66.h,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                  height: 52.h,
                                                  width: 153.5,
                                                  margin: const EdgeInsets.only(right: 3.0, left: 3.0),
                                                  padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(color: kLightDisplayPrimaryAction, width: 1.3),
                                                      borderRadius: const BorderRadius.all(Radius.circular(35)),
                                                      color: Colors.white),
                                                  child: Center(
                                                    child: Text(
                                                      selectedMethod.getCurrentName(),
                                                      style: XemoTypography.captionSemiBoldPrimary(context)!
                                                          .copyWith(color: kLightDisplayPrimaryAction, fontWeight: FontWeight.w600),
                                                    ),
                                                  )),
                                            ),
                                            Positioned(
                                              left: getImagePositioning('left', selectedMethodCode),
                                              top: getImagePositioning('top', selectedMethodCode),
                                              child: selectedMethod.getImageWidget(
                                                type: DeliveryMethodImageType.active,
                                                width: getImageDimensions('width', selectedMethodCode),
                                                height: getImageDimensions('height', selectedMethodCode),
                                              ),
                                            )
                                            // isCashPickup
                                            //     ? Positioned(
                                            //         left: 3,
                                            //         top: 0,
                                            //         // child: SvgPicture.asset(
                                            //         //   'assets/xemo/icon-cash_pickup_active_3x.svg',
                                            //         //   height: 66.h,
                                            //         //   width: 66.w,
                                            //         // ),
                                            //         child: SvgPicture.asset(
                                            //           'assets/xemo/icon-cash_pickup_active_3x.svg',
                                            //           height: 66.h,
                                            //           width: 66.w,
                                            //         ),
                                            //       )
                                            //     : Positioned(
                                            //         left: 20,
                                            //         top: 5,
                                            //         // child: SvgPicture.asset(
                                            //         //   'assets/xemo/mobile_network_delivery.svg',
                                            //         //   height: 60.h,
                                            //         //   fit: BoxFit.fill,
                                            //         //   width: 50.w,
                                            //         // ),
                                            //         child: SvgPicture.asset(
                                            //           'assets/xemo/mobile_network_delivery.svg',
                                            //           height: 60.h,
                                            //           fit: BoxFit.fill,
                                            //           width: 50.w,
                                            //         ),
                                            //       ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          sendMoneyController.editAmountAndDilveryMethodState.enter();
                                          sendMoneyController.nextStep();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 8, right: 2, top: 8, bottom: 8),
                                          width: 56.w,
                                          height: 49.h,
                                          decoration: BoxDecoration(
                                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), offset: const Offset(0, 3), blurRadius: 3)],
                                              color: const Color(0xFFF05137),
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
                                          child: const Icon(
                                            FontAwesomeIcons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Container(height: 0, color: Get.theme.primaryColorLight),
                                Container(
                                  margin: EdgeInsets.only(top: 25.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 56.w,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'send.money.totalIncludingFees'.tr,
                                            style: XemoTypography.captionSemiBold(context)!.copyWith(fontWeight: FontWeight.w500),
                                          ),
                                          Container(
                                            height: 40.h,
                                            margin: EdgeInsets.only(top: 8.h),
                                            padding: const EdgeInsets.all(5.0),
                                            constraints: BoxConstraints(minWidth: 101.w),
                                            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Colors.black),
                                            child: Center(
                                                child: Text(formatByCurrency(sendMoneyController.totalAmount.value.toString(), '') + ' \$',
                                                    // sendMoneyController.totalAmount.value.toStringAsFixed(2) + ' \$',
                                                    style: XemoTypography.buttonWhiteDefault(context))),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        width: 56.w,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 5.h,
                                ),
                                Container(
                                  height: 5.h,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    try {
                                      Get.dialog(
                                          WillPopScope(
                                            //no going back :)
                                            onWillPop: () {
                                              return Future.value(false);
                                            },
                                            child: Center(
                                              child: RotatedSpinner(
                                                spinnerColor: SpinnerColor.GREEN,
                                                height: 45,
                                                width: 45,
                                              ),
                                            ),
                                          ),
                                          barrierDismissible: false);
                                      await sendMoneyController.sendMoneyOperation();
                                      //sendMoneyController.congratState.enter();
                                      Get.back();
                                      sendMoneyController.depositState.enter();
                                      //
                                      sendMoneyController.nextStep();
                                    } catch (e) {
                                      if (Get.isOverlaysOpen) {
                                        Get.back();
                                      }
                                      //startWarningSnackbar();
                                      startErrorOccuredSnackbar();
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(left: 12.w, right: 12.w),
                                    height: 55.h,
                                    decoration: BoxDecoration(
                                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), offset: const Offset(0, 3), blurRadius: 3)],
                                        color: kLightDisplaySecondaryBackgroundColor,
                                        borderRadius: const BorderRadius.all(Radius.circular(12))),
                                    child: Center(
                                        child: Text(
                                      'send.money.sendMoney'.tr.toUpperCase(),
                                      style: XemoTypography.buttonAllCapsWhite(context),
                                    )),
                                  ),
                                ),
                                Container(
                                  height: 1.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              GestureDetector(
                onTap: () {
                  Get.back();
                  sendMoneyController.sendMoneyDoneState.enter();
                  sendMoneyController.nextStep();
                  sendMoneyController.clearSendMoneyData();
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 18.0),
                  height: 64.h,
                  width: 64.w,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF05137),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  String formatByCurrency(String number, String currency_iso) {
    double amount = double.parse(number);
    String formated = NumberFormat.simpleCurrency(
      name: currency_iso.toUpperCase(),
    ).format(amount);
    return formated;
  }

  double getImagePositioning(String position, String methodCode) {
    switch (position) {
      case 'left':
        if (methodCode.toLowerCase().contains('cash')) return 10;
        return 15;
      case 'top':
        if (methodCode.toLowerCase().contains('cash')) return 0;
        return 2;
      default:
        return 0;
    }
  }

  double getImageDimensions(String axis, String methodCode) {
    switch (axis) {
      case 'width':
        if (methodCode.toLowerCase().contains('cash')) return 66.w;
        return 60.w;
      case 'height':
        if (methodCode.toLowerCase().contains('cash')) return 66.h;
        return 60.h;
      default:
        return 0;
    }
  }
}
