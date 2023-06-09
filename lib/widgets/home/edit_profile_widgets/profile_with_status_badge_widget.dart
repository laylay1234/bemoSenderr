import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class ProfileWithStatusBadgeWidget extends StatelessWidget {
  const ProfileWithStatusBadgeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();

    return Obx(() {
      return Column(
        children: [
          SizedBox(
            height: 135.h,
            width: 183.w,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    'assets/xemo/avatar-generic_big_3x.svg',
                    height: 113.h,
                    width: 113.w,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: Container(
                    height: 42.h,
                    width: 180.w,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20)), boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      )
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          profileController.userInstance!.value.kyc_level == 0
                              ? "userTier.widget.connect.unverified".tr
                              : profileController.userInstance!.value.kyc_level == 1
                                  ? "userTier.widget.connect.verified".tr
                                  : "userTier.widget.connect.premium".tr,
                          textAlign: TextAlign.center,
                          style: XemoTypography.bodyAllCapsLight(context),
                        ),
                        SvgPicture.asset(
                          profileController.userInstance!.value.kyc_level == 0
                              ? 'assets/xemo/icon-account-level-1.svg'
                              : profileController.userInstance!.value.kyc_level == 1
                                  ? 'assets/xemo/icon-account-level-2.svg'
                                  : 'assets/xemo/icon-account-level-3.svg',
                          height: 32.h,
                          width: 32.w,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 15.h,
          ),
          Text(
            profileController.userInstance!.value.profile!.first_name + " " + profileController.userInstance!.value.profile!.last_name,
            textAlign: TextAlign.center,
            style: XemoTypography.headLine4FullName(context),
          )
        ],
      );
    });
  }
}
