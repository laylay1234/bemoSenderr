import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/home/send_money/cancel_confirm_button_widget.dart';
import 'package:mobileapp/widgets/home/send_money/min_max_send_money_text_widget.dart';
import 'package:mobileapp/widgets/home/send_money/total_amount_fees_texts_widget.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/widgets/home/send_money/delivery_methods_widget.dart';
import 'package:mobileapp/widgets/home/send_receive_amount_widget.dart';

class SendMoneyView extends StatelessWidget {
  static const String id = '/send-money-view';

  const SendMoneyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    //
    //
    //
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Scaffold(
        appBar: XemoAppBar(leading: true, function: sendMoneyController.prevStep),
        bottomSheet: null,
        body: ListView(
          primary: true,
          children: [
            Container(
              height: 50.h,
            ),
            const SendRecieveAmountWidget(),
            Container(
              height: 40.h,
            ),
            //min,max text
            const MinMaxSendMoneyTextWidget(),
            Container(
              height: 5.h,
            ),
            const DeliveryMethodsWidget(),
            Container(
              height: 30.h,
            ),
            Container(
              margin: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: const Divider(
                height: 10,
                thickness: 2,
                color: Color(0X39393980),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 18.0, left: 0.03.sw, right: 0.03.sw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [Spacer(), TotalAmountAndFeesTextsWidget()],
              ),
            ),
            //
            //
            const CancelConfirmButtonsWidget()
          ],
        ));
  }
}
