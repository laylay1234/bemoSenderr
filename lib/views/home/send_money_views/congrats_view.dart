import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';

class CongratsView extends StatelessWidget {
  static const String id = '/congrats-view';
  const CongratsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    late final ProfileController profileController = Get.find<ProfileController>();
    //Get.updateLocale(Locale('en', 'US'));
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Scaffold(
      appBar: XemoAppBar(leading: false),
      bottomSheet: null,
      body: WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(height: 20.h),
              Text(
                'send.money.congratulations'.tr,
                textAlign: TextAlign.center,
                style: Get.textTheme.headline3!.copyWith(
                  color: const Color(0xFF191C1F),
                  fontWeight: FontWeight.w700,
                  fontSize: 28.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: Text(
                  'send.money.WaitingPayment'.tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline3!.copyWith(
                    color: const Color(0xFF191C1F),
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 42.h,
              ),
              SvgPicture.asset(
                'assets/xemo/congratulation_3x.svg',
                height: 213.h,
                width: 199.w,
              ),
              SizedBox(
                height: 31.h,
              ),
              Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Text(
                  'send.money.recievedSms'.tr,
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline3!.copyWith(
                    color: const Color(0xFF191C1F),
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 15),
                child: Text(
                  'send.money.willBeCanceled'.tr.replaceFirst('@', valueToFundingTime(profileController.appSettings['fundingExpTime'])),
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline3!.copyWith(
                    color: const Color(0xFF191C1F),
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              Container(
                height: 60.h,
              ),
              GestureDetector(
                onTap: () {
                  sendMoneyController.sendMoneyDoneState.enter();
                  sendMoneyController.nextStep();
                  sendMoneyController.resetSendMoneyData();
                },
                child: Container(
                  height: 50.h,
                  width: 286.w,
                  padding: const EdgeInsets.all(5.0),
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: kLightDisplayPrimaryAction,
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), offset: Offset(0, 3), blurRadius: 5)]),
                  child: Center(
                    child: Text(
                      'send.money.returnToMyAccount'.tr.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Get.textTheme.headline3!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String valueToFundingTime(String val) {
    String result = '';
    String firstPart = '';
    String secPart = '';
    //add the hours value
    firstPart = val.split('.').first;
    result = firstPart + "h";

    //add the minutes value
    if (val.split('.').length > 1) {
      secPart = val.split('.')[1];
      secPart = '0.' + secPart;
      double secValue = double.parse(secPart);
      double value = 60 * secValue;
      result = result + " " + value.toStringAsFixed(0) + " min";
    }

    return result;
  }
}
