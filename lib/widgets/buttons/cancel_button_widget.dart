import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CancelButtonWidget extends StatelessWidget {
  const CancelButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 162.w,
      margin: const EdgeInsets.only(top: 18.0),
      decoration: const BoxDecoration(
          color: Color(0xFFE8E8E8),
          boxShadow: [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(1, 1))],
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
      child: Center(
        child: Text(
          "common.cancel".tr.toUpperCase(),
          style: Get.textTheme.headline4!.copyWith(fontWeight: FontWeight.w700, fontSize: 16, color: const Color(0xFF5B554E)),
        ),
      ),
    );
  }
}
