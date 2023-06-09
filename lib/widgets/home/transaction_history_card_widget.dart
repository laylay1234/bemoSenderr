import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/models/GlobalTransaction.dart';
import 'package:mobileapp/models/GlobalTransactionStatus.dart';
import 'package:mobileapp/utils/countries_tr_helper.dart';
import 'package:mobileapp/widgets/common/box_amount_widget.dart';
import 'package:mobileapp/widgets/dialogs/transaction_details_dialog_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_model.dart' as cm;
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/providers/country_provider.dart' as cp;

// ignore: must_be_immutable
class TransactionHistoryCardWidget extends StatelessWidget {
  GlobalTransaction? globalTransaction;
  TransactionHistoryCardWidget({Key? key, this.globalTransaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cm.Country? tmp = CountriesTrHelper().getCountryTrDataByIsoCode(globalTransaction!.parameters!.destination_country!.iso_code.toLowerCase());

    return GestureDetector(
      onTap: () {
        openTransactionDetailsDialog(transaction: globalTransaction);
      },
      child: Container(
          width: 0.98.sw,
          height: 130.h,
          margin: const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 2))]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: Container(
                  height: 58.h,
                  width: 58.w,
                  margin: EdgeInsets.only(left: 0.015.sw),
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    globalTransactionStateToPath(globalTransaction!.status),
                    height: 58.h,
                    width: 58.w,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 0.015.sw),
                height: 92.h,
                width: 0.45.sw,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 24.h,
                      width: 0.45.sw,
                      constraints: BoxConstraints(maxWidth: 0.45.sw),
                      child: Text(
                        (globalTransaction!.receiver?.first_name ?? '') + ' ' + (globalTransaction!.receiver?.last_name ?? ''),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: XemoTypography.bodySemiBold(context),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.5.h),
                      child: Text(
                        FormatPlainTextPhoneNumberByNumber().format(globalTransaction!.receiver!.phone_number.startsWith('+')
                            ? globalTransaction!.receiver!.phone_number.replaceAll(' ', '')
                            : ('+' + globalTransaction!.receiver!.phone_number.replaceAll(' ', ''))),
                        // textAlign: TextAlign.center,
                        style: XemoTypography.captionLight(context),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Row(
                        children: [
                          ClipOval(
                            child: SvgPicture.asset(
                              "assets/flags/${globalTransaction!.parameters!.destination_country!.iso_code.toLowerCase()}.svg",
                              height: 30.h,
                              width: 30.w,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              tmp == null
                                  ? globalTransaction!.parameters!.destination_country!.name.tr.capitalizeFirst!
                                  : CountriesTrHelper().getCountryName(tmp)!.capitalizeFirst!,
                              textAlign: TextAlign.center,
                              style: XemoTypography.bodySemiBold(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 0.02.sw),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BoxAmountWidget(globalTransaction: globalTransaction!),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          globalTransaction!.createdAt != null
                              ? globalTransaction!.createdAt!
                                  .getDateTimeInUtc()
                                  .toString()
                                  .substring(0, 10)
                                  .replaceAll('-', '/')
                                  .split('/')
                                  .reversed
                                  .join('/')
                              : globalTransaction!.created_at
                                  .getDateTimeInUtc()
                                  .toString()
                                  .substring(0, 10)
                                  .replaceAll('-', '/')
                                  .split('/')
                                  .reversed
                                  .join('/'),
                          style: XemoTypography.captionLight(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  String formatByCurrency(String number, String currency_iso) {
    double amount = double.parse(number);
    String formated = NumberFormat.simpleCurrency(
      name: currency_iso.toUpperCase(),
    ).format(amount);
    return formated;
  }

  String globalTransactionStateToPath(GlobalTransactionStatus state) {
    switch (state) {
      case GlobalTransactionStatus.NEW:
        //TODO confirm this
        return 'assets/xemo/status-deposited_big_3x.svg';
      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        //TODO confirm this
        return 'assets/xemo/status-deposited_big_3x.svg';

      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return 'assets/xemo/status-sent_big_3x.svg';

      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
        return 'assets/xemo/status-refunded_big_3x.svg';

      case GlobalTransactionStatus.SUCCESS:
        return 'assets/xemo/status-received_big_3x.svg';

      case GlobalTransactionStatus.CANCELLED:
        return 'assets/xemo/status-canceled_big_3x.svg';

      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        //confirm this
        return 'assets/xemo/status-canceled_big_3x.svg';

      case GlobalTransactionStatus.REFUNDED:
        // confirm this.
        return 'assets/xemo/status-refunded_big_3x.svg';

      case GlobalTransactionStatus.BLOCKED:
        return 'assets/xemo/status-canceled_big_3x.svg';

      case GlobalTransactionStatus.COLLECT_ERROR:
        // TODO: confirm this
        return 'assets/xemo/status-canceled_big_3x.svg';

      case GlobalTransactionStatus.COLLECT_ON_HOLD:
        // TODO: confirm this
        return 'assets/xemo/status-canceled_big_3x.svg';

      case GlobalTransactionStatus.FUNDING_ERROR:
        return 'assets/xemo/status-canceled_big_3x.svg';

      case GlobalTransactionStatus.NOT_FOUND:
        return 'assets/xemo/status-canceled_big_3x.svg';

      case GlobalTransactionStatus.REFUNDED_ERROR:
        return 'assets/xemo/status-canceled_big_3x.svg';
    }
  }
}

/*
case GlobalTransactionStatus.CANCELLED:
        return 'assets/xemo/status-canceled_big_3x.svg';
      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return 'assets/xemo/status-sent_big_3x.svg';
      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        return 'assets/xemo/status-deposited_big_3x.svg';
      case GlobalTransactionStatus.SUCCESS:
        return 'assets/xemo/status-received_big_3x.svg';
      case GlobalTransactionStatus.NEW:
        return 'assets/xemo/status-sent_big_3x.svg';
      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        return 'assets/xemo/status-canceled_big_3x.svg';
      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
        return 'assets/xemo/status-refunded_big_3x.svg';
      default: //TODO missing default image
        return 'assets/xemo/status-sent_big_3x.svg';
        */