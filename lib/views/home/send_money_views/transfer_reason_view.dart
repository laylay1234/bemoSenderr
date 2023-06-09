import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/models/TransferReason.dart';
import 'package:mobileapp/widgets/scaffolds/sb_scrollable_scaffold.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class TransferReasonView extends StatelessWidget {
  static const String id = '/transfer-reason-view';

  const TransferReasonView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return MBScrollableScaffold(
      bottomSheet: null,
      appBar: XemoAppBar(leading: true, function: sendMoneyController.prevStep),
      body: Obx(() {
        return Container(
          margin: EdgeInsets.only(top: 19.0.h, left: 0.05.sw, right: 0.055.sw),
          child: Column(
            children: [
              Text(
                'send.money.additional.info'.tr.capitalize!,
                style: XemoTypography.headLine1Black(context)!.copyWith(fontSize: 31.sp),
              ),
//            DropdownWidget(typeList: sendMoneyController.transferReasonEnumsToList(), rxSelector: sendMoneyController.transferReason, height: 50)

              InkWell(
                onTap: () {
                  openTransferReasonDialog(context);
                },
                child: Container(
                  height: 80.h,
                  width: 0.9.sw,
                  margin: EdgeInsets.only(top: 28.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'send.money.transfer.reason'.tr.capitalize!.toUpperCase(),
                                style: XemoTypography.bodyAllCapsSecondary(context),
                              ),
                              Text("common.note.required".tr,
                                  style: sendMoneyController.transferReason.value != null
                                      ? XemoTypography.captionItalic(context)!.copyWith(
                                          fontWeight: FontWeight.w200,
                                          fontStyle: FontStyle.italic,
                                          fontSize: 12.sp,
                                          color: kLightDisplaySecondaryTextColor,
                                        )
                                      : XemoTypography.captionItalic(context)!.copyWith(
                                          fontWeight: FontWeight.w200,
                                          fontSize: 12.sp,
                                        )),

                              sendMoneyController.transferReason.value != null
                                  ? Text(
                                      sendMoneyController.transferReason.value!.name.replaceAll((RegExp('_+')), ' ').tr.capitalize!,
                                      style: XemoTypography.bodyAllCapsBlack(context),
                                    )
                                  : Container(
                                      height: 20,
                                    ),
                              //                  note: "auth.signup.required".tr,
                            ],
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 30.h,
                            width: 30.w,
                            child: Icon(
                              FontAwesomeIcons.chevronDown,
                              color: Get.theme.primaryColorLight,
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        height: 1,
                        width: 345.w,
                        color: const Color(0xFF9B9B9B),
                      )
                    ],
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  //sendMoneyController.sendMoneyOperation();
                  if (sendMoneyController.transferReason.value != null) {
                    sendMoneyController.checkoutState.enter();
                    sendMoneyController.nextStep();
                  }
                },
                child: Opacity(
                  opacity: sendMoneyController.transferReason.value != null ? 1 : 0.5,
                  child: Container(
                    margin: EdgeInsets.only(top: 135.h),
                    height: 50.h,
                    width: 345.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF20C9A7),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5)],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        'common.send'.tr.toUpperCase(),
                        style: Get.textTheme.headline5!.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Future<void> openTransferReasonDialog(BuildContext context) async {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    //  int index = 0;
    return showDialog(
        context: context,
        builder: (context) {
          return Obx(() {
            return AlertDialog(
              contentPadding: EdgeInsets.only(bottom: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: Container(
                width: 0.8.sw,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      //padding: EdgeInsets.only(right: 10.w),
                      margin: EdgeInsets.only(top: 20.h, left: 10.w),
                      height: 39.h,
                      child: Text(
                        'send.money.transfer.reason'.tr.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: XemoTypography.headLine5Black(context),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 11.h),
                      height: 1,
                      color: const Color(0XFF737373),
                    ),
                    Column(
                      children: TransferReason.values.map((e) {
                        return GestureDetector(
                          onTap: () {
                            sendMoneyController.preTransferReason.value = TransferReason.values.where((v) => v.name == e.name).first;
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Theme(
                              data: Get.theme.copyWith(unselectedWidgetColor: const Color(0xFF9B9B9B), disabledColor: const Color(0xFF9B9B9B)),
                              child: ListTile(
                                title: Text(e.name.replaceAll((RegExp('_+')), ' ').tr.capitalize.toString(),
                                    style: XemoTypography.bodySemiBold(context)),
                                leading: Radio<String>(
                                    activeColor: kLightDisplayPrimaryAction,
                                    hoverColor: Colors.black,

                                    //fillColor: MaterialStateColor.resolveWith((states) => Get.theme.primaryColorLight),
                                    focusColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                    value: e.name,
                                    groupValue:
                                        sendMoneyController.preTransferReason.value != null ? sendMoneyController.preTransferReason.value!.name : '',
                                    onChanged: (value) {
                                      sendMoneyController.preTransferReason.value = TransferReason.values.where((e) => e.name == value).first;
                                    }),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  sendMoneyController.transferReason.value = null;
                                  Get.back();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 28.w),
                                  height: 21.h,
                                  // width: 67.w,
                                  child: Text(
                                    'common.cancel'.tr.toUpperCase(),
                                    style: Get.textTheme.headline3!
                                        .copyWith(color: kLightDisplayPrimaryAction, fontSize: 14.sp, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  sendMoneyController.transferReason.value = sendMoneyController.preTransferReason.value;
                                  Get.back();
                                },
                                child: Container(
                                  //  margin: const EdgeInsets.only(right: 6.0),
                                  height: 21.h,
                                  width: 50.w,
                                  child: Text(
                                    'OK',
                                    style: Get.textTheme.headline3!
                                        .copyWith(color: kLightDisplayPrimaryAction, fontSize: 14.sp, fontWeight: FontWeight.w500),
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
        });
  }
}


//                    sendMoneyController.transferReason.value = TransferReason.values.where((e) => e.name == val).first;
