import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

Future<DateTime?> showDateTimeSelector(BuildContext context, {DateTime? min, DateTime? max, DateTime? init}) async {
  Rx<DateTime?> time = (null as DateTime?).obs;
  return await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (context) => Container(
            height: 430.h,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 10,
                    ),
                    Row(
                      children: [
                        TextButton(
                          child: Text(
                            'common.cancel'.tr.toUpperCase(),
                            style: XemoTypography.buttonAllCapsWhite(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.w, left: 12.w),
                          child: TextButton(
                            child: Text(
                              'common.done'.tr.toUpperCase(),
                              style: XemoTypography.buttonAllCapsWhite(context)!.copyWith(color: Get.theme.primaryColorLight),
                            ),
                            onPressed: () => Navigator.pop(context, time.value),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 300,
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp, color: Get.theme.primaryColorLight),
                      ),
                    ),
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        initialDateTime: init,
                        minimumDate: min,
                        maximumDate: max, //Cannot be 2020
                        use24hFormat: true,
                        onDateTimeChanged: (val) {
                          time.value = val;
                        }),
                  ),
                ),
              ],
            ),
          ));
}
