import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/widgets/buttons/just_connect_with_flinks_home_button_widget.dart';
import 'package:mobileapp/widgets/buttons/user_tier_verification_in_progress.dart';
import 'package:mobileapp/widgets/common/badge_user_tier_level_widget.dart';
import 'package:mobileapp/widgets/common/kyc_bank_verification_status_desc_widget.dart';

import 'kyc_bank_verifcation_bottom_text_widget.dart';

class KycBankVerificationStatusWidget extends StatelessWidget {
  bool inSettings = false;
  KycBankVerificationStatusWidget({Key? key, this.inSettings = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final ProfileController profileController = Get.find<ProfileController>();
    return Obx(() {
      return profileController.userInstance!.value.bank_verification_status == null
          ? Container()
          : profileController.userInstance!.value.bank_verification_status!.name == UserBankVerificaitonStatus.VERIFIED.name
              ? Container()
              : Container(
                  margin: EdgeInsets.only(bottom: 8.h, right: inSettings ? 9.w : 8.w, left: inSettings ? 0.w : 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15.h),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 5,
                              )
                            ],
                            gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                tileMode: TileMode.repeated,
                                stops: const [0.1, 0.4, 0.6, 0.8],
                                colors: [Colors.white, const Color(0xFFE1A329).withOpacity(0.4), const Color(0xFFE1A329), const Color(0xFFE1A329)])),
                        child: profileController.userInstance!.value.bank_verification_status != null
                            ? Container(
                                child: profileController.userInstance!.value.bank_verification_status!.name ==
                                        UserBankVerificaitonStatus.IN_PROGRESS.name
                                    ? Padding(
                                        padding: EdgeInsets.only(left: 8.w, right: 5.w, top: 5.h, bottom: 5.h),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const BadgeUserTierLevelWidget(),
                                            Spacer(),
                                            Expanded(
                                              flex: 15,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  //headline
                                                  const KycBankVerificationStatusDescWidget(),

                                                  Container(
                                                    height: 5.h,
                                                  ),
                                                  ReviewInProgressFlinksHomeButton()
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    //if its verified then its up 1 if not we ask him to verify it
                                    : profileController.userInstance!.value.bank_verification_status!.name == UserBankVerificaitonStatus.VERIFIED.name
                                        ? Container()
                                        : Padding(
                                            padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
                                            child: Row(
                                              children: [
                                                const BadgeUserTierLevelWidget(),
                                                Spacer(),
                                                Expanded(
                                                  flex: 17,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      //headline
                                                      const KycBankVerificationStatusDescWidget(),

                                                      Container(
                                                        height: 5.h,
                                                      ),
                                                      JustConnectWithFlinksHomeButton(
                                                        enable: true,
                                                        fromRegister: false,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ))

                            //for testing :D
                            : Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 5.h, bottom: 5.h),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const BadgeUserTierLevelWidget(),
                                    Spacer(),
                                    Expanded(
                                      flex: 17,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //headline
                                          const KycBankVerificationStatusDescWidget(),
                                          Container(
                                            height: 5.h,
                                          ),
                                          JustConnectWithFlinksHomeButton(
                                            enable: false,
                                            fromRegister: false,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ),
                      //todo
                      KycBankVerificationBottomText()
                    ],
                  ),
                );
    });
  }
}
