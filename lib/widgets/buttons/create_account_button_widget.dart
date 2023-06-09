import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class CreateAccountButtonWidget extends StatelessWidget {
  const CreateAccountButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50.h,
        width: 1.sw,
        margin: EdgeInsets.only(bottom: 5.h),
        child: Container(
          //   width: 0.1.sw,
          // ignore: prefer_const_constructors
          decoration: BoxDecoration(
              color: kLightDisplayPrimaryAction,
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [const BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              )),
          child: Center(
            child: Text(
              "auth.signup.create.my.account".tr.toUpperCase(),
              style: XemoTypography.buttonAllCapsWhite(context),
            ),
          ),
        ),
      ),
    );
  }
}
