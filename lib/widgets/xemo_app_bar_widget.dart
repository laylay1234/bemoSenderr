import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobileapp/views/auth/auth.dart';
import 'package:mobileapp/views/auth/auth_register_phone_view.dart';

// ignore: non_constant_identifier_names
AppBar XemoAppBar({bool leading = false, Function? function}) {
  return AppBar(
    leading: leading
        ? GestureDetector(
            onTap: () {
             
              if (function != null) {
                function();

                //
                //if (Get.currentRoute != SendMoneyView.id) {
                //  Get.back();
                // }
                if (Get.currentRoute == LoginView.id) {
                  Get.back();
                }
                if (Get.currentRoute == AuthRegisterPhoneView.id) {
                  Get.back();
                }
              } else {
                Get.back();
              }
            },
            child: const Icon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            ),
          )
        : Container(),
    title: Container(
      padding: EdgeInsets.only(right: 0.135.sw),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/xemo/yxLogo-full.svg',
        width: 186.w,
        height: 35.h,
      ),
    ),
  );
}
