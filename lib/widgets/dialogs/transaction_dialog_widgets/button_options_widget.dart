import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/views/home_view.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

// ignore: must_be_immutable
class ButtonOptionsWidget extends StatelessWidget {
  GlobalTransaction? transaction;
  ButtonOptionsWidget({Key? key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    switch (transaction!.status) {
      case GlobalTransactionStatus.NEW:
        return Column(
          children: [
            Opacity(
              opacity: sendMoneyController.availableCountries!
                      .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                      .isNotEmpty
                  ? 1
                  : 0.7,
              child: GestureDetector(
                onTap: () async {
                  if (sendMoneyController.availableCountries!
                      .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                      .isNotEmpty) {
                    try {
                      Get.back();
                      Get.dialog(Center(
                        child: RotatedSpinner(
                          spinnerColor: SpinnerColor.GREEN,
                          height: 45,
                          width: 45,
                        ),
                      ));
                      await sendMoneyController.sendMoneyAgain(transaction!);

                      sendMoneyController.checkoutState.enter();
                      sendMoneyController.nextStep();
                      if (Get.isOverlaysOpen) {
                        Get.back();
                      }
                    } catch (e) {
                      if (Get.isOverlaysOpen) {
                        Get.back();
                      }
                    }
                  }
                },
                child: Container(
                  height: 58.h,
                  width: 287.w,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: sendMoneyController.availableCountries!
                              .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                              .isNotEmpty
                          ? kLightDisplayPrimaryAction
                          : Get.theme.primaryColorLight),
                  child: Center(
                    child: Text(
                      'transaction.send.again'.tr.toUpperCase(),
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 6.h,
            ),
            transaction!.parameters!.collect_method!.replaceAll('-', '').replaceAll(' ', '_').toLowerCase().contains('bank')
                ? Container()
                : GestureDetector(
                    onTap: () async {
                      try {
                        Get.dialog(Center(
                          child: RotatedSpinner(
                            spinnerColor: SpinnerColor.GREEN,
                            height: 45,
                            width: 45,
                          ),
                        ));
                        await sendMoneyController.cancelTransaction(transaction!);
                        //back for the tx-dialog
                        Get.back();
                        //back for the loading dialog
                        Get.offNamed(HomeView.id);
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
                      height: 58.h,
                      width: 287.w,
                      margin: const EdgeInsets.only(top: 8.0),
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: kLightDisplayTxStatusSent),
                      child: Center(
                        child: Text(
                          'transaction.cancel.transfer'.tr.toUpperCase(),
                          style: XemoTypography.buttonAllCapsWhite(context),
                        ),
                      ),
                    ),
                  ),
          ],
        );
      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        return SizedBox(
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  if (sendMoneyController.availableCountries!
                      .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                      .isNotEmpty) {
                    if (sendMoneyController.availableCountries!
                        .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                        .isNotEmpty) {
                      try {
                        Get.back();

                        Get.dialog(Center(
                          child: RotatedSpinner(
                            spinnerColor: SpinnerColor.GREEN,
                            height: 45,
                            width: 45,
                          ),
                        ));
                        await sendMoneyController.sendMoneyAgain(transaction!);

                        sendMoneyController.checkoutState.enter();
                        sendMoneyController.nextStep();
                        if (Get.isOverlaysOpen) {
                          Get.back();
                        }
                      } catch (e) {
                        if (Get.isOverlaysOpen) {
                          Get.back();
                        }
                      }
                    }
                  }
                },
                child: Container(
                  height: 58.h,
                  width: 287.w,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: sendMoneyController.availableCountries!
                              .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                              .isNotEmpty
                          ? kLightDisplayPrimaryAction
                          : Get.theme.primaryColorLight),
                  child: Center(
                    child: Text(
                      'transaction.send.again'.tr.toUpperCase(),
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  ),
                ),
              ),
              Container(
                height: 6.h,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    Get.dialog(Center(
                      child: RotatedSpinner(
                        spinnerColor: SpinnerColor.GREEN,
                        height: 45,
                        width: 45,
                      ),
                    ));
                    await sendMoneyController.cancelTransaction(transaction!);
                    if (Get.isOverlaysOpen) {
                      Get.back();
                    }
                    //back for the tx-dialog
                    Get.back();
                    //back for the loading dialog
                    Get.offNamed(HomeView.id);
                  } catch (e) {
                    if (Get.isOverlaysOpen) {
                      Get.back();
                    }
                  }
                },
                child: Container(
                  height: 58.h,
                  width: 287.w,
                  margin: const EdgeInsets.only(top: 8.0),
                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: kLightDisplayTxStatusSent),
                  child: Center(
                    child: Text(
                      'transaction.cancel.transfer'.tr.toUpperCase(),
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return Column(
          children: [
            GestureDetector(
              onTap: () async {
                if (sendMoneyController.availableCountries!
                    .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                    .isNotEmpty) {
                  try {
                    Get.back();
                    Get.dialog(Center(
                      child: RotatedSpinner(
                        spinnerColor: SpinnerColor.GREEN,
                        height: 45,
                        width: 45,
                      ),
                    ));
                    await sendMoneyController.sendMoneyAgain(transaction!);

                    sendMoneyController.checkoutState.enter();
                    sendMoneyController.nextStep();
                    if (Get.isOverlaysOpen) {
                      Get.back();
                    }
                  } catch (e) {
                    if (Get.isOverlaysOpen) {
                      Get.back();
                    }
                  }
                }
              },
              child: Container(
                height: 58.h,
                width: 287.w,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: sendMoneyController.availableCountries!
                            .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                            .isNotEmpty
                        ? kLightDisplayPrimaryAction
                        : Get.theme.primaryColorLight),
                child: Center(
                  child: Text(
                    'transaction.send.again'.tr.toUpperCase(),
                    style: XemoTypography.buttonAllCapsWhite(context),
                  ),
                ),
              ),
            ),
            Container(
              height: 6.h,
            ),
            (transaction!.parameters!.collect_method!.replaceAll('-', '').replaceAll(' ', '_').toLowerCase().contains('bank') ||
                    transaction!.parameters!.collect_method!.replaceAll('-', '').replaceAll(' ', '_').toLowerCase().contains('mobile'))
                ? Container()
                : GestureDetector(
                    onTap: () async {
                      try {
                        Get.dialog(Center(
                          child: RotatedSpinner(
                            spinnerColor: SpinnerColor.GREEN,
                            height: 45,
                            width: 45,
                          ),
                        ));

                        await sendMoneyController.cancelTransaction(transaction!);
                        if (Get.isOverlaysOpen) {
                          Get.back();
                        }
                        //back for the tx-dialog
                        Get.back();
                        //back for the loading dialog
                        Get.offNamed(HomeView.id);
                      } catch (e) {
                        if (Get.isOverlaysOpen) {
                          Get.back();
                        }
                      }
                    },
                    child: Container(
                      height: 58.h,
                      width: 287.w,
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: kLightDisplayTxStatusSent),
                      child: Center(
                        child: Text(
                          'transaction.cancel.transfer'.tr.toUpperCase(),
                          style: XemoTypography.buttonAllCapsWhite(context),
                        ),
                      ),
                    ),
                  ),
          ],
        );
      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
        return SizedBox(
          height: 80.h,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  /*
                  if (sendMoneyController.availableCountries!
                      .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                      .isNotEmpty) {
                    //do smt
                    if (sendMoneyController.availableCountries!
                        .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                        .isNotEmpty) {
                      try {
                        await sendMoneyController.sendMoneyAgain(transaction!);
                        Get.dialog(Center(
                          child: CircularProgressIndicator(
                            color: Get.theme.primaryColorLight,
                          ),
                        ));

                        sendMoneyController.checkoutState.enter();
                        sendMoneyController.nextStep();
                      } catch (e) {
                        if (Get.isOverlaysOpen) {
                          Get.back();
                        }
                      }
                    }
                  }*/
                },
                child: Container(
                  height: 58.h,
                  width: 287.w,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: Get.theme.primaryColorLight),
                  child: Center(
                    child: Text(
                      'transaction.send.again'.tr.toUpperCase(),
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case GlobalTransactionStatus.SUCCESS:
        return SizedBox(
          height: 58.h + 15.h,
          child: Column(
            children: [
              Opacity(
                opacity: sendMoneyController.availableCountries!
                        .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                        .isNotEmpty
                    ? 1
                    : 0.7,
                child: GestureDetector(
                  onTap: () async {
                    if (sendMoneyController.availableCountries!
                        .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                        .isNotEmpty) {
                      //do smt
                      if (sendMoneyController.availableCountries!
                          .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                          .isNotEmpty) {
                        try {
                          Get.back();
                          Get.dialog(Center(
                            child: RotatedSpinner(
                              spinnerColor: SpinnerColor.GREEN,
                              height: 45,
                              width: 45,
                            ),
                          ));

                          await sendMoneyController.sendMoneyAgain(transaction!);

                          sendMoneyController.checkoutState.enter();
                          sendMoneyController.nextStep();
                          if (Get.isOverlaysOpen) {
                            Get.back();
                          }
                        } catch (e) {
                          if (Get.isOverlaysOpen) {
                            Get.back();
                          }
                        }
                      }
                    }
                  },
                  child: Container(
                    height: 58.h,
                    width: 287.w,
                    decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)), color: kLightDisplayPrimaryAction),
                    child: Center(
                      child: Text(
                        'transaction.send.again'.tr.toUpperCase(),
                        style: XemoTypography.buttonAllCapsWhite(context),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      case GlobalTransactionStatus.CANCELLED:
        return Container();
      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        return Container();
      case GlobalTransactionStatus.REFUNDED:
        return SizedBox(
          height: 78.h + 15.h,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  if (sendMoneyController.availableCountries!
                      .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                      .isNotEmpty) {
                    //do smt
                    if (sendMoneyController.availableCountries!
                        .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                        .isNotEmpty) {
                      try {
                        Get.back();
                        Get.dialog(Center(
                          child: RotatedSpinner(
                            spinnerColor: SpinnerColor.GREEN,
                            height: 45,
                            width: 45,
                          ),
                        ));
                        await sendMoneyController.sendMoneyAgain(transaction!);

                        sendMoneyController.checkoutState.enter();
                        sendMoneyController.nextStep();
                        if (Get.isOverlaysOpen) {
                          Get.back();
                        }
                      } catch (e) {
                        if (Get.isOverlaysOpen) {
                          Get.back();
                        }
                      }
                    }
                  }
                },
                child: Container(
                  height: 58.h,
                  width: 287.w,
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: sendMoneyController.availableCountries!
                              .where((e) => e.iso_code.toLowerCase().contains(transaction!.parameters!.destination_country!.iso_code.toLowerCase()))
                              .isNotEmpty
                          ? kLightDisplayPrimaryAction
                          : Get.theme.primaryColorLight),
                  child: Center(
                    child: Text(
                      'transaction.send.again'.tr.toUpperCase(),
                      style: XemoTypography.buttonAllCapsWhite(context),
                    ),
                  ),
                ),
              ),
              Container(
                height: 15.h,
              ),
            ],
          ),
        );
      case GlobalTransactionStatus.BLOCKED:
        return Container();
      case GlobalTransactionStatus.COLLECT_ERROR:
        return Container();
      case GlobalTransactionStatus.COLLECT_ON_HOLD:
        return Container();
      case GlobalTransactionStatus.FUNDING_ERROR:
        return Container();
      case GlobalTransactionStatus.NOT_FOUND:
        return Container();
      case GlobalTransactionStatus.REFUNDED_ERROR:
        return Container();
    }
  }
}
