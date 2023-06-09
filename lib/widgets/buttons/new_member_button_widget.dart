import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/views/auth/auth_choose_lang_view.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class NewMemberButtonWidget extends StatelessWidget {
  const NewMemberButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return Opacity(
      opacity: authController.isAppNeedUpdate.value ? 0.5 : 1,
      child: GestureDetector(
        onTap: () async {
          bool _isAppNeedUpdate = await authController.validateVersion();
          if (_isAppNeedUpdate == false) {
            authController.startSessionTimer();
            await Get.toNamed(AuthChooseLangView.id);
            //Get.toNamed(AuthRegisterUserCredentialView.id);
            // Go back to auth view page, no need to start timer
            authController.stopSessionTimer();
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: 25.h),
          height: 50.h,
          width: 350.w,
          decoration: const BoxDecoration(
              color: kLightDisplayPrimaryAction,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))]),
          child: Center(
            child: Text("auth.landing.newAccount".tr.toUpperCase(), style: XemoTypography.buttonAllCapsWhite(context)),
          ),
        ),
      ),
    );
  }
}
