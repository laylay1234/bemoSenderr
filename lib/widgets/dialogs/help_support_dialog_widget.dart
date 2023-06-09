import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/utils/error_alerts_utils.dart';
import 'package:mobileapp/widgets/common/xemo_logo_circule_with_background.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openHelpAndSupportDialog() async {
  Get.dialog(HelpAndSupportDialogWidget(), barrierDismissible: true, useSafeArea: true);
}

class HelpAndSupportDialogWidget extends StatelessWidget {
  HelpAndSupportDialogWidget({Key? key}) : super(key: key);
  String? supportPhone;
  String? supportEmail;
  var openingHours;
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();
    OriginController originController = Get.find<OriginController>();
    setHelpSupportVariables(profileController.appSettings, originController.origin_country_iso.toUpperCase());
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 425.h,
        width: 350.w,
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -60.h,
              left: 75.w,
              right: 75.w,
              child: const XemoLogoCirculeWhiteBackground(),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Container(
                    padding: EdgeInsets.only(left: 42.w, right: 42.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 90.h,
                        ),
                        Text('dialog.help&Support.text'.tr,
                            textAlign: TextAlign.center, style: XemoTypography.bodySemiBold(context)!.copyWith(color: Colors.black)),
                        Container(
                          height: 20.h,
                        ),
                        Text(
                            openingHours['open']['day'].toString().toLowerCase().capitalizeFirst!.tr +
                                ' ' +
                                'common.to'.tr.toLowerCase() +
                                ' ' +
                                openingHours['close']['day'].toString().toLowerCase().capitalizeFirst!.tr,
                            style: XemoTypography.bodySemiBold(context)!.copyWith(color: Colors.black)),
                        Text(openingHours['open']['hour'] + ' ' + '-'.tr + ' ' + openingHours['close']['hour'],
                            style: XemoTypography.bodySemiBold(context)!.copyWith(color: Colors.black)),
                        Container(
                          height: 20.h,
                        ),
                        GestureDetector(
                            onTap: callAction,
                            child: Text(supportPhone ?? '', style: XemoTypography.bodySemiBold(context)!.copyWith(color: Colors.black))),
                        Container(
                          height: 20.h,
                        ),
                        GestureDetector(
                            onTap: () {
                              try {
                                String formatedEmail = 'mailto://';
                                formatedEmail = formatedEmail + supportEmail!.trim();

                                launch(formatedEmail);
                              } catch (error, stackTrace) {
                                log(error.toString());
                                Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
                              }
                            },
                            child: Text(supportEmail ?? '', style: XemoTypography.bodySemiBold(context)!.copyWith(color: Colors.black))),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 14.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            //   margin: EdgeInsets.only(left: 8.w),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 0.1),
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 5, offset: Offset(0, 3))],
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: kLightDisplaySecondaryAction),
                            width: 155.w,
                            height: 50.h,
                            child: Center(
                              child: Text(
                                'common.cancel'.tr,
                                style: XemoTypography.buttonAllCapsWhite(context)!.copyWith(color: kLightDisplayOnSecondaryAction),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          //    margin: EdgeInsets.only(right: 8.w),
                          child: GestureDetector(
                            onTap: callAction,
                            child: Container(
                              width: 155.w,
                              height: 50.h,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: kLightDisplayPrimaryAction,
                              ),
                              child: Center(
                                child: Text(
                                  'common.text.call'.tr,
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
            )
          ],
        ),
      ),
    );
  }

  void setHelpSupportVariables(Map<dynamic, dynamic> appSettings, String iso_code) {
    //check if there's for origin country if not go to default
    String originCountry = iso_code;
    if ((appSettings['clientHelpDesk'] as Map<String, dynamic>)['email'].containsKey(originCountry)) {
      supportEmail = (appSettings['clientHelpDesk'] as Map<String, dynamic>)['email'][originCountry];
    } else {
      supportEmail = (appSettings['clientHelpDesk'] as Map<String, dynamic>)['email']['default'];
    }

    if ((appSettings['clientHelpDesk'] as Map<String, dynamic>)['openingHours'].containsKey(originCountry)) {
      openingHours = (appSettings['clientHelpDesk'] as Map<String, dynamic>)['openingHours'][originCountry];
    } else {
      openingHours = (appSettings['clientHelpDesk'] as Map<String, dynamic>)['openingHours']['default'];
    }

    if ((appSettings['clientHelpDesk'] as Map<String, dynamic>)['supportPhone'].containsKey(originCountry)) {
      supportPhone = (appSettings['clientHelpDesk'] as Map<String, dynamic>)['supportPhone'][originCountry];
    } else {
      supportPhone = (appSettings['clientHelpDesk'] as Map<String, dynamic>)['supportPhone']['default'];
    }
  }

  // TODO: Refactor in separate helper class
  void callAction() async {
    try {
      //String formattedPhone = 'tel://';
      String formattedPhone = 'tel:';
      formattedPhone = formattedPhone + supportPhone!.trim();

      if (GetPlatform.isAndroid) {
        launch(formattedPhone);
      } else {
        final Uri _phoneUri = Uri(scheme: "tel", path: supportPhone!.trim());
        if (await canLaunchUrl(_phoneUri)) await launchUrl(_phoneUri, mode: LaunchMode.externalApplication);
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log(error.toString());
    }
  }
  // EO TODO
}
