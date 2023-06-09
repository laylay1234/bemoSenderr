import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:developer' as d;
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/widgets/dialogs/help_support_dialog_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../entities/exchange_data_entity.dart';
import '../../common/rotated_spinner.dart';

class CollectOrHelpWidget extends StatelessWidget {
  GlobalTransaction? transaction;
  CollectOrHelpWidget({Key? key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // d.log(transaction!.parameters!.collect_method!);
    // transaction = transaction!.copyWith(
    //    parameters: transaction!.parameters!.copyWith(collect_method: 'mobile'),
    //     status: GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS,
    //     collect_transactions: [
    //       CollectTransaction(collect_code: '', id: '', partner_name: '', status: 'collected', globalTransactionID: '', img_urls: [])
    //    ]);
    ProfileController profileController = Get.find<ProfileController>();
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    switch (transaction!.status) {
      case GlobalTransactionStatus.NEW:
        return Container(
          margin: EdgeInsets.only(bottom: 10.h, top: 15.h),
          child: Column(
            children: [
              Container(
                height: 42.h,
                width: 293.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  color: Color(0xFF333333),
                ),
                child: Center(
                    child: Text(
                  'transaction.waiting.for.funds'.tr,
                  style: XemoTypography.bodyBold(context),
                )),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Text(
                    'transaction.code.retrait'.tr.toUpperCase(),
                    style: XemoTypography.bodyBold(context)!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 14.sp, color: kLightDisplaySecondaryTextColor),
                  ),
                ),
              )
            ],
          ),
        );
      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        return Container(
          margin: EdgeInsets.only(bottom: 10.h, top: 15.h),
          child: Column(
            children: [
              Container(
                height: 42.h,
                width: 293.w,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  color: Color(0xFF333333),
                ),
                child: Center(
                    child: Text(
                  'transaction.waiting.for.funds'.tr,
                  style: XemoTypography.bodyBold(context),
                )),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h, left: 8.0, right: 8.0),
                child: Center(
                  child: Text(
                    'transaction.transferWillCanceled'.tr.replaceFirst('@', valueToFundingTime(profileController.appSettings['fundingExpTime'])),
                    textAlign: TextAlign.center,
                    style:
                        XemoTypography.bodySemiBold(context)!.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp, color: kLightDisplayErrorText),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Text(
                    'send.money.interactDetails'.tr.toUpperCase(),
                    style: XemoTypography.bodyBold(context)!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 14.sp, color: kLightDisplaySecondaryTextColor),
                  ),
                ),
              ),
              Container(
                height: 220.h,
                width: 343.w,
                margin: EdgeInsets.only(top: 13.h, bottom: 10.h),
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: profileController.appSettings['interacDeposit']['mailbox'].toString())).then((_) {
                            //ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text("Email address copied to clipboard")));
                            Get.snackbar(
                              '',
                              '',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                              padding: EdgeInsets.only(left: 40.w, right: 10.w, top: 10.h, bottom: 20.h),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              messageText: Text(
                                "send.money.interacCopied".trParams({'fieldName': 'send.money.interacEmail'.tr}),
                                style:
                                    XemoTypography.captionSemiBold(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor, fontSize: 13.sp),
                              ),
                              icon: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5)],
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/xemo/yxLogo-small.svg',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              backgroundColor: kLightDisplayToolTipBackgroundColor,
                            );
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5.h),
                          height: 62.h,
                          width: 311.w,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                              border: Border.all(width: 0.5, color: kLightDisplaySecondaryTextColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 18.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 3.h,
                                    ),
                                    Text(
                                      'send.money.interacEmail'.tr,
                                      style: XemoTypography.bodySemiBold(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                                    ),
                                    Container(
                                      height: 8.h,
                                    ),
                                    Text(
                                      profileController.appSettings['interacDeposit']['mailbox'],
                                      style: XemoTypography.bodyBold(context)!.copyWith(fontSize: 12.sp, color: Get.theme.primaryColorLight),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 18.w),
                                child: Text(
                                  'send.money.copy'.tr.toUpperCase(),
                                  style: XemoTypography.bodyAllCapsSecondary(context)!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: profileController.appSettings['interacDeposit']['secret']['question'])).then((_) {
                            Get.snackbar(
                              '',
                              '',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                              padding: EdgeInsets.only(left: 40.w, right: 10.w, top: 10.h, bottom: 20.h),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              messageText: Text(
                                "send.money.interacCopied".trParams({'fieldName': 'send.money.interacSecretQuestion'.tr}),
                                style:
                                    XemoTypography.captionSemiBold(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor, fontSize: 13.sp),
                              ),
                              icon: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5)],
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/xemo/yxLogo-small.svg',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              backgroundColor: kLightDisplayToolTipBackgroundColor,
                            );
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 13.h),
                          height: 62.h,
                          width: 311.w,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                              border: Border.all(width: 0.5, color: kLightDisplaySecondaryTextColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 18.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 3.h,
                                    ),
                                    Text(
                                      'send.money.interacSecretQuestion'.tr,
                                      style: XemoTypography.bodySemiBold(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                                    ),
                                    Container(
                                      height: 8.h,
                                    ),
                                    Text(
                                      profileController.appSettings['interacDeposit']['secret']['question'],
                                      style: XemoTypography.bodyBold(context)!.copyWith(fontSize: 12.sp, color: Get.theme.primaryColorLight),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 18.w),
                                child: Text(
                                  'send.money.copy'.tr.toUpperCase(),
                                  style: XemoTypography.bodyAllCapsSecondary(context)!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: profileController.appSettings['interacDeposit']['secret']['answer'])).then((_) {
                            Get.snackbar(
                              '',
                              '',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                              padding: EdgeInsets.only(left: 40.w, right: 10.w, top: 10.h, bottom: 20.h),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              messageText: Text(
                                "send.money.interacCopied".trParams({'fieldName': 'send.money.interacAnswer'.tr}),
                                style:
                                    XemoTypography.captionSemiBold(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor, fontSize: 13.sp),
                              ),
                              icon: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5)],
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/xemo/yxLogo-small.svg',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              backgroundColor: kLightDisplayToolTipBackgroundColor,
                            );
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 13.h),
                          height: 62.h,
                          width: 311.w,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                              border: Border.all(width: 0.5, color: kLightDisplaySecondaryTextColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 18.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 3.h,
                                    ),
                                    Text(
                                      'send.money.interacAnswer'.tr,
                                      style: XemoTypography.bodySemiBold(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                                    ),
                                    Container(
                                      height: 8.h,
                                    ),
                                    Text(
                                      profileController.appSettings['interacDeposit']['secret']['answer'],
                                      style: XemoTypography.bodyBold(context)!.copyWith(fontSize: 12.sp, color: Get.theme.primaryColorLight),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 18.w),
                                child: Text(
                                  'send.money.copy'.tr.toUpperCase(),
                                  style: XemoTypography.bodyAllCapsSecondary(context)!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return Container(
            width: 340.w,
            margin: EdgeInsets.only(bottom: 0.h, top: 0.h),
            padding: const EdgeInsets.all(5.0),
            child: transaction!.parameters!.collect_method!.replaceAll('-', '').replaceAll(' ', '_').toLowerCase().contains('bank')
                ? Column(
                    children: [
                      Container(
                        width: 340.w,
                        margin: EdgeInsets.only(bottom: 0.h, top: 5.h),
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //  height: 63.h,
                          margin: EdgeInsets.only(bottom: 5.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(9)),
                              color: (transaction!.collect_transactions != null)
                                  ? (transaction!.collect_transactions!.isNotEmpty)
                                      ? (transaction!.collect_transactions!.where((element) => element.status.toLowerCase() == 'collected'))
                                              .isNotEmpty
                                          ? const Color(0xFFCCCCCC)
                                          : const Color(0xFF333333)
                                      : const Color(0xFF333333)
                                  : const Color(0xFF333333)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(9), bottomLeft: Radius.circular(9)),
                                    child: sendMoneyController.deliveryMethods
                                        .where((e) => e.code!.toLowerCase().replaceAll('-', '').replaceAll(' ', '_').contains('bank'))
                                        .first
                                        .getImageWidget(type: DeliveryMethodImageType.txDetails, width: 65.w, height: 65.h)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            // transaction!.collect_transactions!.first.collect_code,
                                            'SWIFT',
                                            style: XemoTypography.bodyBold(context)!.copyWith(color: Colors.white, fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                                          child: Text(
                                            transaction!.receiver!.bank_swift_code!,
                                            // '555555555',
                                            style: XemoTypography.bodyBold(context)!.copyWith(color: const Color(0xFF20C9A7), fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 10.h,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            // transaction!.collect_transactions!.first.collect_code,
                                            'contact.accountNumber'.tr.toUpperCase(),
                                            style: XemoTypography.bodyBold(context)!.copyWith(color: Colors.white, fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                                          child: Text(
                                            transaction!.receiver!.account_number!,
                                            // '555555555',
                                            style: XemoTypography.bodyBold(context)!.copyWith(color: const Color(0xFF20C9A7), fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 13,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'send.money.checkout.bankAccountDeposit'.tr.toUpperCase(),
                        style: XemoTypography.bodyBold(context),
                      )
                    ],
                  )
                : (transaction!.collect_transactions != null &&
                        !transaction!.parameters!.collect_method!.toLowerCase().replaceAll('-', '').replaceAll(' ', '_').contains('mobile'))
                    ? Column(
                        children: [
                          Column(
                              children: transaction!.collect_transactions!
                                  .map((e) => SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                          width: 0.85.sw,
                                          height: 63.h,
                                          margin: EdgeInsets.only(bottom: 5.h),
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(9)),
                                            color: (e.status.toLowerCase() == 'collected') ? const Color(0xFFCCCCCC) : const Color(0xFF333333),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(9), bottomLeft: Radius.circular(9)),
                                                child: Row(
                                                    children: List.generate(
                                                        e.img_urls.length,
                                                        (index) => Padding(
                                                              padding: EdgeInsets.only(
                                                                left: 6.w,
                                                                top: 10.h,
                                                                bottom: 10.h,
                                                              ),
                                                              child: e.img_urls[index].endsWith('svg')
                                                                  ? SvgPicture.network(
                                                                      e.img_urls[index],
                                                                      width: 45,
                                                                      height: 45,
                                                                      clipBehavior: Clip.none,
                                                                      fit: BoxFit.contain,
                                                                    )
                                                                  : Image.network(
                                                                      e.img_urls[index],
                                                                      width: 45,
                                                                      height: 45,
                                                                      fit: BoxFit.contain,
                                                                    ),
                                                            ))),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left: e.img_urls.length <= 1 ? 12.0 : 5.0),
                                                alignment: Alignment.center,
                                                child: e.collect_code.isEmpty
                                                    ? RotatedSpinner(
                                                        spinnerColor: SpinnerColor.WHITE,
                                                      )
                                                    : Text(
                                                        e.collect_code,
                                                        style: XemoTypography.bodyBold(context)!.copyWith(color: Colors.white),
                                                        textAlign: e.img_urls.length <= 1 ? TextAlign.right : TextAlign.center,
                                                      ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList()),
                          transaction!.collect_transactions!.isEmpty
                              ? RotatedSpinner(
                                  spinnerColor: SpinnerColor.GREEN,
                                )
                              : Container(),
                          transaction!.parameters!.collect_method!.toLowerCase().replaceAll('-', '').replaceAll(' ', '_').contains('mobile')
                              ? Text(
                                  'send.money.checkout.cashPickupTransactionCode'.tr.toUpperCase(),
                                  style: XemoTypography.bodyBold(context)!.copyWith(fontSize: 15.sp),
                                )
                              : Container()
                        ],
                      )
                    : transaction!.parameters!.collect_method!.toLowerCase().replaceAll('-', '').replaceAll(' ', '_').contains('mobile')
                        ? Column(
                            children: [
                              Container(
                                width: 0.85.sw,
                                height: 63,
                                margin: EdgeInsets.only(bottom: 5.h),
                                // ignore: prefer_const_constructors
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(9)),
                                    color: (transaction!.collect_transactions != null)
                                        ? (transaction!.collect_transactions!.isNotEmpty)
                                            ? (transaction!.collect_transactions!.where((element) => element.status.toLowerCase() == 'collected'))
                                                    .isNotEmpty
                                                ? const Color(0xFFCCCCCC)
                                                : const Color(0xFF333333)
                                            : const Color(0xFF333333)
                                        : const Color(0xFF333333)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(9), bottomLeft: Radius.circular(9)),
                                      child: Padding(
                                          padding: EdgeInsets.only(
                                            left: 20.w,
                                            top: 10.h,
                                            bottom: 10.h,
                                          ),
                                          child: sendMoneyController.deliveryMethods
                                              .where((e) => e.code!.toLowerCase().replaceAll('-', '').replaceAll(' ', '_').contains('mobile'))
                                              .first
                                              .getImageWidget(type: DeliveryMethodImageType.txDetails, width: 65.w, height: 65.h)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 0.05.sw),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Mobile Money".tr,
                                        style: XemoTypography.bodyBold(context)!.copyWith(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              transaction!.parameters!.collect_method!.toLowerCase().replaceAll('-', '').replaceAll(' ', '_').contains('mobile')
                                  ? Container()
                                  : Container()
                            ],
                          )
                        : RotatedSpinner(
                            spinnerColor: SpinnerColor.GREEN,
                          ));
      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
        return Container(
          margin: EdgeInsets.only(bottom: 10.h, top: 15.h),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10.h, left: 8.0, right: 8.0),
                child: Center(
                  child: Text(
                    'transaction.dialog.an.interact.has.been.sent'.tr,
                    textAlign: TextAlign.center,
                    style: XemoTypography.bodyBold(context)!.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp, color: kLightDisplayErrorText),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Text(
                    'send.money.interactDetails'.tr.toUpperCase(),
                    style: XemoTypography.bodyBold(context)!
                        .copyWith(fontWeight: FontWeight.w700, fontSize: 14.sp, color: kLightDisplaySecondaryTextColor),
                  ),
                ),
              ),
              Container(
                height: 220.h,
                width: 343.w,
                margin: EdgeInsets.only(top: 13.h, bottom: 10.h),
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: profileController.appSettings['interacDeposit']['mailbox'].toString())).then((_) {
                            //ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text("Email address copied to clipboard")));
                            Get.snackbar(
                              '',
                              '',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                              padding: EdgeInsets.only(left: 40.w, right: 10.w, top: 10.h, bottom: 20.h),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              messageText: Text(
                                "send.money.interacCopied".trParams({'fieldName': 'send.money.interacEmail'.tr}),
                                style:
                                    XemoTypography.captionSemiBold(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor, fontSize: 13.sp),
                              ),
                              icon: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5)],
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/xemo/yxLogo-small.svg',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              backgroundColor: kLightDisplayToolTipBackgroundColor,
                            );
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5.h),
                          height: 62.h,
                          width: 311.w,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                              border: Border.all(width: 0.5, color: kLightDisplaySecondaryTextColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 18.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 3.h,
                                    ),
                                    Text(
                                      'send.money.interacEmail'.tr,
                                      style: XemoTypography.bodySemiBold(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                                    ),
                                    Container(
                                      height: 8.h,
                                    ),
                                    Text(
                                      profileController.appSettings['interacDeposit']['mailbox'],
                                      style: XemoTypography.bodyBold(context)!.copyWith(fontSize: 12.sp, color: Get.theme.primaryColorLight),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 18.w),
                                child: Text(
                                  'send.money.copy'.tr.toUpperCase(),
                                  style: XemoTypography.bodyAllCapsSecondary(context)!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: profileController.appSettings['interacDeposit']['secret']['question'])).then((_) {
                            Get.snackbar(
                              '',
                              '',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                              padding: EdgeInsets.only(left: 40.w, right: 10.w, top: 10.h, bottom: 20.h),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              messageText: Text(
                                "send.money.interacCopied".trParams({'fieldName': 'send.money.interacSecretQuestion'.tr}),
                                style:
                                    XemoTypography.captionSemiBold(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor, fontSize: 13.sp),
                              ),
                              icon: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5)],
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/xemo/yxLogo-small.svg',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              backgroundColor: kLightDisplayToolTipBackgroundColor,
                            );
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 13.h),
                          height: 62.h,
                          width: 311.w,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                              border: Border.all(width: 0.5, color: kLightDisplaySecondaryTextColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 18.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 3.h,
                                    ),
                                    Text(
                                      'send.money.interacSecretQuestion'.tr,
                                      style: XemoTypography.bodySemiBold(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                                    ),
                                    Container(
                                      height: 8.h,
                                    ),
                                    Text(
                                      profileController.appSettings['interacDeposit']['secret']['question'],
                                      style: XemoTypography.bodyBold(context)!.copyWith(fontSize: 12.sp, color: Get.theme.primaryColorLight),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 18.w),
                                child: Text(
                                  'send.money.copy'.tr.toUpperCase(),
                                  style: XemoTypography.bodyAllCapsSecondary(context)!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: profileController.appSettings['interacDeposit']['secret']['answer'])).then((_) {
                            Get.snackbar(
                              '',
                              '',
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                              padding: EdgeInsets.only(left: 40.w, right: 10.w, top: 10.h, bottom: 20.h),
                              margin: const EdgeInsets.only(bottom: 10.0),
                              messageText: Text(
                                "send.money.interacCopied".trParams({'fieldName': 'send.money.interacAnswer'.tr}),
                                style:
                                    XemoTypography.captionSemiBold(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor, fontSize: 13.sp),
                              ),
                              icon: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5)],
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                padding: const EdgeInsets.all(12.0),
                                child: SvgPicture.asset(
                                  'assets/xemo/yxLogo-small.svg',
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                              backgroundColor: kLightDisplayToolTipBackgroundColor,
                            );
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 13.h),
                          height: 62.h,
                          width: 311.w,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(18),
                              ),
                              border: Border.all(width: 0.5, color: kLightDisplaySecondaryTextColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 18.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 3.h,
                                    ),
                                    Text(
                                      'send.money.interacAnswer'.tr,
                                      style: XemoTypography.bodySemiBold(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                                    ),
                                    Container(
                                      height: 8.h,
                                    ),
                                    Text(
                                      profileController.appSettings['interacDeposit']['secret']['answer'],
                                      style: XemoTypography.bodyBold(context)!.copyWith(fontSize: 12.sp, color: Get.theme.primaryColorLight),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 18.w),
                                child: Text(
                                  'send.money.copy'.tr.toUpperCase(),
                                  style: XemoTypography.bodyAllCapsSecondary(context)!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case GlobalTransactionStatus.SUCCESS:
        return Container(
            width: 340.w,
            margin: EdgeInsets.only(bottom: 10.h, top: 5.h),
            padding: const EdgeInsets.all(5.0),
            child: transaction!.parameters!.collect_method!.replaceAll('-', '').replaceAll(' ', '_').toLowerCase().contains('bank')
                ? Column(
                    children: [
                      Container(
                        width: 340.w,
                        margin: EdgeInsets.only(bottom: 0.h, top: 5.h),
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //  height: 63.h,
                          margin: EdgeInsets.only(bottom: 5.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(9)),
                              color: (transaction!.collect_transactions != null)
                                  ? (transaction!.collect_transactions!.isNotEmpty)
                                      ? (transaction!.collect_transactions!.where((element) => element.status.toLowerCase() == 'success')).isNotEmpty
                                          ? const Color(0xFFCCCCCC)
                                          : const Color(0xFF333333)
                                      : const Color(0xFF333333)
                                  : const Color(0xFF333333)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(9), bottomLeft: Radius.circular(9)),
                                    child: sendMoneyController.deliveryMethods
                                        .where((e) => e.code!.toLowerCase().replaceAll('-', '').replaceAll(' ', '_').contains('bank'))
                                        .first
                                        .getImageWidget(type: DeliveryMethodImageType.txDetails, width: 65.w, height: 65.h)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            // transaction!.collect_transactions!.first.collect_code,
                                            'SWIFT',
                                            style: XemoTypography.bodyBold(context)!.copyWith(color: Colors.white, fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                                          child: Text(
                                            transaction!.receiver!.bank_swift_code!,
                                            // '555555555',
                                            style: XemoTypography.bodyBold(context)!.copyWith(color: const Color(0xFF20C9A7), fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 10.h,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            // transaction!.collect_transactions!.first.collect_code,
                                            'contact.accountNumber'.tr.toUpperCase(),
                                            style: XemoTypography.bodyBold(context)!.copyWith(color: Colors.white, fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0, top: 2.0),
                                          child: Text(
                                            transaction!.receiver!.account_number!,
                                            // '555555555',
                                            style: XemoTypography.bodyBold(context)!.copyWith(color: const Color(0xFF20C9A7), fontSize: 14),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 13,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Text(
                        'send.money.checkout.bankAccountDeposit'.tr.toUpperCase(),
                        style: XemoTypography.bodyBold(context),
                      )
                    ],
                  )
                : (transaction!.collect_transactions != null &&
                        !transaction!.parameters!.collect_method!.replaceAll('-', '').replaceAll(' ', '_').toLowerCase().contains('mobile'))
                    ? Column(
                        children: [
                          Column(
                              children: transaction!.collect_transactions!
                                  .map((e) => (e.status.toUpperCase() == 'SUCCESS')
                                      ? Container(
                                          height: 65.h,
                                          margin: EdgeInsets.only(bottom: 5.h),
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(9)),
                                            color: (e.status.toUpperCase() == 'SUCCESS') ? const Color(0xFFCCCCCC) : const Color(0xFF333333),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(topLeft: Radius.circular(9), bottomLeft: const Radius.circular(9)),
                                                child: Row(
                                                    children: List.generate(
                                                        e.img_urls.length,
                                                        (index) => Padding(
                                                              padding: EdgeInsets.only(
                                                                left: 6.w,
                                                                top: 10.h,
                                                                bottom: 10.h,
                                                              ),
                                                              child: e.img_urls[index].endsWith('svg')
                                                                  ? SvgPicture.network(
                                                                      e.img_urls[index],
                                                                      width: 45,
                                                                      height: 45,
                                                                      clipBehavior: Clip.none,
                                                                      fit: BoxFit.contain,
                                                                    )
                                                                  : Image.network(
                                                                      e.img_urls[index],
                                                                      width: 45,
                                                                      height: 45,
                                                                      fit: BoxFit.contain,
                                                                    ),
                                                            ))),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left: e.img_urls.length <= 1 ? 12.0 : 5.0),
                                                alignment: Alignment.center,
                                                child: e.collect_code.isEmpty
                                                    ? RotatedSpinner(
                                                        spinnerColor: SpinnerColor.WHITE,
                                                      )
                                                    : Text(
                                                        e.collect_code,
                                                        style: XemoTypography.bodyBold(context)!.copyWith(color: Colors.white),
                                                        textAlign: e.img_urls.length <= 1 ? TextAlign.right : TextAlign.center,
                                                      ),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container())
                                  .toList()),
                          transaction!.collect_transactions!.isEmpty
                              ? RotatedSpinner(
                                  spinnerColor: SpinnerColor.BLACK,
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              sendMoneyController.deliveryMethods
                                      .firstWhereOrNull((e) =>
                                          e.code!.toLowerCase() ==
                                          transaction!.parameters!.collect_method!.replaceAll('-', '').replaceAll(' ', '_').toLowerCase())!
                                      .getCurrentName() +
                                  ' CODE ',
                              style: XemoTypography.bodyAllCapsBlack(context)!
                                  .copyWith(color: kLightDisplaySecondaryTextColor, fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      )
                    : transaction!.parameters!.collect_method!.replaceAll('-', '').replaceAll(' ', '_').toLowerCase().contains('mobile')
                        ? Column(
                            children: [
                              Container(
                                width: 0.85.sw,
                                height: 63,
                                margin: EdgeInsets.only(bottom: 5.h),
                                // ignore: prefer_const_constructors
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                                  color: const Color(0xFFCCCCCC),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(9), bottomLeft: Radius.circular(9)),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 20.w,
                                          top: 10.h,
                                          bottom: 10.h,
                                        ),
                                        child: sendMoneyController.deliveryMethods
                                            .where((e) => e.code!.toLowerCase().replaceAll('-', '').replaceAll(' ', '_').contains('mobile'))
                                            .first
                                            .getImageWidget(type: DeliveryMethodImageType.txDetails, width: 65.w, height: 65.h),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 0.05.sw),
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Mobile Money".tr,
                                        style: XemoTypography.bodyBold(context)!.copyWith(color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              transaction!.parameters!.collect_method!.replaceAll('-', '').replaceAll(' ', '_').toLowerCase().contains('mobile')
                                  ? Container()
                                  : Container()
                            ],
                          )
                        : RotatedSpinner(
                            spinnerColor: SpinnerColor.GREEN,
                          ));
      case GlobalTransactionStatus.CANCELLED:
        return GestureDetector(
          onTap: () {
            openHelpAndSupportDialog();
          },
          child: Container(
            height: 56.h,
            width: Get.locale!.languageCode == 'en' ? 255.w : 300.w,
            margin: EdgeInsets.only(bottom: 18.h, top: 20.h),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5, offset: const Offset(0, 3))],
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: kLightDisplayPrimaryAction,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/xemo/icon-contact_support.svg',
                    width: 32.w,
                    height: 30.h,
                  ),
                  Container(
                    // width: 100.w,
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'transaction.ask.support'.tr.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        return GestureDetector(
          onTap: () {
            openHelpAndSupportDialog();
          },
          child: Container(
            height: 56.h,
            width: Get.locale!.languageCode == 'en' ? 230.w : 300.w,
            margin: EdgeInsets.only(bottom: 18.h, top: 20.h),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5, offset: const Offset(0, 3))],
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: kLightDisplayPrimaryAction,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/xemo/icon-contact_support.svg',
                    width: 32.w,
                    height: 30.h,
                  ),
                  Container(
                    // width: 100.w,
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'transaction.ask.support'.tr.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      case GlobalTransactionStatus.REFUNDED:
        // TODO: Handle this case.
        return Container();
      case GlobalTransactionStatus.BLOCKED:
        return GestureDetector(
          onTap: () {
            openHelpAndSupportDialog();
          },
          child: Container(
            height: 56.h,
            width: Get.locale!.languageCode == 'en' ? 230.w : 300.w,
            margin: EdgeInsets.only(bottom: 18.h, top: 20.h),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5, offset: const Offset(0, 3))],
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: kLightDisplayPrimaryAction,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/xemo/icon-contact_support.svg',
                    width: 32.w,
                    height: 30.h,
                  ),
                  Container(
                    // width: 100.w,
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'transaction.ask.support'.tr.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      case GlobalTransactionStatus.COLLECT_ERROR:
        return GestureDetector(
          onTap: () {
            openHelpAndSupportDialog();
          },
          child: Container(
            height: 56.h,
            width: Get.locale!.languageCode == 'en' ? 230.w : 300.w,
            margin: EdgeInsets.only(bottom: 18.h, top: 20.h),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5, offset: const Offset(0, 3))],
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: kLightDisplayPrimaryAction,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/xemo/icon-contact_support.svg',
                    width: 32.w,
                    height: 30.h,
                  ),
                  Container(
                    // width: 100.w,
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'transaction.ask.support'.tr.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      case GlobalTransactionStatus.COLLECT_ON_HOLD:
        return GestureDetector(
          onTap: () {
            openHelpAndSupportDialog();
          },
          child: Container(
            height: 56.h,
            width: Get.locale!.languageCode == 'en' ? 230.w : 300.w,
            margin: EdgeInsets.only(bottom: 18.h, top: 20.h),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5, offset: const Offset(0, 3))],
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: kLightDisplayPrimaryAction,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/xemo/icon-contact_support.svg',
                    width: 32.w,
                    height: 30.h,
                  ),
                  Container(
                    // width: 100.w,
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'transaction.ask.support'.tr.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      case GlobalTransactionStatus.FUNDING_ERROR:
        return GestureDetector(
          onTap: () {
            openHelpAndSupportDialog();
          },
          child: Container(
            height: 58.h,
            width: Get.locale!.languageCode == 'en' ? 260.w : 300.w,
            margin: EdgeInsets.only(bottom: 18.h, top: 20.h),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5, offset: const Offset(0, 3))],
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: kLightDisplayPrimaryAction,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/xemo/icon-contact_support.svg',
                    width: 32.w,
                    height: 30.h,
                  ),
                  Container(
                    // width: 100.w,
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'transaction.ask.support'.tr.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      case GlobalTransactionStatus.NOT_FOUND:
        return GestureDetector(
          onTap: () {
            openHelpAndSupportDialog();
          },
          child: Container(
            height: 56.h,
            width: Get.locale!.languageCode == 'en' ? 230.w : 300.w,
            margin: EdgeInsets.only(bottom: 18.h, top: 20.h),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5, offset: const Offset(0, 3))],
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: kLightDisplayPrimaryAction,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/xemo/icon-contact_support.svg',
                    width: 32.w,
                    height: 30.h,
                  ),
                  Container(
                    // width: 100.w,
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'transaction.ask.support'.tr.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      case GlobalTransactionStatus.REFUNDED_ERROR:
        return GestureDetector(
          onTap: () {
            openHelpAndSupportDialog();
          },
          child: Container(
            height: 56.h,
            width: Get.locale!.languageCode == 'en' ? 230.w : 300.w,
            margin: EdgeInsets.only(bottom: 18.h, top: 20.h),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5, offset: const Offset(0, 3))],
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: kLightDisplayPrimaryAction,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SvgPicture.asset(
                    'assets/xemo/icon-contact_support.svg',
                    width: 32.w,
                    height: 30.h,
                  ),
                  Container(
                    // width: 100.w,
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'transaction.ask.support'.tr.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
    }
  }

  String valueToFundingTime(String val) {
    String result = '';
    String firstPart = '';
    String secPart = '';
    //add the hours value
    firstPart = val.split('.').first;
    result = firstPart + "h";

    //add the minutes value
    if (val.split('.').length > 1) {
      secPart = val.split('.')[1];
      secPart = '0.' + secPart;
      double secValue = double.parse(secPart);
      double value = 60 * secValue;

      result = result + " " + value.toStringAsFixed(0) + " min";
    }

    return result;
  }
}
