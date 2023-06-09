import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../constants/format.dart';

// ignore: must_be_immutable
class ExchangeRateAndTimeWidget extends StatelessWidget {
  GlobalTransaction? transaction;
  ExchangeRateAndTimeWidget({Key? key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatTime = DateFormat('hh:mm a dd-MM-yyyy');
    switch (transaction!.status) {
      case GlobalTransactionStatus.NEW:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
          ],
        );
      case GlobalTransactionStatus.SUCCESS:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
      case GlobalTransactionStatus.CANCELLED:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
      case GlobalTransactionStatus.REFUNDED:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
            )
          ],
        );
      case GlobalTransactionStatus.BLOCKED:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
      case GlobalTransactionStatus.COLLECT_ERROR:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
      case GlobalTransactionStatus.COLLECT_ON_HOLD:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
      case GlobalTransactionStatus.FUNDING_ERROR:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
      case GlobalTransactionStatus.NOT_FOUND:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
      case GlobalTransactionStatus.REFUNDED_ERROR:
        return Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 8.h),
              child: Text(
                formatTime
                    .format(transaction!.created_at.getDateTimeInUtc().toLocal())
                    .toString()
                    .replaceAll('-', '/')
                    .replaceAll('AM', 'am')
                    .replaceAll('PM', "pm"),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 16.sp, color: kLightDisplaySecondaryTextColor),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.h),
              child: Text(
                "1 ${transaction!.parameters!.currency_origin!.iso_code.toUpperCase()} = " +
                    double.parse(transaction!.parameters!.applicable_rate).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS) +
                    " " +
                    transaction!.parameters!.currency_destination!.iso_code.toUpperCase(),
                style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 12.sp, color: kLightDisplaySecondaryTextColor),
              ),
            )
          ],
        );
    }
  }
}
