import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../constants/format.dart';

// ignore: must_be_immutable
class TotalBoxWidget extends StatelessWidget {
  GlobalTransaction? transaction;
  TotalBoxWidget({Key? key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (transaction!.status) {
      case GlobalTransactionStatus.NEW:
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 65.h,
          width: 215.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.black),
          child: Center(
            child: Column(
              children: [
                Text(
                  "+${formatByCurrency(transaction!.parameters!.amount_origin, '')} \$",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
                Text(
                  double.parse(transaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                      " " +
                      transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 12.h),
          width: 160.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.black),
          child: Center(
            child: Column(
              children: [
                Text(
                  "+${formatByCurrency(transaction!.parameters!.total, '')} \$",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 65.h,
          width: 215.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: kLightDisplayPrimaryAction),
          child: Center(
            child: Column(
              children: [
                Text(
                  "-\$ ${double.parse(transaction!.parameters!.amount_origin).toStringAsFixed(AMOUNT_FORMAT_DECIMALS)}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
                Text(
                  double.parse(transaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                      " " +
                      transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 45.h,
          width: 0.4.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFF393939)),
          child: Center(
            child: Column(
              children: [
                Text(
                  "-${formatByCurrency(transaction!.parameters!.total, '')} \$",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.SUCCESS:
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 65.h,
          width: 215.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFF20C9A7)),
          child: Center(
            child: Column(
              children: [
                Text(
                  "-${formatByCurrency(transaction!.parameters!.amount_origin, '')} \$",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
                Text(
                  double.parse(transaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                      " " +
                      transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.CANCELLED:
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 65.h,
          width: 215.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Column(
              children: [
                Text(
                  "-${formatByCurrency(transaction!.parameters!.amount_origin, '')} \$",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
                Text(
                  double.parse(transaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                      " " +
                      transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 65.h,
          width: 215.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: kLightDisplayPrimaryAction),
          child: Center(
            child: Column(
              children: [
                Text(
                  "\$ ${double.parse(transaction!.parameters!.amount_origin).toStringAsFixed(AMOUNT_FORMAT_DECIMALS)}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
                Text(
                  double.parse(transaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                      " " +
                      transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.REFUNDED:
        return Container(
            margin: EdgeInsets.only(top: 15.h),
            padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
            height: 45.h,
            width: 0.4.sw,
            decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFF393939)),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "-${formatByCurrency(transaction!.parameters!.total, '')} \$",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: XemoTypography.buttonWhiteDefault(context),
                  ),
                ],
              ),
            ));
      case GlobalTransactionStatus.BLOCKED:
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 65.h,
          width: 215.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Column(
              children: [
                Text(
                  "-${formatByCurrency(transaction!.parameters!.amount_origin, '')} \$",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
                Text(
                  double.parse(transaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                      " " +
                      transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.COLLECT_ERROR:
        //TODO confirm this
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 65.h,
          width: 215.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Column(
              children: [
                Text(
                  "-${formatByCurrency(transaction!.parameters!.amount_origin, '')} \$",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
                Text(
                  double.parse(transaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                      " " +
                      transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.COLLECT_ON_HOLD:
        // TODO: confirm this.
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 65.h,
          width: 215.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Column(
              children: [
                Text(
                  "-${formatByCurrency(transaction!.parameters!.amount_origin, '')} \$",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
                Text(
                  double.parse(transaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                      " " +
                      transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.FUNDING_ERROR:
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 65.h,
          width: 215.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Column(
              children: [
                Text(
                  "-${formatByCurrency(transaction!.parameters!.amount_origin, '')} \$",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
                Text(
                  double.parse(transaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                      " " +
                      transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.NOT_FOUND:
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 65.h,
          width: 215.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Column(
              children: [
                Text(
                  "-${formatByCurrency(transaction!.parameters!.amount_origin, '')} \$",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
                Text(
                  double.parse(transaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                      " " +
                      transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
      case GlobalTransactionStatus.REFUNDED_ERROR:
        return Container(
          margin: EdgeInsets.only(top: 15.h),
          padding: EdgeInsets.only(top: 10.h, bottom: 3.h),
          height: 65.h,
          width: 215.w,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Column(
              children: [
                Text(
                  "-${formatByCurrency(transaction!.parameters!.amount_origin, '')} \$",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
                Text(
                  double.parse(transaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS) +
                      " " +
                      transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: XemoTypography.buttonWhiteDefault(context),
                ),
              ],
            ),
          ),
        );
    }
  }

  String formatByCurrency(String number, String currency_iso) {
    double amount = double.parse(number);
    String formated = NumberFormat.simpleCurrency(
      name: currency_iso.toUpperCase(),
    ).format(amount);
    return formated;
  }
}
