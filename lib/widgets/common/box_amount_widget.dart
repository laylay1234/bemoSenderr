import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class BoxAmountWidget extends StatelessWidget {
  final GlobalTransaction? globalTransaction;
  const BoxAmountWidget({Key? key, @required this.globalTransaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (globalTransaction!.status) {
      case GlobalTransactionStatus.NEW:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.black),
          child: Center(
            child: Text(
              "+${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.black),
          child: Center(
            child: Text(
              "+${formatByCurrency(globalTransaction!.parameters!.total, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFF20C9A7)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
      case GlobalTransactionStatus.REFUNDED:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.total, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.SUCCESS:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFF20C9A7)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.CANCELLED:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.REFUNDED:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.BLOCKED:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.COLLECT_ERROR:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.COLLECT_ON_HOLD:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.FUNDING_ERROR:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.NOT_FOUND:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
            ),
          ),
        );
      case GlobalTransactionStatus.REFUNDED_ERROR:
        return Container(
          padding: const EdgeInsets.only(top: 3.0, bottom: 3.0),
          height: 37.h,
          //width: 0.23.sw,
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Color(0xFFF05137)),
          child: Center(
            child: Text(
              "-${formatByCurrency(globalTransaction!.parameters!.amount_origin, '')} \$",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: XemoTypography.buttonWhiteDefault(context),
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
