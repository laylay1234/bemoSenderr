import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';

class OkButtonWidget extends StatelessWidget {
  const OkButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 162.w,
      margin: const EdgeInsets.only(top: 18.0),
      decoration: BoxDecoration(
          color: kLightDisplayPrimaryAction,
          boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(1, 1))],
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          )),
      child: Center(
        child: Text(
          "OK",
          style: Get.textTheme.headline4!.copyWith(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
