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
import 'package:mobileapp/widgets/home/contacts_widgets/contacts_all_widget.dart';
import 'package:mobileapp/widgets/home/contacts_widgets/contacts_recent_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../widgets/common/rotated_spinner.dart';
import 'add_contact_view.dart';

class ContactsView extends StatelessWidget {
  static const String id = '/contacts-view';

  const ContactsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    ProfileController profileController = Get.find<ProfileController>();
    ContactsController contactsController = Get.find<ContactsController>();

    sendMoneyController.clearDestinationContact();
    //profileController.loadCompleteAddressBooks();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);
    sendMoneyController.selectedReceiver.value = null;
    return Obx(() {
      return Scaffold(
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(AddContactView.id);
                  // contactsController.goToAddReceiver();
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 23.0),
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.35), blurRadius: 5, offset: const Offset(0, 3))],
                      color: kLightDisplayPrimaryAction,
                      borderRadius: const BorderRadius.all(Radius.circular(40))),
                  padding: EdgeInsets.only(left: 8.w, right: 18.w, top: 8.0, bottom: 8.0),
                  height: 50.h,
                  constraints: BoxConstraints(minWidth: 80.w, maxWidth: 260.w),
                  child: SizedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
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
                          height: 55.h,
                          width: 55.h,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: kLightDisplayPrimaryAction),
                          padding: const EdgeInsets.all(5.0),
                          child: const Center(
                            child: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 35,
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
            return Container(
              padding: const EdgeInsets.only(top: 18.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
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
                                Text('contacts.recent'.tr.toUpperCase(),
                                    style: sendMoneyController.selectedTab.value == 0
                                        ? XemoTypography.bodyBoldSelected(context)
                                        : XemoTypography.bodyBold(context)),
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
                          height: 40.h,
                          // padding: EdgeInsets.only(bottom: 4.0),
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 0.05.sw, left: 0.04.sw, top: 8.h, bottom: 25.h),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 1))]),
                          child: Center(
                            child: TextField(
                              controller: profileController.searchController.value,
                              cursorColor: kLightDisplayPrimaryAction,
                              style: XemoTypography.bodyBold(context)!
                                  .copyWith(decoration: TextDecoration.none, decorationThickness: 0, color: kLightDisplayPrimaryAction),
                              onChanged: (val) {
                                profileController.searchForAddressBooksByValue(val);
                                if (val.isEmpty) {
                                  profileController.searchResult!.value = [];
                                }
                                profileController.searchController.refresh();
                                profileController.searchController.update((val) {});
                              },
                              decoration: InputDecoration(
                                //instead of icon country for which the app is targeting

                                suffixIcon: GestureDetector(
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
                                errorBorder:
                                    const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                                enabledBorder:
                                    const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                                border: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                                disabledBorder:
                                    const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                                focusedBorder:
                                    const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5)), borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(
                          height: 25.0,
                        ),
                  sendMoneyController.selectedTab.value == 0
                      ? profileController.recentAddressBooksIsLoading.value
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 237.h),
                                child: RotatedSpinner(
                                  spinnerColor: SpinnerColor.GREEN,
                                  width: 45,
                                  height: 45,
                                ),
                              ),
                            )
                          : const ContactsRecentItemsWidget()
                      : profileController.addressBooksIsLoading.value
                          ? Center(
                              child: Container(
                                margin: EdgeInsets.only(top: 237.h),
                                child: RotatedSpinner(
                                  spinnerColor: SpinnerColor.GREEN,
                                  width: 45,
                                  height: 45,
                                ),
                              ),
                            )
                          : const ContactAllWidget()
                ],
              ),
            );
          }));
    });
  }
}
