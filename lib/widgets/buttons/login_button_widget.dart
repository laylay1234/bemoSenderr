import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/views/auth/auth.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    return Opacity(
      opacity: authController.isAppNeedUpdate.value ? 0.5 : 1,
      child: GestureDetector(
        key: const Key('loginButtonKey'),
        onTap: () {
          // bool _isAppNeedUpdate = await authController.validateVersion();
          // if (_isAppNeedUpdate == false) {
          //   Get.toNamed(LoginView.id);
          //   // Start the session timeout manager after login
          //   authController.startSessionTimer();
          // }
          authController.goNextStep(state: authController.credsLoginState);
        },
        child: Container(
          height: 50.h,
          width: 350.w,
          decoration: const BoxDecoration(
              color: Color(0xFFE8E8E8),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))]),
          child: Center(
            child: Text(
              "common.signIn".tr.toUpperCase(),
              style: Get.textTheme.button!.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }
}
