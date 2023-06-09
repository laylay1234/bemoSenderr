import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/controllers/transaction_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class MinMaxSendMoneyTextWidget extends StatelessWidget {
  const MinMaxSendMoneyTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    TransactionController transactionController = Get.find<TransactionController>();
    OriginController originController = Get.find<OriginController>();
    //
    //TODO handle LimitErrors to display the right error texts
    return Obx(() {
      switch (transactionController.limitError.value) {
        case LimitErrors.NONE:
          return Container(
            margin: EdgeInsets.only(left: 2.w, right: 2.w),
            height: 0.06.sh,
          );
        case LimitErrors.MIN:
          return Container(
            margin: EdgeInsets.only(left: 2.w, right: 2.w),
            height: 0.06.sh,
            child: Text(
              'send.money.error.minTransactionValue'
                  .tr
                  // TODO: Fix usage of variables
                  .replaceFirst('@', transactionController.minValue.value + sendMoneyController.originCurrency.value!.sign.toUpperCase()),
              textAlign: TextAlign.center,
              style: XemoTypography.bodySmall(context)!.copyWith(color: kLightDisplayErrorText),
            ),
          );
        // break;
        case LimitErrors.TX_LIMIT_ERROR:
          return Container(
            margin: EdgeInsets.only(left: 2.w, right: 2.w),
            height: 0.12.sw,
            child: Text(
              // TODO: Fix usage of variables
              'send.money.error.maxValuePerTransaction'.tr.replaceFirst(
                  '@', transactionController.userLimitsEntity.value.tx_max.toString() + sendMoneyController.originCurrency.value!.sign.toUpperCase()),
              textAlign: TextAlign.center,
              style: XemoTypography.bodySmall(context)!.copyWith(color: kLightDisplayErrorText),
            ),
          );
        case LimitErrors.REMAIN_LIMIT_ERROR:
          return Container(
              margin: EdgeInsets.only(left: 2.w, right: 2.w),
              height: 0.12.sw,
              child: Text(
                'send.money.error.remainTransactionValue'.tr,
                textAlign: TextAlign.center,
                style: XemoTypography.bodySmall(context)!.copyWith(color: kLightDisplayErrorText),
              ));
      }
      //return Container();
    });
  }
}
