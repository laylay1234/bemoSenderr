import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/controllers/transaction_controller.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/widgets/dialogs/cancel_send_money_dialog_widget.dart';
import 'package:mobileapp/widgets/dialogs/send_email_confirmation_dialog_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class CancelConfirmButtonsWidget extends StatelessWidget {
  const CancelConfirmButtonsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    ProfileController profileController = Get.find<ProfileController>();
    TransactionController transactionController = Get.find<TransactionController>();

//
    return Obx(() {
      return Container(
          margin: EdgeInsets.only(top: 0.04.sh, left: 0.03.sw, right: 0.03.sw),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  //Get.back();
                  openCancelSendMoneyDialog();
                },
                child: Container(
                  width: 0.41.sw,
                  height: 67.h,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: const Color(0xFFE8E8E8),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
                  child: Center(
                    child: Text(
                      'common.cancel'.tr.toUpperCase(),
                      style: Get.theme.textTheme.button,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  //  log(transactionController.isTransactionAllowed.value.toString());
                  if (!sendMoneyController.exchangeRate.value.isValid()) {
                    return;
                  }
                  if (profileController.userInstance!.value.user_status.name == GenericStatus.CONFIRMED.name) {
                    if (transactionController.isTransactionAllowed.value &&
                        sendMoneyController.selectedCollectMethod.value.active!.toLowerCase().contains('true')) {
                      if (sendMoneyController.stack.length >= 2) {
                        if (sendMoneyController.stack[sendMoneyController.stack.length - 2].name == sendMoneyController.checkoutState.name) {
                          bool result = await missingInformationChecker(
                              deliveryMethod: sendMoneyController.selectedCollectMethod.value.code,
                              addressBook: sendMoneyController.selectedReceiver.value,
                              sendMoneyController: sendMoneyController);
                          if (result == false) {
                            sendMoneyController.confirmBottomSheetState.enter();
                            sendMoneyController.nextStep();
                          }
                        } else {
                          if (sendMoneyController.deliveryMethods.where((e) => e.active!.toLowerCase() == 'true').isNotEmpty &&
                              sendMoneyController.selectedCollectMethod.value.active!.toLowerCase().contains('true')) {
                            bool result = await missingInformationChecker(
                                deliveryMethod: sendMoneyController.selectedCollectMethod.value.code,
                                addressBook: sendMoneyController.selectedReceiver.value,
                                sendMoneyController: sendMoneyController);
                            if (result == false) {
                              sendMoneyController.confirmBottomSheetState.enter();
                              sendMoneyController.nextStep();
                            }
                          }
                        }
                      } else {
                        if (sendMoneyController.deliveryMethods.where((e) => e.active!.toLowerCase() == 'true').isNotEmpty &&
                            sendMoneyController.selectedCollectMethod.value.active!.toLowerCase().contains('true')) {
                          bool result = await missingInformationChecker(
                              deliveryMethod: sendMoneyController.selectedCollectMethod.value.code,
                              addressBook: sendMoneyController.selectedReceiver.value,
                              sendMoneyController: sendMoneyController);
                          if (result == false) {
                            sendMoneyController.confirmBottomSheetState.enter();
                            sendMoneyController.nextStep();
                          }
                        }
                      }
                    }
                  } else {
                    //open dialoge
                    openConfirmEmailDialog();
                  }
                },
                child: Opacity(
                  opacity: (transactionController.isTransactionAllowed.value &&
                          sendMoneyController.exchangeRate.value.isValid() &&
                          sendMoneyController.selectedCollectMethod.value.active!.toLowerCase().contains('true') &&
                          sendMoneyController.deliveryMethods.where((e) => e.active!.toLowerCase() == 'true').isNotEmpty)
                      ? 1
                      : 0.5,
                  child: Container(
                    width: 0.41.sw,
                    height: 67.h,
                    //    padding: EdgeInsets.only(lef right: 5.w),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        color: kLightDisplayPrimaryAction,
                        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
                    child: Center(
                      child: Text(
                        'send.money.sendBalance'.tr.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: XemoTypography.buttonAllCapsWhite(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ));
    });
  }

  Future<bool> missingInformationChecker(
      {@required String? deliveryMethod, @required AddressBook? addressBook, @required SendMoneyController? sendMoneyController}) async {
    try {
      if (deliveryMethod!.toLowerCase().contains('bank')) {
        //parameters: {'is_swift_account_required': 'true'} ,
        if (addressBook!.account_number == null) {
          sendMoneyController!.selectReceiverState.enter();
          sendMoneyController.nextStep();
          return true;
        } else if (addressBook.account_number!.isEmpty) {
          sendMoneyController!.selectReceiverState.enter();
          sendMoneyController.nextStep();
          return true;
        } else if (addressBook.bank_swift_code == null) {
          sendMoneyController!.selectReceiverState.enter();
          sendMoneyController.nextStep();
          return true;
        } else if (addressBook.bank_swift_code!.isEmpty) {
          sendMoneyController!.selectReceiverState.enter();
          sendMoneyController.nextStep();
          return true;
        } else {
          return false;
        }
      } else if (deliveryMethod.toLowerCase().contains('mobile')) {
        if (addressBook!.mobile_network == null) {
          sendMoneyController!.selectReceiverState.enter();
          sendMoneyController.nextStep();
          return true;
        } else if (addressBook.mobile_network!.isEmpty) {
          sendMoneyController!.selectReceiverState.enter();
          sendMoneyController.nextStep();
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
