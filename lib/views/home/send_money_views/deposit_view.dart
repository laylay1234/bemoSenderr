import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/utilities/clipers/ticket_clipper.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../constants/format.dart';

class DepositView extends StatelessWidget {
  static const String id = '/deposit-view';

  const DepositView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    final AuthController authController = Get.find<AuthController>();
    final ProfileController profileController = Get.find<ProfileController>();

    //Get.updateLocale(Locale('en', 'US'));
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Scaffold(
      appBar: XemoAppBar(leading: false),
      bottomSheet: null,
      backgroundColor: Get.theme.primaryColorLight,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 0.05.sw, right: 0.05.sw),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: EdgeInsets.only(
                top: 16.h,
              ),
              child: ClipPath(
                clipper: TicketDepositClipper(),
                child: Container(
                  width: 0.9.sw,
                  //  height: 480.h,
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white),
                  child: Container(
                    padding: EdgeInsets.only(top: 10.h, bottom: 18.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 0.1.sh,
                          child: Get.locale == const Locale('en', 'US')
                              ? Container(
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: "send.money.deposit.transfer".tr.replaceFirst(
                                              '@',
                                              sendMoneyController.totalAmount.value.toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                                                  sendMoneyController.originCurrency.value!.short_sign),
                                          style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 26.sp),
                                          children: [
                                            TextSpan(
                                                text: '\n Yalla',
                                                style:
                                                    XemoTypography.bodySemiBold(context)!.copyWith(color: const Color(0xFFF05137), fontSize: 26.sp)),
                                            TextSpan(
                                                text: 'Xash',
                                                style: XemoTypography.bodySemiBold(context)!
                                                    .copyWith(color: Get.theme.primaryColorLight, fontSize: 26.sp)),
                                            TextSpan(
                                              text: ' ',
                                              style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 26.sp),
                                            )
                                          ])),
                                )
                              : Container(
                                  width: 0.8.sw,
                                  padding: EdgeInsets.only(top: 10.h),
                                  child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                          text: "send.money.deposit.transfer".tr.replaceFirst(
                                              '@',
                                              sendMoneyController.totalAmount.value.toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                                                  sendMoneyController.originCurrency.value!.short_sign),
                                          style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 26.sp),
                                          children: [
                                            TextSpan(
                                              text: '',
                                              style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 26.sp),
                                            ),
                                            TextSpan(
                                              text: '',
                                              style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 26.sp),
                                            ),
                                            TextSpan(
                                                text: ' Yalla',
                                                style:
                                                    XemoTypography.bodySemiBold(context)!.copyWith(color: const Color(0xFFF05137), fontSize: 26.sp)),
                                            TextSpan(
                                                text: 'Xash',
                                                style: XemoTypography.bodySemiBold(context)!
                                                    .copyWith(color: Get.theme.primaryColorLight, fontSize: 26.sp)),
                                          ])),
                                ),
                        ),
                        Container(
                          height: Get.locale == const Locale('en', 'US') ? 10.h : 15.h,
                        ),
                        Container(
                          // margin: EdgeInsets.only(bottom: 0.h, left: 0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ...List.generate(
                                  Get.locale == const Locale('en', 'US') ? 5 : 4,
                                  (index) => Container(
                                        margin: const EdgeInsets.only(left: 5.0),
                                        width: (index == 0 || index == 15) ? 5.w : 15.w,
                                        height: 2,
                                        color: const Color(0xFF9B9B9B).withOpacity(0.5),
                                      )),
                              Text(
                                "send.money.how.to.credit".tr,
                                style: XemoTypography.bodyBold(context)!.copyWith(color: Get.theme.primaryColorLight),
                              ),
                              ...List.generate(
                                  Get.locale == const Locale('en', 'US') ? 5 : 4,
                                  (index) => Container(
                                        margin: const EdgeInsets.only(left: 5.0),
                                        width: (index == 0 || index == 15) ? 5.w : 15.w,
                                        height: 2,
                                        color: const Color(0xFF9B9B9B).withOpacity(0.5),
                                      ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25.h),
                          padding: EdgeInsets.only(left: 18.w, right: 18.w),
                          child: Text(
                            "send.money.connect.interact".tr,
                            textAlign: TextAlign.center,
                            style: XemoTypography.captionBold(context),
                          ),
                        ),
                        Container(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 8.w),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/xemo/icon-bank_transfer_small_active_3x.svg',
                                    height: 70.h,
                                    width: 70.w,
                                    fit: BoxFit.fill,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8.h),
                                    alignment: Alignment.topCenter,
                                    width: 85.w,
                                    child: Text(
                                      'send.money.yourBankAccount'.tr,
                                      textAlign: TextAlign.center,
                                      style: XemoTypography.captionBold(context)!.copyWith(fontSize: 9.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/xemo/arrow-grey.svg',
                              height: 15.h,
                              width: 15.w,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 1.w),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/xemo/interac_3x.svg',
                                    height: 60.h,
                                    width: 60.w,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.h),
                                    child: Text(
                                      'send.money.eTransfer'.tr,
                                      textAlign: TextAlign.center,
                                      style: XemoTypography.captionBold(context)!.copyWith(fontSize: 9.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/xemo/arrow-grey.svg',
                              height: 15.h,
                              width: 15.w,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 0.w),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/xemo/logo-yallaxash_small_3x.svg',
                                    height: 60.h,
                                    width: 60.w,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.h),
                                    width: 85.w,
                                    child: Text(
                                      'send.money.yourYallaxashAccount'.tr,
                                      textAlign: TextAlign.center,
                                      style: XemoTypography.captionBold(context)!.copyWith(fontSize: 9.sp),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 45.h, left: 0.02.sw, right: 0.02.sw),
                          padding: const EdgeInsets.only(left: 6.0, top: 5.0, bottom: 10.0),
                          //  height: 90.h,
                          width: 321.w,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 5, offset: const Offset(0, 3))],
                              borderRadius: const BorderRadius.all(const Radius.circular(10)),
                              color: kLightDisplayInteracBackground),
                          child: Text(
                            'send.money.receiveNotifs'.tr,
                            textAlign: TextAlign.center,
                            style: XemoTypography.headLine5Black(context)!.copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 0.75.sw,
              width: 0.9.sw,
              margin: EdgeInsets.only(
                top: 10.h,
                bottom: 10.h,
              ),
              padding: EdgeInsets.only(left: 0.02.sw, right: 0.02.sw, top: 15, bottom: 15),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'send.money.interactDetails'.tr,
                    textAlign: TextAlign.center,
                    style: XemoTypography.headLine5Black(context)!.copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: profileController.appSettings['interacDeposit']['mailbox'])).then((_) {
                        Get.snackbar(
                          '',
                          '',
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                          titleText: Text(
                            ' ',
                            style: XemoTypography.bodySmallSemiBald(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor),
                          ),
                          padding: EdgeInsets.only(left: 40.w, right: 10.w, top: 10.h, bottom: 20.h),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          messageText: Text(
                            "send.money.interacCopied".trParams({'fieldName': 'send.money.interacEmail'.tr}),
                            style: XemoTypography.captionSemiBold(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor, fontSize: 13.sp),
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
                      width: 0.82.sw,
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
                          titleText: Text(
                            ' ',
                            style: XemoTypography.bodySmallSemiBald(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor),
                          ),
                          padding: EdgeInsets.only(left: 40.w, right: 10.w, top: 10.h, bottom: 20.h),
                          margin: const EdgeInsets.only(bottom: 10.0),
                          messageText: Text(
                            "send.money.interacCopied".trParams({'fieldName': 'send.money.interacSecretQuestion'.tr}),
                            style: XemoTypography.captionSemiBold(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor, fontSize: 13.sp),
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
                      width: 0.82.sw,
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
                            style: XemoTypography.captionSemiBold(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor, fontSize: 13.sp),
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
                      width: 0.82.sw,
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
            GestureDetector(
              onTap: () {
                sendMoneyController.congratState.enter();
                sendMoneyController.nextStep();
              },
              child: Container(
                width: 0.9.sw,
                height: 50.h,
                margin: EdgeInsets.only(
                  top: 10.h,
                  bottom: 20.h,
                ),
                decoration:
                    BoxDecoration(color: kLightDisplayPrimaryAction, borderRadius: const BorderRadius.all(const Radius.circular(20)), boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ]),
                child: Center(
                  child: Text(
                    'common.confirm'.tr.toUpperCase(),
                    style: XemoTypography.buttonAllCapsWhite(context),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
