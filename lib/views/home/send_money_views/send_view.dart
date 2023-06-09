import 'dart:math';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/common/kyc_bank_verification_status_widget.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/home/transaction_history_card_widget.dart';
import 'package:mobileapp/widgets/home/send_money_widget.dart';
import 'package:mobileapp/widgets/home/send_to_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../widgets/dialogs/countrt_selector_dialog_widget.dart';

class SendView extends StatelessWidget {
  const SendView({Key? key}) : super(key: key);
  static const String id = '/send-view';

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);
    return Scaffold(
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 18.0),
                color: Get.theme.primaryColorLight,
                //    height: 210.h,
                child: sendMoneyController.originAbleToSend.value
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: const [SendToWidget(), SendMoneyWidget()],
                      )
                    : Container(
                        alignment: Alignment.center,
                        child: Text(
                          'your origin country is disactived or has no destinations',
                          textAlign: TextAlign.center,
                          style: XemoTypography.bodySmall(context),
                        ),
                      ),
              ),
              KycBankVerificationStatusWidget(
                inSettings: false,
              ),
              profileController.globalTransactionsIsLoading.value
                  ? Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 50.h),
                        child: RotatedSpinner(
                          spinnerColor: SpinnerColor.GREEN,
                          height: 35,
                          width: 35,
                        ),
                      ),
                    )
                  : (profileController.globalTransactions != null && profileController.globalTransactions!.value.isNotEmpty)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 18.w, top: 10.0),
                                child: Text(
                                  'home.label.latestTransaction'.tr,
                                  style: XemoTypography.captionDefault(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                                )),
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                primary: false,
                                itemCount: profileController.globalTransactions != null ? min(profileController.globalTransactions!.length, 3) : 0,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: index == (min(profileController.globalTransactions!.length, 3) - 1) ? 20.h : 0),
                                    child: TransactionHistoryCardWidget(
                                      globalTransaction: profileController.globalTransactions![index],
                                    ),
                                  );
                                }),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 18.w, top: 10.0),
                                child: Text(
                                  'home.label.latestTransaction'.tr,
                                  style: XemoTypography.captionDefault(context)!.copyWith(color: kLightDisplaySecondaryTextColor),
                                )),
                            Container(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(top: 80.h),
                              child: Text(
                                'history.label.noRecentTransactionsHistory'.tr.capitalizeFirst!,
                                textAlign: TextAlign.center,
                                style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
                              ),
                            ),
                          ],
                        ),
            ],
          ),
        );
      }),
    );
  }
}
