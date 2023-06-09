import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_amplifysdk/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/utils/countries_tr_helper.dart';
import 'package:mobileapp/widgets/buttons/cancel_button_widget.dart';
import 'package:mobileapp/widgets/buttons/ok_button_widget.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/common/xemo_logo_circule_with_background.dart';
import 'package:mobileapp/widgets/home/county_reception_widget.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_model.dart' as cm;
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/providers/country_provider.dart' as cp;

Future<void> selectCountryDialog({bool fromContact = false}) async {
  await Get.dialog(
      SelectCountryDialogWidget(
        fromContact: fromContact,
      ),
      barrierDismissible: false,
      useSafeArea: false);
}

// ignore: must_be_immutable
class SelectCountryDialogWidget extends StatelessWidget {
  bool? fromContact = false;
  SelectCountryDialogWidget({Key? key, this.fromContact = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final AuthController authController = Get.find<AuthController>();
    final SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    final ContactsController contactsController = Get.find<ContactsController>();
    // sendMoneyController.sortAvailableCountriesByAvailability();
    if (fromContact ?? false) {
      // sendMoneyController.getDestinationCountriesByOriginCountry();
    }

    // NOTE: clone the selected country object
    var _selectedCountry = sendMoneyController.selectedDestinationCountry!.value.copyWith();

    if (fromContact == true && contactsController.selectedDestinationCountry!.value != null) {
      _selectedCountry = contactsController.selectedDestinationCountry!.value!.copyWith();
    }
    contactsController.selectedTempoCountry = _selectedCountry.obs;
    sendMoneyController.selectedTempoCountry = _selectedCountry.obs;
    return WillPopScope(
      onWillPop: () async {
        // sendMoneyController.getDestinationCountriesByOriginCountry();
        //sendMoneyController.selectedDestinationCountry = sendMoneyController.selectedDestinationCountry;
        return Future.value(false);
      },
      child: Obx(() {
        return IntrinsicWidth(
          child: Dialog(
            insetPadding: const EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            backgroundColor: Colors.transparent,
            child: Container(
              height: 0.65.sh,
              width: 900,
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    child: Positioned(top: -60, left: 115.w, child: const XemoLogoCirculeWhiteBackground()),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 68.0, bottom: 38.0),
                          child: Text(
                            fromContact == false ? "send.money.dialog.chooseWhereToSendTo".tr : "send.money.dialog.selectRecipientCountry".tr,
                            textAlign: TextAlign.center,
                            style: Get.textTheme.headline1!.copyWith(color: Get.theme.primaryColorLight, fontSize: 22.sp),
                          ),
                        ),
                        sendMoneyController.availableCountries!.isEmpty
                            ? RotatedSpinner(
                                spinnerColor: SpinnerColor.GREEN,
                                height: 45,
                                width: 45,
                              )
                            : Expanded(
                                child: GridView.builder(
                                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 0.7, crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12),
                                    itemCount: sendMoneyController.availableCountries!.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          if (fromContact ?? false) {
                                            var _selected = sendMoneyController.availableCountries![index];
                                            contactsController.selectedTempoCountry!.value = _selected;
                                            InternationlPhoneValidator()
                                                .update(contactsController.selectedTempoCountry!.value!.iso_code.toUpperCase());
                                            InternationlZipCodesValidator()
                                                .update(contactsController.selectedTempoCountry!.value!.iso_code.toUpperCase());
                                            // NOTE: this to refresh the Edit Contact page without Flutter Red error page
                                            contactsController.selectedDestinationCountry!.value = _selected;

                                            //await contactsController.getMobileNetworks();
                                          } else {
                                            if (sendMoneyController.availableCountries![index].active) {
                                              sendMoneyController.selectedTempoCountry!.value = sendMoneyController.availableCountries![index];
                                            }
                                          }

                                          //log(sendMoneyController.selectedTempoCountry!.toJson());
                                        },
                                        child: CountryReceptionWidget(
                                          availableCountry: sendMoneyController.availableCountries![index],
                                          fromContact: fromContact,
                                        ),
                                      );
                                    }),
                              ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    Get.back();
                                    if (fromContact ?? false) {
                                      contactsController.selectedDestinationCountry!.value = _selectedCountry;
                                      InternationlPhoneValidator()
                                          .update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                                      InternationlZipCodesValidator()
                                          .update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                                      contactsController.selectedMobileNetwork.value = '';
                                      contactsController.mobileNetwors.value = [];
                                      await contactsController.getMobileNetworks();
                                    } else {
                                      sendMoneyController.selectedDestinationCountry!.value = _selectedCountry;
                                    }
                                    if (sendMoneyController.sendEditingController.value.text == '25') {
                                      await sendMoneyController.getExchangeRate('1');
                                      sendMoneyController.calculateTotal();
                                    } else {
                                      await sendMoneyController.getExchangeRate(sendMoneyController.sendEditingController.value.text);
                                      sendMoneyController.calculateTotal();
                                    }
                                  },
                                  child: const CancelButtonWidget()),
                              GestureDetector(
                                  onTap: () async {
                                    Get.back();

                                    Get.dialog(Center(
                                      child: RotatedSpinner(
                                        spinnerColor: SpinnerColor.GREEN,
                                        height: 45,
                                        width: 45,
                                      ),
                                    ));
                                    if (fromContact ?? false) {
                                      contactsController.selectedDestinationCountry!.value = contactsController.selectedTempoCountry!.value;
                                      InternationlPhoneValidator()
                                          .update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                                      InternationlZipCodesValidator()
                                          .update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                                      contactsController.selectedMobileNetwork.value = '';
                                      contactsController.mobileNetwors.value = [];
                                      await contactsController.getMobileNetworks();
                                    } else {
                                      sendMoneyController.selectedDestinationCountry!.value = sendMoneyController.selectedTempoCountry!.value;
                                    }
                                    if (sendMoneyController.sendEditingController.value.text == '25') {
                                      await sendMoneyController.getExchangeRate('1');
                                      sendMoneyController.calculateTotal();
                                    } else {
                                      await sendMoneyController.getExchangeRate(sendMoneyController.sendEditingController.value.text);
                                      sendMoneyController.calculateTotal();
                                    }
                                    if (Get.isOverlaysOpen) {
                                      Get.back();
                                    }
                                  },
                                  child: const OkButtonWidget())
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
