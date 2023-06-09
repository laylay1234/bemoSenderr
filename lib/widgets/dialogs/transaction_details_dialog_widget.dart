import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/widgets/dialogs/transaction_dialog_widgets/reciever_data_widget.dart';
import 'package:mobileapp/widgets/dialogs/transaction_dialog_widgets/total_box_widget.dart';

import '../../models/ModelProvider.dart';
import 'transaction_dialog_widgets/button_options_widget.dart';
import 'transaction_dialog_widgets/collects_or_help_widget.dart';
import 'transaction_dialog_widgets/exchange_rate_and_time_widget.dart';
import 'transaction_dialog_widgets/status_label_widget.dart';

Future<void> openTransactionDetailsDialog({GlobalTransaction? transaction}) async {
  await Get.dialog(
      TransactionDetailsDialog(
        transaction: transaction,
      ),
      barrierDismissible: true,
      useSafeArea: true);
}

// ignore: must_be_immutable
class TransactionDetailsDialog extends StatelessWidget {
  GlobalTransaction? transaction;
  TransactionDetailsDialog({Key? key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //log(transaction!.parameters!.toJson());
    //  transaction = transaction!.copyWith(
    //     status: GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS, parameters: transaction!.parameters!.copyWith(collect_method: 'bank'));
    final ProfileController profileController = Get.find<ProfileController>();
    //log(transaction!.status.name);
    //transaction = transaction!.copyWith(status: GlobalTransactionStatus.REFUNDED);
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: getSpecificEdgeInsetsByStatus(transaction!),
        child: Align(
          alignment: getSpecificAlignmentByStatus(transaction!),
          child: SizedBox(
            width: 900,
            height: getSpecificHeightByStatus(transaction!),
            child: SingleChildScrollView(
              clipBehavior: Clip.none,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: getScrollHeightByStatus(transaction!.status),
                  ),
                  Positioned(
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
                          child: Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.topCenter,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10.w, top: 10.h),
                                    child: const Icon(
                                      Icons.close,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 77.h,
                                    ),
                                    StatusLabelWidget(transaction: transaction, user: profileController.userInstance!.value),
                                    Container(
                                      height: 10.h,
                                    ),
                                    ReceiverDateWidget(
                                      transaction: transaction,
                                    ),
                                    TotalBoxWidget(
                                      transaction: transaction,
                                    ),
                                    ExchangeRateAndTimeWidget(
                                      transaction: transaction,
                                    ),
                                    Container(
                                      height: 18.h,
                                    ),
                                    Container(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    CollectOrHelpWidget(
                                      transaction: transaction,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(margin: EdgeInsets.only(top: 14.h), child: ButtonOptionsWidget(transaction: transaction!)),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -60.h,
                    left: 115.w,
                    right: 115.w,
                    child: ClipOval(
                      child: Container(
                        height: 127.h,
                        width: 127.w,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: SvgPicture.asset(
                          //TODO
                          globalTransactionStateToPath(transaction!.status),
                          height: 127.h,
                          width: 127.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  Alignment getSpecificAlignmentByStatus(GlobalTransaction transaction) {
    switch (transaction.status) {
      case GlobalTransactionStatus.NEW:
        return Alignment.center;
      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        if (transaction.collect_transactions != null) {
          if (transaction.collect_transactions!.isEmpty) {
            return Alignment.center;
          } else if (transaction.collect_transactions!.length == 1) {
            return Alignment.center;
          } else {
            return Alignment.topCenter;
          }
        }
        return Alignment.center;
      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return Alignment.topCenter;
      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
        return Alignment.topCenter;
      case GlobalTransactionStatus.SUCCESS:
        if (transaction.collect_transactions != null) {
          if (transaction.collect_transactions!.isEmpty) {
            return Alignment.center;
          } else if (transaction.collect_transactions!.length == 1) {
            return Alignment.center;
          } else {
            return Alignment.topCenter;
          }
        }
        return Alignment.center;
      case GlobalTransactionStatus.CANCELLED:
        return Alignment.center;
      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        return Alignment.center;
      case GlobalTransactionStatus.REFUNDED:
        return Alignment.topCenter;
      case GlobalTransactionStatus.BLOCKED:
        return Alignment.center;
      case GlobalTransactionStatus.COLLECT_ERROR:
        return Alignment.center;
      case GlobalTransactionStatus.COLLECT_ON_HOLD:
        return Alignment.center;
      case GlobalTransactionStatus.FUNDING_ERROR:
        return Alignment.center;
      case GlobalTransactionStatus.NOT_FOUND:
        return Alignment.center;
      case GlobalTransactionStatus.REFUNDED_ERROR:
        return Alignment.center;
    }
  }

  EdgeInsets getSpecificEdgeInsetsByStatus(GlobalTransaction transaction) {
    switch (transaction.status) {
      case GlobalTransactionStatus.NEW:
        return EdgeInsets.only(top: 58.h);
      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        return EdgeInsets.only(top: 48.h);
      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return EdgeInsets.only(top: 48.h);
      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
        return EdgeInsets.only(top: 48.h);
      case GlobalTransactionStatus.SUCCESS:
        return EdgeInsets.only(top: 48.h);
      case GlobalTransactionStatus.CANCELLED:
        return EdgeInsets.only(top: 100.h);
      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        return EdgeInsets.only(top: 73.h);
      case GlobalTransactionStatus.REFUNDED:
        return EdgeInsets.only(top: 130.h);
      case GlobalTransactionStatus.BLOCKED:
        return EdgeInsets.only(top: 100.h);
      case GlobalTransactionStatus.COLLECT_ERROR:
        return EdgeInsets.only(top: 100.h);
      case GlobalTransactionStatus.COLLECT_ON_HOLD:
        return EdgeInsets.only(top: 73.h);
      case GlobalTransactionStatus.FUNDING_ERROR:
        return EdgeInsets.only(top: 100.h);
      case GlobalTransactionStatus.NOT_FOUND:
        return EdgeInsets.only(top: 100.h);
      case GlobalTransactionStatus.REFUNDED_ERROR:
        return EdgeInsets.only(top: 100.h);
    }
  }

  double getSpecificHeightByStatus(GlobalTransaction transaction) {
    switch (transaction.status) {
      case GlobalTransactionStatus.NEW:
        return 790.h;
      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        return 790.h;
      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return 750.h;

      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
        return 650.h;

      case GlobalTransactionStatus.SUCCESS:
        return 700.h;

      case GlobalTransactionStatus.CANCELLED:
        return 650.h;

      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        return 650.h;

      case GlobalTransactionStatus.REFUNDED:
        return 650.h;

      case GlobalTransactionStatus.BLOCKED:
        return 650.h;

      case GlobalTransactionStatus.COLLECT_ERROR:
        return 650.h;

      case GlobalTransactionStatus.COLLECT_ON_HOLD:
        return 650.h;

      case GlobalTransactionStatus.FUNDING_ERROR:
        return 650.h;

      case GlobalTransactionStatus.NOT_FOUND:
        return 650.h;

      case GlobalTransactionStatus.REFUNDED_ERROR:
        return 650.h;
    }
  }

  double getScrollHeightByStatus(GlobalTransactionStatus status) {
    switch (status) {
      case GlobalTransactionStatus.NEW:
        return 790.h;
      case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
        return 890.h;
      case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
        return 790.h;

      case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
        return 790.h;

      case GlobalTransactionStatus.SUCCESS:
        return 790.h;

      case GlobalTransactionStatus.CANCELLED:
        return 690.h;

      case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
        return 690.h;

      case GlobalTransactionStatus.REFUNDED:
        return 690.h;

      case GlobalTransactionStatus.BLOCKED:
        return 690.h;

      case GlobalTransactionStatus.COLLECT_ERROR:
        return 690.h;

      case GlobalTransactionStatus.COLLECT_ON_HOLD:
        return 690.h;

      case GlobalTransactionStatus.FUNDING_ERROR:
        return 690.h;

      case GlobalTransactionStatus.NOT_FOUND:
        return 690.h;

      case GlobalTransactionStatus.REFUNDED_ERROR:
        return 690.h;
    }
  }
}
