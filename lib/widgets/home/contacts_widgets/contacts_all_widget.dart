import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/views/home/contacts_views/send_to_contact_view.dart';
import 'package:mobileapp/widgets/common/lazy_loading_widget.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/home/send_money/select_receiver_widgets/receiver_item_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class ContactAllWidget extends StatelessWidget {
  const ContactAllWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    ProfileController profileController = Get.find<ProfileController>();
    ContactsController contactsController = Get.find<ContactsController>();

    if (!profileController.enableSearch.value) {
      profileController.initLoadedAddressBooks();
    }

    return Obx(() {
      return Expanded(
        child: !profileController.enableSearch.value
            ? profileController.addressBooks!.isNotEmpty
                ? Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: LazyLoadScrollView(
                              onEndOfPage: () => profileController.loadMoreAddressBooks(),
                              isLoading: profileController.isLoadingMoreAddressBooks.value,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: profileController.addressBooks != null ? profileController.loadedAddressBooksItems.value + 1 : 0,
                                        itemBuilder: (context, index) {
                                          if (index <= (profileController.addressBooks!.length - 1)) {
                                            return GestureDetector(
                                              onTap: () {
                                                if (profileController.enableSearch.value) {
                                                  contactsController.selectedAddressBook.value = profileController.searchResult![index];
                                                  contactsController.selectedAddressBook.refresh();

                                                  Get.toNamed(SendToContactView.id);
                                                } else {
                                                  contactsController.selectedAddressBook.value = profileController.addressBooks![index];
                                                  contactsController.selectedAddressBook.refresh();

                                                  Get.toNamed(SendToContactView.id);
                                                }
                                              },
                                              child: ReceiverItemWidget(
                                                addressBook: profileController.enableSearch.value
                                                    ? profileController.searchResult![index]
                                                    : profileController.addressBooks![index],
                                                //address: profileController.addresses![index],
                                              ),
                                            );
                                          } else if (index == profileController.addressBooks!.length) {
                                            return Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(top: 28.h, bottom: 90.h),
                                              child: Text(
                                                'common.label.endOfList'.tr.capitalizeFirst!,
                                                style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      (profileController.isLoadingMoreAddressBooks.value &&
                              !(profileController.loadedAddressBooksItems.value == profileController.addressBooks!.length))
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
                    margin: EdgeInsets.only(top: 200.h),
                    child: Text(
                      'contacts.label.noContacts'.tr.capitalizeFirst!,
                      style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
                    ),
                  )
            : LazyLoadScrollView(
                onEndOfPage: () => profileController.loadMoreSearchResultAddressBooks(),
                isLoading: profileController.isLoadingMoreAddressBooksSearchResult.value,
                child: Column(
                  children: [
                    profileController.searchResult!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                itemCount:
                                    profileController.searchResult!.isEmpty ? 1 : (profileController.loadedAddressBooksSearchResults.value + 1),
                                itemBuilder: (context, index) {
                                  if (index <= (profileController.searchResult!.length - 1)) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(SendToContactView.id, arguments: profileController.searchResult![index]);
                                      },
                                      child: ReceiverItemWidget(addressBook: profileController.searchResult![index]
                                          //address: profileController.addresses![index],
                                          ),
                                    );
                                  } else if (index == profileController.searchResult!.length) {
                                    return Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(top: 28.h, bottom: 90.h),
                                      child: Text(
                                        'contact.noResultFound'.tr.capitalizeFirst!,
                                        style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                          )
                        : Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(top: 200.h),
                            child: Text(
                              'contact.noResultFound'.tr.capitalizeFirst!,
                              style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
                            )),
                    (profileController.isLoadingMoreAddressBooksSearchResult.value &&
                            !(profileController.loadedAddressBooksSearchResults.value == profileController.searchResult!.length))
                        ? Container(
                            margin: EdgeInsets.only(top: 15.h, bottom: 12.h),
                            alignment: Alignment.bottomCenter,
                            color: Colors.transparent,
                            child: CircularProgressIndicator(
                              color: Get.theme.primaryColorLight,
                              backgroundColor: Colors.transparent,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
      );
    });
  }
}
