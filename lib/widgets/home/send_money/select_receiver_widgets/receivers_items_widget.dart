import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/models/AddressBook.dart';
import 'package:mobileapp/views/home/contacts_views/edit_contact_view.dart';
import 'package:mobileapp/widgets/common/lazy_loading_widget.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import 'receiver_item_widget.dart';

class ContactItemsWidget extends StatelessWidget {
  bool fromSendMoney = false;
  ContactItemsWidget({Key? key, this.fromSendMoney = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    ProfileController profileController = Get.find<ProfileController>();
    ContactsController contactsController = Get.find<ContactsController>();

    sendMoneyController.initFilteredAddressBooks();

    return Obx(() {
      return Expanded(
          child: !profileController.enableSearch.value
              ? sendMoneyController.filtredAddressBooks!.isNotEmpty
                  ? Stack(
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: LazyLoadScrollView(
                                onEndOfPage: () => sendMoneyController.loadMoreAddressBooks(),
                                isLoading: sendMoneyController.isLoadingMoreFiltredAddressBooks.value,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount: sendMoneyController.filtredAddressBooks != null
                                              ? (sendMoneyController.loadedAddressFiltredBooksItems.value + 1)
                                              : 0,
                                          itemBuilder: (context, index) {
                                            if (index <= (sendMoneyController.filtredAddressBooks!.length - 1)) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  if (fromSendMoney) {
                                                    //  sendMoneyController.selectedReceiver.value = sendMoneyController.filtredAddressBooks![index];
                                                    // sendMoneyController.selectedReceiver.refresh();

                                                    sendMoneyController.selectedReceiver.value = sendMoneyController.filtredAddressBooks![index];
                                                    sendMoneyController.selectedReceiver.refresh();

                                                    bool result = await missingInformationChecker(
                                                        contactsController: contactsController,
                                                        fromSendMoney: fromSendMoney,
                                                        deliveryMethod: sendMoneyController.selectedCollectMethod.value.code!,
                                                        addressBook: sendMoneyController.filtredAddressBooks![index],
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
                                                    contactsController.selectedAddressBook.value = sendMoneyController.filtredAddressBooks![index];
                                                    contactsController.selectedAddressBook.refresh();
                                                  }
                                                  //this function check if the delivery method is bak-transfer then it check
                                                  //if the contact information are all filled if not it'll navigate the user
                                                  //to the edit-contact to fill the remaining data
                                                },
                                                child: ReceiverItemWidget(
                                                  addressBook: sendMoneyController.filtredAddressBooks![index],
                                                  fromSendMoney: fromSendMoney,
                                                  isEditable: true,
                                                ),
                                              );
                                            } else if (index == sendMoneyController.filtredAddressBooks!.length) {
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
                        (sendMoneyController.isLoadingMoreFiltredAddressBooks.value &&
                                !(sendMoneyController.loadedAddressFiltredBooksItems.value == sendMoneyController.filtredAddressBooks!.length))
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
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 200.h),
                      child: Text(
                        'contacts.label.noContacts'.tr,
                        style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
                      ),
                    )
              : Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: LazyLoadScrollView(
                            onEndOfPage: () => profileController.loadMoreSearchResultAddressBooks(),
                            isLoading: profileController.isLoadingMoreAddressBooksSearchResult.value,
                            child: Column(
                              children: [
                                profileController.searchResult!.isNotEmpty
                                    ? Expanded(
                                        child: ListView.builder(
                                            itemCount: profileController.searchResult!.isEmpty
                                                ? 1
                                                : (profileController.loadedAddressBooksSearchResults.value + 1),
                                            itemBuilder: (context, index) {
                                              if (index <= (profileController.searchResult!.length - 1)) {
                                                return GestureDetector(
                                                  onTap: () async {
                                                    sendMoneyController.selectedReceiver.value = profileController.searchResult![index];
                                                    sendMoneyController.selectedReceiver.refresh();
                                                    bool result = await missingInformationChecker(
                                                        contactsController: contactsController,
                                                        fromSendMoney: fromSendMoney,
                                                        deliveryMethod: sendMoneyController.selectedCollectMethod.value.code!,
                                                        addressBook: profileController.searchResult![index],
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
                                                    'common.label.endOfList'.tr,
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
                                          'contact.noResultFound'.tr,
                                          style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
                                        )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    (profileController.isLoadingMoreAddressBooksSearchResult.value &&
                            !(profileController.loadedAddressBooksSearchResults.value == profileController.searchResult!.length))
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
                ));
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
    //
    //
    try {
      //
      //
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
                  sendMoneyController.selectedReceiver.value = profileController.addressBooks![index];
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
                  addressBook: profileController.addressBooks![index],
                  //address: profileController.addresses![index],
                ),
              );
              */
