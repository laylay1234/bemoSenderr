import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/views/home/settings_views/change_password_view.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_clear_textFormField_widget.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/common/xemo_text_form_field_widget.dart';
import 'package:mobileapp/widgets/forms/textfields/phone_textfield_widget.dart';
import 'package:mobileapp/widgets/home/edit_profile_widgets/profile_with_status_badge_widget.dart';
import 'package:mobileapp/widgets/scaffolds/sb_scrollable_scaffold.dart';
import 'package:mobileapp/widgets/snackbars/successfully_updated_data_snackbar.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../utils/error_alerts_utils.dart';

class EditProfileView extends StatelessWidget {
  static const String id = '/edit-profile-view';

  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    ProfileController profileController = Get.find<ProfileController>();
    OriginController originController = Get.find<OriginController>();
    authController.isSubscribedToNewsLetter.value = profileController.userInstance!.value.newsletter_subscription;
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return MBScrollableScaffold(
      appBar: XemoAppBar(leading: true),
      bottomSheet: null,
      body: Obx(() {
        return Form(
          key: authController.editProfileFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                const ProfileWithStatusBadgeWidget(),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  margin: EdgeInsets.only(right: (0.05.sw + 0), left: 0.05.sw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // margin: const EdgeInsets.only(left: 2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                top: 25.h,
                              ),
                              child: Text(
                                "account.language.title".tr.toUpperCase(),
                                textAlign: TextAlign.start,
                                style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: 1.sw,
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xFF9B9B9B)))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(''),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          try {
                                            authController.langPreference.value = 'French';
                                            profileController.appLocale.value = const Locale('fr', 'FR');
                                            //Locale locale;
                                            Locale locale = const Locale('fr', 'FR');
                                            //log('fr');
                                            Jiffy.locale("FR");
                                            Get.updateLocale(locale);
                                            authController.getFlinksUrl(origine_iso_code: originController.origin_country_iso.value);
                                          } catch (e) {
                                            log(e.toString());
                                          }
                                        },
                                        child: Opacity(
                                          opacity: profileController.appLocale.value == const Locale('fr', 'FR') ? 1 : 0.5,
                                          child: SizedBox(
                                            width: 43.w,
                                            height: 43.h,
                                            child: SvgPicture.asset('assets/xemo/lang-french.svg'),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 20.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          try {
                                            authController.langPreference.value = 'English';
                                            profileController.appLocale.value = const Locale('en', 'US');
                                            Locale locale = const Locale('en', 'US');
                                            Jiffy.locale("EN");
                                            Get.updateLocale(locale);
                                            authController.getFlinksUrl(origine_iso_code: originController.origin_country_iso.value);
                                          } catch (e) {
                                            log(e.toString());
                                          }
                                        },
                                        child: Opacity(
                                          opacity: profileController.appLocale.value == const Locale('en', 'US') ? 1 : 0.5,
                                          child: SizedBox(
                                            width: 43.w,
                                            height: 43.h,
                                            child: SvgPicture.asset('assets/xemo/lang-english.svg'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //phone section

                      PhoneTextFieldWidget(
                        enabled: false,
                        fromLogin: false,
                      ),
                      Container(
                        height: 0.h,
                      ),
                      //email section
                      Container(
                        //  padding: const EdgeInsets.only(left: 5.0),
                        child: XemoTextFormWithTitleAndNote(
                          width: 1.sw,
                          enableRightMargin: false,
                          margin: const EdgeInsets.only(top: 5.0),

                          //  enableNote: false,
                          controller: authController.emailRxController,
                          formKey: authController.editProfileFormKey, //changePasswordFormKey
                          textFieldKey: authController.emailKey,
                          enableNext: authController.enableUpdateProfile,
                          title: "common.email.title".tr,
                          note: "common.note.required".tr,
                          validator: XemoFormValidatorWidget().emailValidator,
                        ),
                      ),
                      Container(
                        height: 0.h,
                      ),
                      //occupation
                      Container(
                        //    padding: const EdgeInsets.only(left: 5.0),
                        child: XemoTextFormWithTitleAndNote(
                          width: 1.sw,
                          margin: const EdgeInsets.only(top: 5.0),
                          enableRightMargin: false,

                          //enableNote: false,
                          controller: authController.occupationRxController,
                          formKey: authController.editProfileFormKey, //changePasswordFormKey
                          textFieldKey: authController.occupationKey,
                          enableNext: authController.enableUpdateProfile,
                          title: "auth.signup.iddoc.occupation".tr,
                          note: "common.note.required".tr,
                          validator: XemoFormValidatorWidget().occupationValidator,
                          //  obscure: true,
                          //  isConfirmPasswordField: false,
                          //  showOrHide: authController.showPassword,
                        ),
                      ),

                      Container(
                        width: 1.sw,
                        margin: EdgeInsets.only(top: 23.h, left: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Get.locale == const Locale('en', 'US')
                                ? Text(
                                    "common.password.title".tr.toUpperCase(),
                                    style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
                                  )
                                : Text(
                                    "common.password.title".tr.toUpperCase(),
                                    style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
                                  ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(ChangePasswordView.id);
                              },
                              child: Container(
                                height: 40.h,
                                padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                                // width: 96.w,
                                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xFFC4C4C4)),
                                child: Center(
                                  child: Text(
                                    "auth.changeYourPassword.text.title".tr.split(' ').first.toUpperCase(),
                                    style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 14.sp, color: kLightDisplayInfoText),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 50.h),
                        child: Row(
                          children: [
                            Checkbox(
                                value: authController.isSubscribedToNewsLetter.value,
                                checkColor: Colors.white,
                                focusColor: Colors.white,
                                activeColor: Get.theme.primaryColorLight,
                                onChanged: (val) {
                                  authController.isSubscribedToNewsLetter.value = val!;
                                  if (authController.isSubscribedToNewsLetter.value !=
                                      profileController.userInstance!.value.newsletter_subscription) {
                                    authController.enableUpdateProfile.value = true;
                                  } else {
                                    authController.enableUpdateProfile.value = false;
                                  }
                                }),
                            Expanded(child: Text("auth.signup.newsletter".tr, style: XemoTypography.bodyDefault(context))),
                          ],
                        ),
                      ),
                      Opacity(
                        opacity: authController.enableUpdateProfile.value ? 1 : 0.5,
                        child: GestureDetector(
                          onTap: () async {
                            if (authController.enableUpdateProfile.value) {
                              try {
                                //
                                Get.dialog(Center(
                                  child: RotatedSpinner(
                                    spinnerColor: SpinnerColor.GREEN,
                                    height: 45,
                                    width: 45,
                                  ),
                                ));
                                await authController.updateProfile();
                                Get.back();
                                startSuccessfullyUpdatedDataSnackbar();
                                //
                              } catch (error, stackTrace) {
                                Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
                                log(error.toString());
                                if (Get.isOverlaysOpen) {
                                  Get.back();
                                }
                              }
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 50.h, bottom: 10.h),
                            width: 1.sw,
                            height: 50.h,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: kLightDisplayPrimaryAction,
                                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
                            child: Center(
                              child: Text(
                                'common.save'.tr.toUpperCase(),
                                style: XemoTypography.buttonAllCapsWhite(context),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
