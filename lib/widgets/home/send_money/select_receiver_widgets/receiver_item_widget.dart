import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/utils/countries_tr_helper.dart';
import 'package:mobileapp/utils/error_alerts_utils.dart';
import 'package:mobileapp/views/home/contacts_views/edit_contact_view.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_model.dart' as cm;

// ignore: must_be_immutable
class ReceiverItemWidget extends StatelessWidget {
  final AddressBook? addressBook;
  bool isEditable = false;
  bool fromSendMoney = false;
  ReceiverItemWidget({Key? key, this.addressBook, this.isEditable = false, this.fromSendMoney = false}) : super(key: key);
  bool active = true;
  @override
  Widget build(BuildContext context) {
    final SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    final ContactsController contactsController = Get.find<ContactsController>();

    //ProfileController profileController = Get.find<ProfileController>();
    if (fromSendMoney && sendMoneyController.selectedCollectMethod.value.code!.toLowerCase().contains('bank')) {
      //
      if (addressBook!.account_number == null) {
        active = false;
      } else if (addressBook!.account_number!.isEmpty) {
        active = false;
      } else if (addressBook!.bank_swift_code == null) {
        active = false;
      } else if (addressBook!.bank_swift_code!.isEmpty) {
        active = false;
      }
    } else if (fromSendMoney && sendMoneyController.selectedCollectMethod.value.code!.toLowerCase().contains('mobile')) {
      if (addressBook!.mobile_network == null) {
        active = false;
      } else if (addressBook!.mobile_network!.isEmpty) {
        active = false;
      }
    }
    cm.Country? tmp = CountriesTrHelper().getCountryTrDataByIsoCode(addressBook!.address!.country!.iso_code);

    return Obx(() {
      return Container(
        width: 1.sw,
        height: 85.h,
        margin: EdgeInsets.only(top: 9.h, left: 0.02.sw, right: 0.02.sw, bottom: 14.h),
        padding: EdgeInsets.only(left: 12.w, top: 5.h, bottom: 5.h),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: sendMoneyController.selectedReceiver.value != null
                ? sendMoneyController.selectedReceiver.value!.equals(addressBook!)
                    ? Get.theme.primaryColorLight
                    : Colors.white
                : Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 2))]),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15),
              child: Opacity(
                opacity: active ? 1 : 0.5,
                child: ClipOval(
                  child: SvgPicture.asset(
                    'assets/xemo/avatar-generic_big_3x.svg',
                    height: 50.h,
                    width: 50.w,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0.03.sw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Opacity(
                    opacity: active ? 1 : 0.5,
                    child: Text(
                      addressBook!.first_name + " " + addressBook!.last_name,
                      textAlign: TextAlign.center, //XemoTypography.bodySemiBoldSelected(context)
                      style: sendMoneyController.selectedReceiver.value != null
                          ? sendMoneyController.selectedReceiver.value!.equals(addressBook!)
                              ? XemoTypography.bodySemiBoldSelected(context)
                              : XemoTypography.bodySemiBold(context)
                          : XemoTypography.bodySemiBold(context),
                    ),
                  ),
                  active
                      ? Text(
                          FormatPlainTextPhoneNumberByNumber()
                              .format(addressBook!.phone_number.startsWith('+') ? addressBook!.phone_number : ('+' + addressBook!.phone_number)),
                          textAlign: TextAlign.center,
                          style: sendMoneyController.selectedReceiver.value != null
                              ? sendMoneyController.selectedReceiver.value!.equals(addressBook!)
                                  ? XemoTypography.captionLightSelected(context)
                                  : XemoTypography.captionLight(context)
                              : XemoTypography.captionLight(context),
                        )
                      : Text('send.money.select.receiver.missing.information'.tr,
                          style: XemoTypography.captionDefault(context)!.copyWith(color: kLightDisplayErrorText)),
                  Opacity(
                    opacity: active ? 1 : 0.5,
                    child: Row(
                      children: [
                        ClipOval(
                          child: SvgPicture.asset(
                            "assets/flags/${addressBook!.address!.country!.iso_code.toLowerCase()}.svg",
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            CountriesTrHelper().getCountryName(tmp!)!,
                            textAlign: TextAlign.center,
                            style: sendMoneyController.selectedReceiver.value != null
                                ? sendMoneyController.selectedReceiver.value!.equals(addressBook!)
                                    ? XemoTypography.bodySemiBoldSelected(context)
                                    : XemoTypography.bodySemiBold(context)
                                : XemoTypography.bodySemiBold(context),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            isEditable
                ? GestureDetector(
                    onTap: () async {
                      Get.dialog(Center(
                        child: RotatedSpinner(
                          spinnerColor: SpinnerColor.GREEN,
                          height: 45,
                          width: 45,
                        ),
                      ));
                      try {
                        contactsController.selectedAddressBook.value = addressBook!;
                        contactsController.setInitialValuesForUpdate(contactsController.selectedAddressBook.value!);
                        await contactsController.setInitialMobileNetwork(contactsController.selectedAddressBook.value!);
                        InternationlPhoneValidator().update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                        InternationlZipCodesValidator().update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                        PhoneNumberInputFormatter(countryIso: contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                        Get.back();
                      } catch (error, stackTrace) {
                        Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
                        //dbg(error.toString(), isError: true);
                        log(error.toString());
                        Get.back();
                      }
                      if (sendMoneyController.selectedCollectMethod.value.code!.toLowerCase().contains('bank')) {
                        Get.toNamed(EditContactView.id,
                                parameters: {"is_swift_account_required": "true", "is_mobile_network_required": "false", "fromSendMoney": "true"})!
                            .then((value) {
                          if (value != null) {
                            //log('updated ! now its back');
                            AddressBook updatedAddressBook = value as AddressBook;
                            contactsController.selectedAddressBook.value = updatedAddressBook;
                          }
                        });
                      } else if (sendMoneyController.selectedCollectMethod.value.code!.toLowerCase().contains('mobile')) {
                        Get.toNamed(EditContactView.id,
                                parameters: {"is_swift_account_required": "false", "is_mobile_network_required": "true", "fromSendMoney": "true"})!
                            .then((value) {
                          if (value != null) {
                            //log('updated ! now its back');
                            AddressBook updatedAddressBook = value as AddressBook;
                            contactsController.selectedAddressBook.value = updatedAddressBook;
                          }
                        });
                      } else {
                        Get.toNamed(EditContactView.id,
                                parameters: {"is_swift_account_required": "false", "is_mobile_network_required": "false", "fromSendMoney": "true"})!
                            .then((value) {
                          if (value != null) {
                            //log('updated ! now its back');
                            AddressBook updatedAddressBook = value as AddressBook;
                            contactsController.selectedAddressBook.value = updatedAddressBook;
                          }
                        });
                      }

                      /*
                      Get.dialog(Center(
                        child: RotatedSpinner(
                          spinnerColor: SpinnerColor.GREEN,
                          height: 45,
                          width: 45,
                        ),
                      ));
                      try {
                        contactsController.setInitialValuesForUpdate(contactsController.selectedAddressBook.value!);
                        await contactsController.setInitialMobileNetwork(contactsController.selectedAddressBook.value!);
                        InternationlPhoneValidator().update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                        InternationlZipCodesValidator().update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());

                        Get.back();
                      } catch (e) {
                        // dbg(e.toString(), isError: true);
                        Get.back();
                      }
                      sendMoneyController.selectedReceiver.value = addressBook;

                      Get.toNamed(EditContactView.id, parameters: {"is_swift_account_required": "true"})!.then((value) {
                        if (value != null) {
                          //log('updated ! now its back');
                          AddressBook updatedAddressBook = value as AddressBook;
                          contactsController.selectedAddressBook.value = updatedAddressBook;
                        }
                      });
                      */
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 0.03.sw),
                      width: 45.w,
                      height: 45.h,
                      decoration: const BoxDecoration(color: Color(0xFFF05137), borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: const Center(
                        child: Icon(
                          FontAwesomeIcons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      );
    });
  }
}
