import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/widgets/buttons/next_button_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import 'auth_register_phone_view.dart';

class AuthChooseLangView extends StatelessWidget {
  static const String id = '/Choose-language';

  const AuthChooseLangView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    ProfileController profileController = Get.find<ProfileController>();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Scaffold(
        appBar: XemoAppBar(leading: true),
        body: Container(
          margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw, top: 25.h),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Container(
                padding: EdgeInsets.only(left: 2.w),
                child: Text(
                  "common.auth.register.title".tr,
                  style: XemoTypography.headLine1Black(context),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5.h, left: 2.w),
                child: Text(
                  "auth.register.selectLanguage".tr,
                  style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
              Container(
                height: 45.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      authController.langPreference.value = 'French';
                      Locale locale;
                      locale = const Locale('fr', 'FR');
                      Get.updateLocale(locale);
                      Get.forceAppUpdate();
                    },
                    child: Opacity(
                      opacity: Get.locale!.languageCode == 'fr' ? 1 : 0.5,
                      child: SizedBox(
                        width: 78.w,
                        height: 55.h,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)), child: SvgPicture.asset('assets/xemo/lang-french.svg')),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      authController.langPreference.value = 'English';
                      Locale locale;
                      locale = const Locale('en', 'US');
                      Get.updateLocale(locale);
                      Get.forceAppUpdate();
                    },
                    child: Opacity(
                      opacity: Get.locale!.languageCode == 'en' ? 1 : 0.5,
                      child: SizedBox(
                        width: 78.w,
                        height: 55.h,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)), child: SvgPicture.asset('assets/xemo/lang-english.svg')),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 45.h,
              ),
              Container(
                // alignment: Alignment.center,
                padding: EdgeInsets.only(left: 0.01.sw),
                child: NextButtonWidget(width: 0.99.sw, nextScreenId: AuthRegisterPhoneView.id, enabled: true),
              )
            ],
          ),
        ));
  }
}
