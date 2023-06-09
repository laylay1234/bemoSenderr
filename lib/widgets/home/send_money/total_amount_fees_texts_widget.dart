import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../constants/format.dart';

class TotalAmountAndFeesTextsWidget extends StatelessWidget {
  const TotalAmountAndFeesTextsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    //ProfileController profileController = Get.find<ProfileController>();
    //
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sendMoneyController.exchangeRate.value.isValid()
              ? Text(
                  "\$1 ${sendMoneyController.originCurrency.value!.iso_code.toUpperCase()} = " +
                      (sendMoneyController.exchangeRate.value.rate != null
                          ? double.parse(sendMoneyController.exchangeRate.value.rate!).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                              " " +
                              sendMoneyController.destinationCurrency!.value.iso_code.toUpperCase().tr
                          : ''),
                  textAlign: TextAlign.center,
                  style: XemoTypography.captionBold(context),
                )
              : Container(
                  padding: EdgeInsets.only(right: 58.w),
                  child: RotatedSpinner(
                    spinnerColor: SpinnerColor.GREEN,
                    height: 35,
                    width: 35,
                  ),
                ),
          sendMoneyController.exchangeRate.value.isValid()
              ? RichText(
                  text: TextSpan(text: 'common.total'.tr, style: XemoTypography.headLine5Total(context), children: [
                  const TextSpan(text: ' : '),
                  TextSpan(
                    text: '\$ ' + sendMoneyController.totalAmount.value.toStringAsFixed(AMOUNT_FORMAT_DECIMALS),
                    style: XemoTypography.headLine5Bold(context),
                  )
                ]))
              : Container(
                  height: 4,
                )
        ],
      );
    });
  }
}
