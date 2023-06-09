import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/models/ModelProvider.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    //FormState? form = Form.of(context);

    return Obx(() {
      return Container(
        margin: EdgeInsets.only(top: 21.h, bottom: 18.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                authController.gender.value = Gender.Male;
                if (authController.formKeys[1].currentState!.validate()) {
                  authController.enableUserInfoNext.value = true;
                } else {
                  authController.enableUserInfoNext.value = false;
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 8.w),
                padding: const EdgeInsets.all(10.0),
                decoration: (authController.gender.value != null && authController.gender.value!.name == Gender.Male.name)
                    ? BoxDecoration(
                        color: Get.theme.primaryColorLight,
                        //  boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                        borderRadius: const BorderRadius.all(Radius.circular(24)),
                        border: Border.all(color: Get.theme.primaryColorLight, width: 2))
                    : BoxDecoration(
                        color: Colors.white,
                        //  boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                        borderRadius: const BorderRadius.all(Radius.circular(24)),
                        border: Border.all(color: Get.theme.primaryColorLight, width: 2)),
                child: Center(
                  child: Text(
                    "common.male".tr.capitalizeFirst!,
                    style: Get.textTheme.headline4!.copyWith(
                        color: (authController.gender.value != null && authController.gender.value!.name == Gender.Male.name)
                            ? Colors.white
                            : Get.theme.primaryColorLight),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                authController.gender.value = Gender.Female;
                if (authController.formKeys[1].currentState!.validate()) {
                  authController.enableUserInfoNext.value = true;
                } else {
                  authController.enableUserInfoNext.value = false;
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                padding: const EdgeInsets.all(10.0),
                decoration: (authController.gender.value != null && authController.gender.value!.name == Gender.Female.name)
                    ? BoxDecoration(
                        color: Get.theme.primaryColorLight,
                        //         boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                        borderRadius: const BorderRadius.all(Radius.circular(24)),
                        border: Border.all(color: Get.theme.primaryColorLight, width: 2))
                    : BoxDecoration(
                        color: Colors.white,
                        //       boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                        borderRadius: const BorderRadius.all(Radius.circular(24)),
                        border: Border.all(color: Get.theme.primaryColorLight, width: 2)),
                child: Center(
                  child: Text(
                    "common.female".tr.capitalizeFirst!,
                    style: Get.textTheme.headline4!.copyWith(
                        color: (authController.gender.value != null && authController.gender.value!.name == Gender.Female.name)
                            ? Colors.white
                            : Get.theme.primaryColorLight),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                authController.gender.value = Gender.Other;
                if (authController.formKeys[1].currentState!.validate()) {
                  authController.enableUserInfoNext.value = true;
                } else {
                  authController.enableUserInfoNext.value = false;
                }
              },
              child: Container(
                margin: EdgeInsets.only(left: 10.w),
                padding: const EdgeInsets.all(10.0),
                decoration: (authController.gender.value != null && authController.gender.value!.name == Gender.Other.name)
                    ? BoxDecoration(
                        color: Get.theme.primaryColorLight,
                        //       boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                        borderRadius: const BorderRadius.all(Radius.circular(24)),
                        border: Border.all(color: Get.theme.primaryColorLight, width: 2))
                    : BoxDecoration(
                        color: Colors.white,
                        //       boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                        borderRadius: const BorderRadius.all(Radius.circular(24)),
                        border: Border.all(color: Get.theme.primaryColorLight, width: 2)),
                child: Center(
                  child: Text(
                    "common.Other".tr.capitalizeFirst!,
                    style: Get.textTheme.headline4!.copyWith(
                        color: (authController.gender.value != null && authController.gender.value!.name == Gender.Other.name)
                            ? Colors.white
                            : Get.theme.primaryColorLight),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
