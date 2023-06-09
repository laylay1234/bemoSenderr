import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_contacts/properties/address.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/models/Country.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../controllers/contacts_controller.dart';
import '../../../utilities/text_phone_number_formatter.dart';
import '../../common/xemo_form_validator.dart';

Future<void> openSelectPhoneFromList(List<Phone> phones, String fullName, {bool fromContact = false}) async {
  await Get.dialog(
      SelectPhoneFromContact(
        fullName: fullName,
        phones: phones,
        fromContact: fromContact,
      ),
      barrierDismissible: true,
      useSafeArea: true);
}

// ignore: must_be_immutable
class SelectPhoneFromContact extends StatelessWidget {
  String fullName;
  List<Phone> phones;
  bool fromContact = false;
  SelectPhoneFromContact({Key? key, required this.phones, required this.fullName, required this.fromContact}) : super(key: key);
  Rx<String> selectedPhone = ''.obs;
  Rx<int> selectedIndex = (-1).obs;
  Rx<String> selectedPhoneWithCallingCode = ''.obs;
  @override
  Widget build(BuildContext context) {
    //
    ContactsController contactsController = Get.find<ContactsController>();
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();

    return Obx(() {
      return Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          width: 345.w,
          height: (100 + (phones.length * 100)),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 21.0, bottom: 8.0),
                  child: Text(
                    fullName,
                    style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w700, fontSize: 18.sp),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Text(
                    "contact.select.phone.number".tr,
                    style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Colors.grey.withOpacity(0.5),
                ),
                Container(
                  height: 15,
                ),
                Column(
                  children: List.generate(phones.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        selectedIndex.value = index;
                        selectedPhone.value = phones[index].number;
                        selectedPhoneWithCallingCode.value =
                            (phones[index].normalizedNumber.isEmpty ? phones[index].number : phones[index].normalizedNumber);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 32.0, left: 18.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  (phones[index].label.name.capitalizeFirst ?? '') + ' : ',
                                  style: selectedIndex.value == index
                                      ? XemoTypography.bodyDefault(context)!.copyWith(color: Get.theme.primaryColorLight)
                                      : XemoTypography.bodyDefault(context)!,
                                ),
                                Text(
                                  (FormatPlainTextPhoneNumberByNumber()
                                      .format(phones[index].normalizedNumber.isEmpty ? phones[index].number : phones[index].normalizedNumber)),
                                  style: selectedIndex.value == index
                                      ? XemoTypography.bodyDefault(context)!.copyWith(color: Get.theme.primaryColorLight)
                                      : XemoTypography.bodyDefault(context)!,
                                )
                              ],
                            ),
                            selectedIndex.value == index
                                ? Container(
                                    margin: const EdgeInsets.only(right: 12.0),
                                    child: Icon(
                                      Icons.done,
                                      color: Get.theme.primaryColorLight,
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(right: 12.0),
                                  ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey.withOpacity(0.5),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      selectedPhone.value = '';
                      Get.back();
                    },
                    child: Container(
                        padding: const EdgeInsets.only(left: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          'common.cancel'.tr,
                          style: XemoTypography.bodyDefault(context)!.copyWith(fontWeight: FontWeight.w500, color: Get.theme.primaryColorLight),
                        )),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.5),
                    height: 70,
                    width: 0.5,
                  ),
                  GestureDetector(
                    onTap: () async {
                      Get.dialog(Center(
                        child: RotatedSpinner(
                          spinnerColor: SpinnerColor.GREEN,
                          height: 45,
                          width: 45,
                        ),
                      ));
                      contactsController.selectedMobileNetwork.value = '';
                      contactsController.mobileNetwors.value = [];
                      //
                      log(selectedPhoneWithCallingCode.toString());
                      log(selectedPhone.toString());

                      Country? result = await contactsController.setDestinationCountryByCallingCode(
                          selectedPhoneWithCallingCode.replaceAll(' ', '').replaceAll('-', ''),
                          fromContact: fromContact);

                      if (result != null) {
                        contactsController.phoneNumberController.value.text = selectedPhone.replaceAll(' ', '').replaceAll('-', '');
                        InternationlPhoneValidator().update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                        InternationlZipCodesValidator().update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                        PhoneNumberInputFormatter(countryIso: contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                        log(contactsController.selectedDestinationCountry!.value!.iso_code);

                        contactsController.phoneNumberController.value.text = FormatPlainTextPhoneNumberByNumber()
                            .format(selectedPhoneWithCallingCode.startsWith("+")
                                ? selectedPhoneWithCallingCode.replaceAll(' ', '').replaceAll('-', '')
                                : ("+" + selectedPhoneWithCallingCode.replaceAll(' ', '').replaceAll('-', '')))
                            .substring(contactsController.selectedDestinationCountry!.value!.calling_code!.length)
                            .replaceFirst(' ', '');

                        //display loading
                        contactsController.phoneNumberKey.update((val) {});
                        contactsController.phoneNumberKey.value.currentState!.validate(); //
                        await contactsController.getMobileNetworks(); //cloase loading

                      }
                      if (Get.isOverlaysOpen) {
                        Get.back();
                      }
                      Get.back();
                    },
                    child: Container(
                        padding: const EdgeInsets.only(right: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          'contact.selectCountry'.tr.toLowerCase().split(' ').first.capitalizeFirst!,
                          style: XemoTypography.bodyDefault(context)!.copyWith(fontWeight: FontWeight.w500, color: Get.theme.primaryColorLight),
                        )),
                  ),
                ],
              ),
            )
          ]),
        ),
      );
    });
  }
}
