import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/common/search_suffix_widget.dart';
import 'package:mobileapp/widgets/common/xemo_clear_textFormField_widget.dart';
import 'package:mobileapp/widgets/home/contacts_widgets/contacts_recent_widget.dart';
import 'package:mobileapp/widgets/home/send_money/select_receiver_widgets/receivers_items_widget.dart';
import 'package:mobileapp/widgets/home/send_money/select_receiver_widgets/recent_receivers_items_widget.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class SelectReceiverView extends StatelessWidget {
  static const String id = '/select-receiver-view';

  const SelectReceiverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    ContactsController contactsController = Get.find<ContactsController>();
    ProfileController profileController = Get.find<ProfileController>();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Obx(() {
      return Scaffold(
          appBar: XemoAppBar(leading: true, function: sendMoneyController.prevStep),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (sendMoneyController.selectedCollectMethod.value.code!.toLowerCase().contains('bank')) {
                    contactsController.goToAddReceiver(is_swift_bank_required: true, is_mobile_network_required: false, fromSendMoney: true);
                  } else if (sendMoneyController.selectedCollectMethod.value.code!.toLowerCase().contains('mobile')) {
                    contactsController.goToAddReceiver(is_swift_bank_required: false, is_mobile_network_required: true, fromSendMoney: true);
                  } else {
                    contactsController.goToAddReceiver(is_swift_bank_required: false, is_mobile_network_required: false, fromSendMoney: true);
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 23.0),
                  decoration: BoxDecoration(color: kLightDisplayPrimaryAction, borderRadius: const BorderRadius.all(Radius.circular(40))),
                  padding: EdgeInsets.only(left: 8.w, right: 18.w, top: 8.0, bottom: 8.0),
                  height: 50.h,
                  constraints: BoxConstraints(minWidth: 80.w, maxWidth: 260.w),
                  child: SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 4,
                        ),
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 27,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            'contact.newContact'.tr.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: XemoTypography.buttonAllCapsWhite(context),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              sendMoneyController.selectedTab.value == 1
                  ? GestureDetector(
                      onTap: () {
                        profileController.enableSearch.value = true;
                      },
                      child: Container(
                          height: 50.h,
                          width: 50.h,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: kLightDisplayPrimaryAction),
                          padding: const EdgeInsets.all(5.0),
                          child: const Center(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 32,
                            ),
                          )),
                    )
                  : const SizedBox(
                      height: 0,
                      width: 0,
                    ),
            ],
          ),
          body: Obx(() {
            return Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'send.money.select.receiver.title'.tr,
                      style: Get.textTheme.headline2,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 28.0),
                    margin: const EdgeInsets.only(bottom: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            sendMoneyController.selectedTab.value = 0;
                          },
                          child: SizedBox(
                            height: 30.h,
                            width: 150.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'contacts.recent'.tr.toUpperCase(),
                                  style: Get.textTheme.headline4!.copyWith(
                                    fontSize: 15.sp,
                                    color: sendMoneyController.selectedTab.value == 0 ? Get.theme.primaryColorLight : const Color(0xFF9B9B9B),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  width: 150.w,
                                  color: sendMoneyController.selectedTab.value == 0 ? Get.theme.primaryColorLight : Colors.transparent,
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            sendMoneyController.selectedTab.value = 1;
                          },
                          child: SizedBox(
                            height: 30.h,
                            width: 150.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'contacts.all'.tr.toUpperCase(),
                                  style: Get.textTheme.headline4!.copyWith(
                                    fontSize: 15.sp,
                                    color: sendMoneyController.selectedTab.value == 1 ? Get.theme.primaryColorLight : const Color(0xFF9B9B9B),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Container(
                                  height: 2,
                                  width: 150.w,
                                  color: sendMoneyController.selectedTab.value == 1 ? Get.theme.primaryColorLight : Colors.transparent,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ((sendMoneyController.selectedTab.value == 1) && (profileController.enableSearch.value == true))
                      ? Container(
                          width: 350.w,
                          height: 46,
                          // padding: EdgeInsets.only(bottom: 4.0),
                          margin: EdgeInsets.only(right: 0.05.sw, left: 0.04.sw, top: 8.h, bottom: 25.0),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 1))]),
                          child: TextFormField(
                            controller: profileController.searchController.value,
                            cursorColor: Get.theme.primaryColorLight,
                            style: XemoTypography.bodyBold(context)!
                                .copyWith(decoration: TextDecoration.none, decorationThickness: 0, color: kLightDisplayPrimaryAction),
                            onChanged: (val) {
                              profileController.searchForAddressBooksByValueInSendMoney(val);
                              if (val.isEmpty) {
                                profileController.searchResult!.value = [];
                              }
                              profileController.searchController.refresh();
                              profileController.searchController.update((val) {});
                              profileController.initLoadedSearchResultAddressBooks();
                            },
                            decoration: InputDecoration(
                              //instead of icon country for which the app is targeting

                              suffix: GestureDetector(
                                onTap: () {
                                  profileController.searchController.value.text = '';
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                ),
                              ),
                              hintText: 'contact.search.hint.title'.tr,
                              hintStyle: XemoTypography.titleH6BoldBlack(context)!.copyWith(
                                  color: const Color(0xFFA5A5A5), fontSize: 20.sp, fontWeight: FontWeight.w400, decoration: TextDecoration.none),
                              prefixIcon: SearchContactSuffixWidget(controller: profileController.searchController),
                              prefixStyle: Get.textTheme.headline2!.copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
                              contentPadding: const EdgeInsets.only(left: 8.0, bottom: 0.0),
                              fillColor: const Color(0xFFF4F4F4),
                              filled: true,
                              focusedErrorBorder:
                                  const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                              errorBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                              enabledBorder:
                                  const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                              border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                              disabledBorder:
                                  const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                              focusedBorder:
                                  const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 5.0,
                        ),
                  profileController.addressBooksIsLoading.value
                      ? Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 237.h),
                            child: CircularProgressIndicator(
                              color: Get.theme.primaryColorLight,
                            ),
                          ),
                        )
                      : sendMoneyController.selectedTab.value == 0
                          ? RecentReceiverItemsWidget(
                              fromSendMoney: true,
                            )
                          : ContactItemsWidget(
                              fromSendMoney: true,
                            )
                ],
              ),
            );
          }));
    });
  }
}
/*
 sendMoneyController.selectedReceiver.value = profileController.recentAddressBooks![index];
                  sendMoneyController.selectedReceiver.refresh();

                  if (sendMoneyController.stack.length > 2) {
                    if (sendMoneyController.stack[sendMoneyController.stack.length - 2].name == sendMoneyController.checkoutState.name) {
                      sendMoneyController.checkoutState.enter();
                      sendMoneyController.nextStep();
                    } else {
                      sendMoneyController.selectTransferReasonState.enter();
                      sendMoneyController.nextStep();
                    }
                  } else {
                    sendMoneyController.selectTransferReasonState.enter();
                    sendMoneyController.nextStep();
                  }
                  */