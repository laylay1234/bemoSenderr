import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

Future<void> openNetworkTypeDialog(BuildContext context, bool fromSendMoney, bool is_mobile_required) async {
  // bool fromSendMoney=false;
  ContactsController contactsController = Get.find<ContactsController>();
  return showDialog(
      builder: (BuildContext context) {
        return Obx(() {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(bottom: 20.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              width: 0.8.sw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(top: 20.h, left: 0.02.sw),
                    height: 39.h,
                    child: Text(
                      'contact.note.mobileNetwork'.tr.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: XemoTypography.headLine5Black(context),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 11.h),
                    // width: double.maxFinite,
                    height: 1,
                    color: const Color(0XFF737373),
                  ),
                  Column(
                    children: contactsController.mobileNetwors
                        .map((e) => GestureDetector(
                              onTap: () {
                                contactsController.selectedMobileNetwork.value = (e ?? '');
                                if (fromSendMoney && is_mobile_required) {
                                  if (contactsController.formKey.value.currentState != null) {
                                    if (contactsController.formKey.value.currentState!.validate()) {
                                      contactsController.enableSave.value = true;
                                    }
                                  }
                                }
                              },
                              child: Theme(
                                data: Get.theme.copyWith(unselectedWidgetColor: const Color(0xFF9B9B9B), disabledColor: const Color(0xFF9B9B9B)),
                                child: ListTile(
                                  title: Text(e.toString().toUpperCase(), style: XemoTypography.bodySemiBold(context)),
                                  leading: Container(
                                    margin: EdgeInsets.only(left: 0.025.sw),
                                    child: Radio<String>(
                                        activeColor: Get.theme.primaryColorLight,
                                        hoverColor: Colors.black,

                                        //fillColor: MaterialStateColor.resolveWith((states) => Get.theme.primaryColorLight),
                                        focusColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                        value: e,
                                        groupValue: contactsController.selectedMobileNetwork.value,
                                        onChanged: (value) {
                                          //log(value);
                                          contactsController.selectedMobileNetwork.value = (value ?? '');
                                          if (fromSendMoney && is_mobile_required) {
                                            if (contactsController.formKey.value.currentState != null) {
                                              if (contactsController.formKey.value.currentState!.validate()) {
                                                contactsController.enableSave.value = true;
                                              }
                                            }
                                          }
                                        }),
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 11.h),
                    height: 1,
                    color: const Color(0XFF737373),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 13.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 10.w,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                contactsController.selectedMobileNetwork.value = '';
                                if (fromSendMoney && is_mobile_required) {
                                  if (contactsController.formKey.value.currentState != null) {
                                    if (contactsController.formKey.value.currentState!.validate()) {
                                      contactsController.enableSave.value = false;
                                    }
                                  }
                                }
                                Get.back();
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 28.w),
                                height: 21.h,
                                // width: 67.w,
                                child: Text(
                                  'common.cancel'.tr.toUpperCase(),
                                  style: Get.textTheme.headline3!
                                      .copyWith(color: Get.theme.primaryColorLight, fontSize: 14.sp, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                //log(authController.documentIdType!.value);
                                Get.back();
                              },
                              child: SizedBox(
                                height: 21.h,
                                width: 50.w,
                                child: Text(
                                  'OK',
                                  style: Get.textTheme.headline3!
                                      .copyWith(color: Get.theme.primaryColorLight, fontSize: 14.sp, fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
      },
      context: context);
}
