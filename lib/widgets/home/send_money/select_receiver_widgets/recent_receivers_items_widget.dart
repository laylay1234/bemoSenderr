import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/views/home/contacts_views/edit_contact_view.dart';
import 'package:mobileapp/widgets/common/lazy_loading_widget.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import 'receiver_item_widget.dart';

// ignore: must_be_immutable
class RecentReceiverItemsWidget extends StatelessWidget {
  bool fromSendMoney = false;
  RecentReceiverItemsWidget({Key? key, this.fromSendMoney = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    ProfileController profileController = Get.find<ProfileController>();
    ContactsController contactsController = Get.find<ContactsController>();

    sendMoneyController.initFilteredRecentAddressBooks();

    return Obx(() {
      return sendMoneyController.filtredRecentAddressBooks!.isNotEmpty
          ? Expanded(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: LazyLoadScrollView(
                          onEndOfPage: () => sendMoneyController.loadMoreRecentAddressBooks(),
                          isLoading: sendMoneyController.isLoadingMoreFiltredRecentAddressBooks.value,
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    itemCount: sendMoneyController.filtredRecentAddressBooks != null
                                        ? sendMoneyController.loadedAddressFiltredRecentBooksItems.value + 1
                                        : 0,
                                    itemBuilder: (context, index) {
                                      if (index <= (sendMoneyController.filtredRecentAddressBooks!.length - 1)) {
                                        return GestureDetector(
                                          onTap: () async {
                                            if (fromSendMoney) {
                                              sendMoneyController.selectedReceiver.value = sendMoneyController.filtredRecentAddressBooks![index];
                                              sendMoneyController.selectedReceiver.refresh();

                                              bool result = await missingInformationChecker(
                                                  contactsController: contactsController,
                                                  fromSendMoney: fromSendMoney,
                                                  deliveryMethod: sendMoneyController.selectedCollectMethod.value.code!,
                                                  addressBook: sendMoneyController.filtredRecentAddressBooks![index],
                                                  sendMoneyController: sendMoneyController);
                                              if (!result) {
                                                if (sendMoneyController.stack.length > 2) {
                                                  if (sendMoneyController.stack[sendMoneyController.stack.length - 2].name ==
                                                      sendMoneyController.checkoutState.name) {
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
                                              }
                                            } else {
                                              contactsController.selectedAddressBook.value = sendMoneyController.filtredRecentAddressBooks![index];
                                              contactsController.selectedAddressBook.refresh();
                                            }

                                            //
                                          },
                                          child: ReceiverItemWidget(
                                            addressBook: sendMoneyController.filtredRecentAddressBooks![index],
                                            fromSendMoney: fromSendMoney,
                                            isEditable: true,
                                          ),
                                        );
                                      } else if (index == sendMoneyController.filtredRecentAddressBooks!.length) {
                                        return Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(top: 28.h, bottom: 90.h),
                                          child: Text(
                                            'common.label.endOfList'.tr,
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
                  (sendMoneyController.isLoadingMoreFiltredRecentAddressBooks.value &&
                          !(sendMoneyController.loadedAddressFiltredRecentBooksItems.value == sendMoneyController.filtredRecentAddressBooks!.length))
                      ? Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(top: 0.h, bottom: 12.h),
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
                'contacts.label.noRecentContacts'.tr,
                style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
              ),
            );
    });
  }

  Future<bool> missingInformationChecker(
      {required bool? fromSendMoney,
      required String? deliveryMethod,
      required AddressBook? addressBook,
      required ContactsController contactsController,
      required SendMoneyController sendMoneyController}) async {
    try {
      Get.dialog(Center(
        child: RotatedSpinner(
          spinnerColor: SpinnerColor.GREEN,
          height: 45,
          width: 45,
        ),
      ));
      contactsController.setInitialValuesForUpdate(sendMoneyController.selectedReceiver.value!);
      await contactsController.setInitialMobileNetwork(sendMoneyController.selectedReceiver.value!);
      InternationlPhoneValidator().update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
      InternationlZipCodesValidator().update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
      //log('hello');
      Get.back();
    } catch (e) {
      //dbg(e.toString(), isError: true);
      Get.back();
    }
    //
    try {
      if (fromSendMoney! && deliveryMethod!.toLowerCase().contains('bank')) {
        //parameters: {'is_swift_account_required': 'true'} ,

        if (addressBook!.account_number == null) {
          Get.toNamed(EditContactView.id, parameters: {"is_swift_account_required": "true", 'is_from_send_money': 'true'});
          return true;
        } else if (addressBook.account_number!.isEmpty) {
          Get.toNamed(EditContactView.id, parameters: {"is_swift_account_required": "true", 'is_from_send_money': 'true'});
          return true;
        } else if (addressBook.bank_swift_code == null) {
          Get.toNamed(EditContactView.id, parameters: {"is_swift_account_required": "true", 'is_from_send_money': 'true'});
          return true;
        } else if (addressBook.bank_swift_code!.isEmpty) {
          Get.toNamed(EditContactView.id, parameters: {"is_swift_account_required": "true", 'is_from_send_money': 'true'});
          return true;
        } else {
          return false;
        }
      } else if (fromSendMoney && deliveryMethod!.toLowerCase().contains('mobile')) {
        //parameters: {'is_swift_account_required': 'true'} ,

        if (addressBook!.mobile_network == null) {
          Get.toNamed(EditContactView.id, parameters: {"is_mobile_network_required": "true", 'is_from_send_money': 'true'});
          return true;
        } else if (addressBook.mobile_network!.isEmpty) {
          Get.toNamed(EditContactView.id, parameters: {"is_mobile_network_required": "true", 'is_from_send_money': 'true'});
          return true;
        } else if (addressBook.mobile_network == null) {
          Get.toNamed(EditContactView.id, parameters: {"is_mobile_network_required": "true", 'is_from_send_money': 'true'});
          return true;
        } else if (addressBook.mobile_network!.isEmpty) {
          Get.toNamed(EditContactView.id, parameters: {"is_mobile_network_required": "true", 'is_from_send_money': 'true'});
          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}

/*
GestureDetector(
                onTap: () {
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
                },
                child: ReceiverItemWidget(
                  addressBook: profileController.recentAddressBooks![index],
                  //address: profileController.addresses![index],
                ),
              )
              */
