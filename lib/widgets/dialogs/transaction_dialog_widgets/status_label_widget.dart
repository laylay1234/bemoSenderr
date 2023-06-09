import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

// ignore: must_be_immutable
class StatusLabelWidget extends StatelessWidget {
  GlobalTransaction? transaction;
  User? user;
  StatusLabelWidget({Key? key, this.transaction, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatTime = DateFormat('dd-MM-yyyy');

    switch (transaction!.status) {
      case GlobalTransactionStatus.NEW:
        return Container(
            width: 270.w,
            margin: EdgeInsets.only(top: 5.h),
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)), border: Border.all(width: 0.8, color: const Color(0xFFF05137))),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBold(context)!.copyWith(color: const Color(0xFFF05137)),
              ),
            ));

      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        return Container(
            width: 280.w,
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            child: Center(
                //XemoTypography.bodySemiBold(context)!,
                child: Column(
              children: [
                RichText(
                    text: TextSpan(text: 'transaction.at'.tr, style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 20.sp), children: [
                  TextSpan(text: ' Yalla', style: XemoTypography.bodySemiBold(context)!.copyWith(color: const Color(0xFFF05137), fontSize: 20.sp)),
                  TextSpan(text: 'Xash', style: XemoTypography.bodySemiBold(context)!.copyWith(color: Get.theme.primaryColorLight, fontSize: 20.sp)),
                ])),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    'transaction.to.fund.reciever'.tr.replaceFirst('@', transaction!.receiver!.first_name + " " + transaction!.receiver!.last_name),
                    style: XemoTypography.bodySemiBold(context)!
                        .copyWith(color: kLightDisplaySecondaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )));
      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return Container(
            width: 290.w,
            margin: EdgeInsets.only(top: 5.h),
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 8.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)), border: Border.all(width: 0.8, color: const Color(0xFFF05137))),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "transaction.sent".tr +
                    " ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(color: const Color(0xFFF05137)),
              ),
            ));
      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
        return Container(
            width: 290.w,
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)), border: Border.all(width: 0.8, color: Get.theme.primaryColorLight)),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context),
              ),
            ));
      case GlobalTransactionStatus.SUCCESS:
        return Container(
            width: 290.w,
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)), border: Border.all(width: 0.8, color: Get.theme.primaryColorLight)),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context),
              ),
            ));
      case GlobalTransactionStatus.CANCELLED:
        return Container(
            width: 290.w,
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                color: kLightDisplayTxStatusCancContrast,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 0.8, color: kLightDisplayTxStatusCanc)),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(color: kLightDisplayTxStatusCanc),
              ),
            ));
      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        return Container(
            margin: EdgeInsets.only(left: 18.w, right: 18.w),
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                color: kLightDisplayTxStatusCancContrast,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 0.8, color: kLightDisplayTxStatusCanc)),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(color: kLightDisplayTxStatusCanc),
              ),
            ));
      case GlobalTransactionStatus.REFUNDED:
        return Container(
            width: 290.w,
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)), border: Border.all(width: 0.8, color: Get.theme.primaryColorLight)),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context),
              ),
            ));
      case GlobalTransactionStatus.BLOCKED:
        return Container(
            width: 290.w,
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                color: kLightDisplayTxStatusCancContrast,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 0.8, color: kLightDisplayTxStatusCanc)),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(color: kLightDisplayTxStatusCanc),
              ),
            ));
      case GlobalTransactionStatus.COLLECT_ERROR:
        return Container(
            width: 290.w,
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                color: kLightDisplayTxStatusCancContrast,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 0.8, color: kLightDisplayTxStatusCanc)),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(color: kLightDisplayTxStatusCanc),
              ),
            ));
      case GlobalTransactionStatus.COLLECT_ON_HOLD:
        return Container(
            width: 290.w,
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                color: kLightDisplayTxStatusCancContrast,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 0.8, color: kLightDisplayTxStatusCanc)),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(color: kLightDisplayTxStatusCanc),
              ),
            ));
      case GlobalTransactionStatus.FUNDING_ERROR:
        return Container(
            width: 290.w,
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                color: kLightDisplayTxStatusCancContrast,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 0.8, color: kLightDisplayTxStatusCanc)),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(color: kLightDisplayTxStatusCanc),
              ),
            ));
      case GlobalTransactionStatus.NOT_FOUND:
        return Container(
            width: 290.w,
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                color: kLightDisplayTxStatusCancContrast,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 0.8, color: kLightDisplayTxStatusCanc)),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(color: kLightDisplayTxStatusCanc),
              ),
            ));
      case GlobalTransactionStatus.REFUNDED_ERROR:
        return Container(
            width: 290.w,
            padding: const EdgeInsets.only(left: 8.0, bottom: 5.0, top: 5.0),
            decoration: BoxDecoration(
                color: kLightDisplayTxStatusCancContrast,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(width: 0.8, color: kLightDisplayTxStatusCanc)),
            child: Center(
              child: Text(
                "transaction.status".tr.capitalizeFirst! +
                    ": " +
                    "${transaction!.status.name.replaceAll('_', ' ').tr.toLowerCase()} ${formatTime.format(transaction!.createdAt != null ? transaction!.createdAt!.getDateTimeInUtc().toLocal() : transaction!.created_at.getDateTimeInUtc().toLocal()).replaceAll('-', '/')}",
                textAlign: TextAlign.center,
                style: XemoTypography.bodySemiBoldHighlight(context)!.copyWith(color: kLightDisplayTxStatusCanc),
              ),
            ));
    }
  }
}
