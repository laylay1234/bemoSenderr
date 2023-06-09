import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
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

class ContactsRecentItemsWidget extends StatelessWidget {
  const ContactsRecentItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    ProfileController profileController = Get.find<ProfileController>();
    ContactsController contactsController = Get.find<ContactsController>();

    profileController.initLoadedRecentAddressBooks();

    return Obx(() {
      return !profileController.recentAddressBooksIsLoading.value
          ? profileController.recentAddressBooks!.isNotEmpty
              ? Expanded(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: LazyLoadScrollView(
                              onEndOfPage: () => profileController.loadMoreRecentAddressBooks(),
                              isLoading: profileController.isLoadingMoreRecentAddressBooks.value,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        // addAutomaticKeepAlives: false,
                                        itemCount: profileController.recentAddressBooks != null
                                            ? ////////////////////
                                            (profileController.loadedRecentAddressBooksItems.value + 1)
                                            : 0,
                                        itemBuilder: (context, index) {
                                          log(index);
                                          if (index <= (profileController.recentAddressBooks!.length - 1)) {
                                            return GestureDetector(
                                              onTap: () {
                                                contactsController.selectedAddressBook.value = profileController.recentAddressBooks![index];
                                                contactsController.selectedAddressBook.refresh();
                                                Get.toNamed(SendToContactView.id);
                                              },
                                              child: ReceiverItemWidget(
                                                addressBook: profileController.recentAddressBooks![index],
                                                //address: profileController.addresses![index],
                                              ),
                                            );
                                          } else if (index == profileController.recentAddressBooks!.length) {
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
                      (profileController.isLoadingMoreRecentAddressBooks.value &&
                              !(profileController.loadedRecentAddressBooksItems.value == profileController.recentAddressBooks!.length))
                          ? Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(top: 15.h, bottom: 12.h),
                                color: Colors.transparent,
                                child: RotatedSpinner(
                                  spinnerColor: SpinnerColor.GREEN,
                                  width: 45,
                                  height: 45,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: 200.h),
                  child: Text(
                    'contacts.label.noRecentContacts'.tr.capitalizeFirst!,
                    style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
                  ),
                )
          : Align(
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(top: 15.h, bottom: 12.h),
                color: Colors.transparent,
                child: RotatedSpinner(
                  spinnerColor: SpinnerColor.GREEN,
                  width: 45,
                  height: 45,
                ),
              ),
            );
    });
  }
}
