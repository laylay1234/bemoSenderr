import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/widgets/scaffolds/simulation_send_money_bottom_sheet.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class SimulationButtonWidget extends StatelessWidget {
  const SimulationButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openSimulationSendMoneyBottomSheet();
      },
      child: Container(
        width: 93.w,
        height: 33.h,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: const Color(0xFFE8E8E8),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
        child: Center(
          child: Text(
            'send.simulation'.tr,
            style: XemoTypography.captionSemiBold(context),
          ),
        ),
      ),
    );
  }
}
