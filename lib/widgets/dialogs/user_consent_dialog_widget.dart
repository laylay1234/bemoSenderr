import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/utils/app_utils.dart';
import 'package:mobileapp/widgets/common/xemo_logo_circule_with_background.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/colors.dart';

Future<bool> openUserConsentDialog() async {
  Rx<bool> result = false.obs;
  await Get.dialog(const UserConsentDialog(), barrierDismissible: false, useSafeArea: true).then((value) {
    result.value = (value as bool);
  });
  log(result.value.toString());
  return (result.value);
}

class UserConsentDialog extends StatelessWidget {
  const UserConsentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();
    OriginController originController = Get.find<OriginController>();
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 0.8.sh,
        width: 0.9.sw,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(clipBehavior: Clip.none, alignment: Alignment.topCenter, children: [
          SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 70.h,
                          ),
                          Container(
                            child: Text(
                              "contact.dialog.consent.title".tr,
                              textAlign: TextAlign.center,
                              style: XemoTypography.headLine4FullName(context)!.copyWith(fontSize: 24.sp, color: Get.theme.primaryColorLight),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: "contact.dialog.consent.first.part".tr,
                                  style: XemoTypography.bodyBold(context)!.copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp),
                                  children: [
                                    TextSpan(
                                      text: " " + "contact.dialog.consent.policy.yallaxash".tr,
                                      recognizer: new TapGestureRecognizer()
                                        ..onTap = () {
                                          Locale? currentLocal = Get.locale;
                                          log(currentLocal!.languageCode);

                                          String url = AppUtils.getPrivacyPolicyUrl(originController.origin_country_iso.toUpperCase(), currentLocal.languageCode.toLowerCase());
                                          launch(url);
                                        },
                                      onEnter: (point) {
                                        Locale? currentLocal = Get.locale;
                                        log(currentLocal!.languageCode);

                                        String url = AppUtils.getPrivacyPolicyUrl(originController.origin_country_iso.toUpperCase(), currentLocal.languageCode.toLowerCase());
                                        launch(url);
                                      },
                                      style: XemoTypography.bodyBold(context)!
                                          .copyWith(decoration: TextDecoration.underline, fontSize: 16.sp, fontWeight: FontWeight.w400),
                                    ),
                                    TextSpan(
                                        text: "contact.dialog.consent.second.part".tr,
                                        style: XemoTypography.bodyBold(context)!.copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp))
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: "contact.dialog.consent.why.question".tr,
                                  style: XemoTypography.bodyBold(context)!.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                  children: [
                                    TextSpan(
                                      text: "contact.dialog.consent.why.answer".tr,
                                      style: XemoTypography.bodyBold(context)!.copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp),
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(
                                  text: "contact.dialog.conset.some.examples".tr,
                                  style: XemoTypography.bodyBold(context)!.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp),
                                  children: []),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: "contact.dialog.consent.first.example.headline".tr,
                                      style: XemoTypography.bodyBold(context)!.copyWith(fontSize: 16.sp),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "contact.dialog.consent.first.example.content".tr,
                                      style: XemoTypography.bodyBold(context)!.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w400),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              )),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.h, top: 0.07.sh),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back(result: false);
                              },
                              child: Container(
                                //   margin: EdgeInsets.only(left: 8.w),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black, width: 0.1),
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 5, offset: Offset(0, 3))],
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    color: kLightDisplaySecondaryAction),
                                width: 150.w,
                                height: 50.h,
                                child: Center(
                                  child: Text(
                                    'common.notNow'.tr.capitalizeFirst!,
                                    style: XemoTypography.buttonAllCapsWhite(context)!.copyWith(color: kLightDisplayOnSecondaryAction),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              //    margin: EdgeInsets.only(right: 8.w),
                              child: GestureDetector(
                                onTap: () async {
                                  Get.back(result: true);
                                },
                                child: Container(
                                  width: 150.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 5, offset: Offset(0, 3))],
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: kLightDisplayPrimaryAction,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'common.agree'.tr.capitalizeFirst!,
                                      style: XemoTypography.buttonAllCapsWhite(context),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
          Positioned(
            top: -63,
            left: 75.w,
            right: 75.w,
            child: const XemoLogoCirculeWhiteBackground(),
          ),
        ]),
      ),
    );
  }
}
