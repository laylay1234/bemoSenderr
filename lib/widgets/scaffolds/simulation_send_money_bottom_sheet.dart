import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/format.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

void openSimulationSendMoneyBottomSheet() {
  Get.bottomSheet(const SimulationSendMoneySheetWidget());
}

class SimulationSendMoneySheetWidget extends StatelessWidget {
  const SimulationSendMoneySheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();

    return Container(
      height: 452.h,
      color: Colors.white,
      padding: EdgeInsets.only(top: 15.h, right: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 185.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 35,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
              //money to send
              Padding(
                padding: EdgeInsets.only(top: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Text('send.money.simulation.amountSent'.tr, style: XemoTypography.bodySmallSecondary(context)),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Text(
                        "\$" +
                            sendMoneyController.sendEditingController.value.text +
                            " ${sendMoneyController.originCurrency.value!.iso_code.toUpperCase()}",
                        style: XemoTypography.bodySemiBoldHighlight(context),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 15.w),
                        child: Text('amount.simulation.exchange.rate'.tr, style: XemoTypography.bodySmallSecondary(context))),
                    Text(
                      "\$1 ${sendMoneyController.originCurrency.value!.iso_code.toUpperCase()} = " +
                          (sendMoneyController.exchangeRate.value.rate != null
                              ? double.parse(sendMoneyController.exchangeRate.value.rate!).toStringAsFixed(AMOUNT_FORMAT_DECIMALS)
                              : '') +
                          " " +
                          sendMoneyController.destinationCurrency!.value.iso_code.toUpperCase().toString(),
                      textAlign: TextAlign.center,
                      style: XemoTypography.bodySemiBoldComplementry(context),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Text('amount.simulation.amountSent'.tr, style: XemoTypography.bodySmallSecondary(context)),
                    ),
                    Text(
                      sendMoneyController.receiveEditingController.value.text +
                          " " +
                          sendMoneyController.destinationCurrency!.value.iso_code.toUpperCase().toString(),
                      textAlign: TextAlign.center,
                      style: XemoTypography.bodySemiBoldHighlight(context),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Text('send.money.simulation.fees'.tr, style: XemoTypography.bodySmallSecondary(context)),
                    ),
                    Text(
                      "+\$" +
                          sendMoneyController.selectedCollectMethod.value.fee! +
                          " ${sendMoneyController.originCurrency.value!.iso_code.toUpperCase()}",
                      textAlign: TextAlign.center,
                      style: XemoTypography.bodySemiBoldComplementry(context),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15.w),
                  child: Container(
                    height: 2,
                    color: const Color(0x39393940),
                  )),
              Padding(
                padding: EdgeInsets.only(top: 15.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15.w),
                      child: Text('common.total'.tr, style: XemoTypography.bodySmallSecondary(context)),
                    ),
                    Text(
                      "\$" +
                          sendMoneyController.totalAmount.value.toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                          " ${sendMoneyController.originCurrency.value!.iso_code.toUpperCase()}",
                      textAlign: TextAlign.center,
                      style: XemoTypography.bodySemiBoldHighlight(context),
                    )
                  ],
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: 265.w,
              height: 58.h,
              margin: EdgeInsets.only(bottom: 12.w),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: kLightDisplaySecondaryActionAlt,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
              child: Center(
                child: Text(
                  'send.money.close.simulation'.tr.toUpperCase(),
                  style: XemoTypography.buttonAllCapsWhite(context)!.copyWith(color: kLightDisplayOnSecondaryAction, fontSize: 16.sp),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
