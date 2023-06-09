import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_contacts/properties/address.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../controllers/contacts_controller.dart';
import '../../../utilities/text_phone_number_formatter.dart';

Future<void> openSelectAddressFromList(List<Address> addresses, String fullName) async {
  Get.dialog(SelectAddressFromContact(fullName: fullName, addresses: addresses), barrierDismissible: true, useSafeArea: true);
}

// ignore: must_be_immutable
class SelectAddressFromContact extends StatelessWidget {
  String fullName;
  List<Address> addresses;
  SelectAddressFromContact({Key? key, required this.addresses, required this.fullName}) : super(key: key);
  Rx<String> selectedAddress = ''.obs;
  Rx<String> selectedCity = ''.obs;
  Rx<String> selectedPostal = ''.obs;
  Rx<int> selectedIndex = (-1).obs;
  @override
  Widget build(BuildContext context) {
    //
    ContactsController contactsController = Get.find<ContactsController>();

    return Obx(() {
      return Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          width: 345.w,
          height: (99 + (addresses.length * 100)),
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
                    "contact.select.address".tr,
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
                  children: List.generate(addresses.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        selectedIndex.value = index;
                        selectedAddress.value = addresses[index].street.replaceAll('\n', ' ');
                        selectedPostal.value = addresses[index].postalCode;
                        selectedCity.value = addresses[index].city;
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 32.0, left: 18.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    (addresses[index].label.name.capitalizeFirst ?? '') + ' : ',
                                    style: selectedIndex.value == index
                                        ? XemoTypography.bodyDefault(context)!.copyWith(color: Get.theme.primaryColorLight)
                                        : XemoTypography.bodyDefault(context)!,
                                  ),
                                  Expanded(
                                    child: Text(
                                      addresses[index].address,
                                      style: selectedIndex.value == index
                                          ? XemoTypography.bodyDefault(context)!.copyWith(color: Get.theme.primaryColorLight)
                                          : XemoTypography.bodyDefault(context)!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  )
                                ],
                              ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    selectedAddress.value = '';

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
                    contactsController.addressController.value.text = selectedAddress.value;
                    contactsController.cityController.value.text = selectedCity.value;
                    contactsController.zipCodeController.value.text = selectedPostal.value;
                    //cloase loading
                    if (Get.isOverlaysOpen) {
                      Get.back();
                    }
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
            )
          ]),
        ),
      );
    });
  }
}
