import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../entities/exchange_data_entity.dart';

class DeliveryMethodsWidget extends StatelessWidget {
  const DeliveryMethodsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    // log(sendMoneyController.deliveryMethods.length.toString());
    String lang = Get.locale!.languageCode.toLowerCase();
    return ListView.builder(
        itemCount: sendMoneyController.deliveryMethods.length,
        primary: false,
        padding: const EdgeInsets.only(right: 3, left: 3),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Obx(() {
            DeliveryMethod deliveryMethod = sendMoneyController.deliveryMethods[index];
            String deliveryMethodCode = deliveryMethod.code!.toLowerCase();
            bool isSelected = sendMoneyController.selectedCollectMethod.value.isEqual(deliveryMethod);
            bool isActive = deliveryMethod.active!.toLowerCase().contains('true');
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 0.2.sw,
                ),
                SizedBox(
                  width: 0.58.sw,
                  child: GestureDetector(
                    onTap: () {
                      if (!isSelected) {
                        if (isActive) {
                          sendMoneyController.selectedCollectMethod.value = deliveryMethod;
                          sendMoneyController.calculateTotal();
                        }
                      }
                    },
                    child: Opacity(
                      opacity: isActive ? 1 : 0.5,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 0.49.sw,
                              height: 70.h,
                              padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(35)),
                                  color: isSelected
                                      ? kLightDisplayPrimaryAction
                                      : isActive
                                          ? kLightDisplaySecondaryActionAlt
                                          : const Color(0x33333333).withOpacity(0.2)),
                              margin: const EdgeInsets.only(top: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(sendMoneyController.deliveryMethods[index].getCurrentName(),
                                      style: isSelected
                                          ? XemoTypography.captionDefaultSelected(context)
                                          : isActive
                                              ? XemoTypography.captionDefault(context)!.copyWith(color: kLightDisplayOnSecondaryActionAlt)
                                              : XemoTypography.captionDefault(context)),
                                  Container(
                                    width: 100.w,
                                    height: 25.h,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Text("\$ " + deliveryMethod.fee!,
                                          style: isSelected
                                              ? XemoTypography.captionDefaultHighlightSelected(context)
                                              : isActive
                                                  ? XemoTypography.captionDefault(context)!.copyWith(color: kLightDisplayOnSecondaryActionAlt)
                                                  : XemoTypography.captionDefault(context)),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // left: 20,
                            left: getImagePositioning('left', deliveryMethodCode, lang),
                            top: getImagePositioning('top', deliveryMethodCode, lang),
                            child: deliveryMethod.getImageWidget(
                              type: !isActive ? DeliveryMethodImageType.disabled : DeliveryMethodImageType.active,
                              height: getImageDimensions('height', deliveryMethodCode),
                              width: getImageDimensions('width', deliveryMethodCode),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 0.2.sw,
                ),
              ],
            );
          });
        });
  }

  double getImagePositioning(String position, String methodCode, String lang) {
    switch (position) {
      case 'left':
        if (methodCode.contains('cash')) {
          if (lang == 'fr') {
            return -2;
          }
          return -2;
        }
        if (methodCode.contains('bank')) {
          if (lang == 'fr') {
            return 3;
          }
          return 3;
        }
        return 0;
      case 'top':
        if (methodCode.contains('cash')) return 5;
        if (methodCode.contains('bank')) return 9;
        return 7;
      default:
        return 0;
    }
  }

  double getImageDimensions(String axis, String methodCode) {
    switch (axis) {
      case 'width':
        if (methodCode.contains('cash')) return 70.w;
        if (methodCode.contains('bank')) return 60.w;
        return 66.w;
      case 'height':
        if (methodCode.contains('cash')) return 70.h;
        if (methodCode.contains('bank')) return 60.h;
        return 66.h;
      default:
        return 0;
    }
  }
}
