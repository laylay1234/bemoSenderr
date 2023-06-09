import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/controllers/transaction_controller.dart';
import 'package:mobileapp/views/flinks_views/flinks_failed_view.dart';
import 'package:mobileapp/views/home/send_money_views/send_money_view.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../views/flinks_views/flinks_pending_view.dart';

class SendMoneyWidget extends StatelessWidget {
  const SendMoneyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    TransactionController transactionController = Get.find<TransactionController>();
    return Obx(() {
      if (!sendMoneyController.isNetworkAvailable.value) {
        return Container(
          margin: EdgeInsets.only(top: 50.h),
          height: 50.h,
          width: 275.w,
        );
      } else {
        return GestureDetector(
          onTap: () async {
            //Get.offNamed(FlinksFailedView.id);
            Get.toNamed(SendMoneyView.id);
            try {
              Get.dialog(Center(
                child: RotatedSpinner(
                  spinnerColor: SpinnerColor.GREEN,
                  height: 35,
                  width: 35,
                ),
              ));
              //await sendMoneyController.getExchangeRate('25');
              sendMoneyController.sendEditingController.value.text = sendMoneyController.minValue.value;
              await transactionController.loadUserLimits();
              transactionController.checkAndHandleTransactionLimitsByUserInput();
              sendMoneyController.calculateTotal();

              if (Get.isOverlaysOpen) {
                Get.back();
              }
            } catch (e) {
              if (Get.isOverlaysOpen) {
                Get.back();
              }
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 50.h),
            height: 50.h,
            width: 0.85.sw,
            decoration: BoxDecoration(
              color: kLightDisplayPrimaryAction,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: Offset(0, 3))],
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
              child: Text(
                'send.money.sendMoney'.tr.toUpperCase(),
                style: XemoTypography.buttonAllCapsWhite(context),
              ),
            ),
          ),
        );
      }
    });
  }
}
