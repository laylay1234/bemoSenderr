import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/common/lazy_loading_widget.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/home/transaction_history_card_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class HistoryView extends StatelessWidget {
  static const String id = '/history-view';

  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();
    //List<DateTime> dates = profileController.getUniqueDatesFromGlobalTransactions();
    // DateTime a = DateTime.now();
    // a.compareTo(other)
    // DD(Get.deviceLocale!);
    profileController.initLoadedGlobalTransaction();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Obx(() {
      return profileController.globalTransactions!.isNotEmpty
          ? Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(),
                    profileController.globalTransactionsIsLoading.value
                        ? Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 300.h),
                              child: RotatedSpinner(
                                spinnerColor: SpinnerColor.GREEN,
                                height: 35,
                                width: 35,
                              ),
                            ),
                          )
                        : Expanded(
                            child: LazyLoadScrollView(
                              onEndOfPage: () => profileController.loadMoreGlobalTransaction(),
                              isLoading: profileController.isLoadingMoreGlabalTransaction.value,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: GroupedListView<dynamic, String>(
                                      padding: EdgeInsets.only(left: 1.w, top: 10.0, right: 1.w),

                                      elements: (profileController.globalTransactions!
                                          .take(profileController.loadedGlobalTransactionsItems.value)
                                          .toList(growable: false)),
                                      groupBy: (e) => DateTime(
                                        e.created_at.getDateTimeInUtc().year,
                                        e.created_at.getDateTimeInUtc().month,
                                      ).toString(),
                                      groupSeparatorBuilder: (String groupByValue) => Padding(
                                        padding: EdgeInsets.only(left: 12.w, top: 12.h),
                                        child: Text(
                                          Jiffy(DateTime.parse(groupByValue)).yMMMM.capitalize!,
                                          style: XemoTypography.captionSemiBoldSecondary(context),
                                        ),
                                      ),
                                      itemComparator: (a, b) => b.created_at.compareTo(a.created_at),
                                      groupComparator: (a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)),
                                      indexedItemBuilder: (context, dynamic element, int index) {
                                        if (index < (profileController.globalTransactions!.length - 1)) {
                                          return TransactionHistoryCardWidget(
                                            globalTransaction: element,
                                          );
                                        } else {
                                          return Column(
                                            children: [
                                              //last element with the end of list
                                              TransactionHistoryCardWidget(
                                                globalTransaction: element,
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                margin: EdgeInsets.only(bottom: 8.h, top: 18.h),
                                                child: Text(
                                                  'common.label.endOfList'.tr.capitalizeFirst!,
                                                  style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                      useStickyGroupSeparators: false, // optional
                                      floatingHeader: true, // optional
                                      order: GroupedListOrder.ASC, // optional
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
                (profileController.isLoadingMoreGlabalTransaction.value &&
                        !(profileController.loadedGlobalTransactionsItems.value == profileController.globalTransactions!.length))
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(top: 15.h, bottom: 12.h),
                          color: Colors.transparent,
                          child: RotatedSpinner(
                            spinnerColor: SpinnerColor.GREEN,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      )
                    : Container(),
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: Text(
                'history.label.noTransactionsHistory'.tr.capitalizeFirst!,
                style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
              ),
            );
    });
  }
}
