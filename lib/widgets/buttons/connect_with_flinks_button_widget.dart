import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/views/connect_flinks_web_view.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class ConnectWithFlinksButtonWidget extends StatelessWidget {
  const ConnectWithFlinksButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(ConnectWithFlinksWebView.id, arguments: {'fromRegister': false});
      },
      child: Container(
        height: 50.h,
        width: 325.w,
        margin: EdgeInsets.only(top: 18.h),
        decoration: const BoxDecoration(
            color: kLightDisplayPrimaryAction,
            boxShadow: [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(1, 1))],
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            )),
        child: Center(
          child: Text("auth.signup.consent.agree".tr.toUpperCase(), style: XemoTypography.buttonAllCapsWhite(context)),
        ),
      ),
    );
  }
}
