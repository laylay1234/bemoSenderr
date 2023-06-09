import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/utilities/zip_code_formatter.dart';
import 'package:mobileapp/views/home_view.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_clear_textFormField_widget.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/common/xemo_text_form_field_widget.dart';
import 'package:mobileapp/widgets/dialogs/select_country_dialog_widget.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/utils/phone_number.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/utils/selector_config.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/widgets/input_widget.dart';
import 'package:mobileapp/widgets/snackbars/successfully_updated_data_snackbar.dart';
import 'package:mobileapp/widgets/snackbars/warning_snackbar.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../utils/error_alerts_utils.dart';
import '../../../widgets/dialogs/contact_dialogs_widgets/select_network_dialog_widget.dart';

class EditContactView extends StatelessWidget {
  static const String id = '/edit-contact-view';

  const EditContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddressBook? addressBook;
    ContactsController contactsController = Get.find<ContactsController>();
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    String is_swift_account_required = Get.parameters["is_swift_account_required"] ?? 'false';
    String is_mobile_network_required = Get.parameters['is_mobile_network_required'] ?? 'false';
    String is_from_send_money = Get.parameters['is_from_send_money'] ?? 'false';

    // log((sendMoneyController.selectedReceiver.value != null).toString());
    // log(Get.parameters.toString());
    if (is_from_send_money == 'true') {
      addressBook = sendMoneyController.selectedReceiver.value!;
    } else {
      addressBook = contactsController.selectedAddressBook.value!;
    }
    //loading dialog

    //close it    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          contactsController.clearValues();
          return Future.value(true);
        },
        child: Scaffold(
            appBar: XemoAppBar(leading: true),
            body: SingleChildScrollView(
                child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: contactsController.formKey.value,
              onChanged: () {
                //   contactsController.firstNameKey.value.currentState!.save();
              },
              child: Container(
                margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw),
                child: Column(
                  children: [
                    Container(margin: EdgeInsets.only(top: 20.h)),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "contact.editContact".tr,
                        textAlign: TextAlign.center,
                        style: Get.textTheme.headline3!.copyWith(color: const Color(0xFFF05137), fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                    //gender selection
                    Container(
                      margin: EdgeInsets.only(top: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            child: Text(
                              "common.gender".tr.toUpperCase(),
                              style: Get.textTheme.headline2!.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 2.h),
                            child: Text("common.note.required".tr,
                                style: (contactsController.selectedGender.value != null)
                                    ? XemoTypography.captionItalic(context)!.copyWith(
                                        fontWeight: FontWeight.w200,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 14,
                                        color: kLightDisplaySecondaryTextColor,
                                      )
                                    : XemoTypography.captionItalic(context)!.copyWith(fontWeight: FontWeight.w200)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8.h, left: 0.01.sw),
                            child: Row(
                              children: [
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      contactsController.selectedGender.value = Gender.Male;
                                      contactsController.selectedGender.refresh();
                                    },
                                    child: Container(
                                      height: 50.h,
                                      decoration: ((contactsController.selectedGender.value != null) &&
                                              contactsController.selectedGender.value!.name == Gender.Male.name)
                                          ? BoxDecoration(
                                              color: kLightDisplayPrimaryAction,
                                              //    boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                                              border: Border.all(color: kLightDisplayPrimaryAction, width: 2))
                                          : BoxDecoration(
                                              color: Colors.white,
                                              //        boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                                              border: Border.all(color: kLightDisplayPrimaryAction, width: 2)),
                                      child: Center(
                                        child: Text(
                                          "common.male".tr.capitalizeFirst!,
                                          style: Get.textTheme.headline4!.copyWith(
                                              color: ((contactsController.selectedGender.value != null) &&
                                                      contactsController.selectedGender.value!.name == Gender.Male.name)
                                                  ? Colors.white
                                                  : kLightDisplayPrimaryAction),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      contactsController.selectedGender.value = Gender.Female;
                                      contactsController.selectedGender.refresh();
                                      log(contactsController.selectedGender.value!.name);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 4.w),
                                      height: 50.h,
                                      decoration: (((contactsController.selectedGender.value != null)) &&
                                              contactsController.selectedGender.value!.name == Gender.Female.name)
                                          ? BoxDecoration(
                                              color: kLightDisplayPrimaryAction,
                                              //         boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                                              border: Border.all(color: kLightDisplayPrimaryAction, width: 2))
                                          : BoxDecoration(
                                              color: Colors.white,
                                              //       boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                                              border: Border.all(color: kLightDisplayPrimaryAction, width: 2)),
                                      child: Center(
                                        child: Text(
                                          "common.female".tr.capitalizeFirst!,
                                          style: Get.textTheme.headline4!.copyWith(
                                              color: (((contactsController.selectedGender.value != null)) &&
                                                      contactsController.selectedGender.value!.name == Gender.Female.name)
                                                  ? Colors.white
                                                  : kLightDisplayPrimaryAction),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      contactsController.selectedGender.value = Gender.Other;
                                      contactsController.selectedGender.refresh();
                                      log(contactsController.selectedGender.value!.name);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 4.w),
                                      padding: const EdgeInsets.all(10.0),
                                      height: 50.h,
                                      decoration: (((contactsController.selectedGender.value != null)) &&
                                              contactsController.selectedGender.value!.name == Gender.Other.name)
                                          ? BoxDecoration(
                                              color: kLightDisplayPrimaryAction,
                                              // boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                                              border: Border.all(color: Get.theme.primaryColorLight, width: 2))
                                          : BoxDecoration(
                                              color: Colors.white,
                                              // boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                                              border: Border.all(color: kLightDisplayPrimaryAction, width: 2)),
                                      child: Center(
                                        child: Text(
                                          "common.Other".tr.capitalizeFirst!,
                                          style: Get.textTheme.headline4!.copyWith(
                                              color: (((contactsController.selectedGender.value != null)) &&
                                                      contactsController.selectedGender.value!.name == Gender.Other.name)
                                                  ? Colors.white
                                                  : kLightDisplayPrimaryAction),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //name selection
                    //name selection
                    //name selection
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        XemoTextFormWithTitleAndNote(
                          width: 1.sw,
                          enableRightMargin: false,
                          controller: contactsController.fnameController,
                          formKey: contactsController.formKey.value,
                          textFieldKey: contactsController.firstNameKey,
                          enableNext: contactsController.enableSave,
                          title: "common.forms.firstName.title".tr,
                          note: "common.note.required".tr,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-ZÀ-ÿZàâäæáãåāèéêëęėēîïīįíìôōøõóòöœùûüūúÿçćčńñÀÂÄÆÁÃÅĀÈÉÊËĘĖĒÎÏĪĮÍÌÔŌØÕÓÒÖŒÙÛÜŪÚŸÇĆČŃÑ ]')),
                          ],
                          validator: XemoFormValidatorWidget().requiredFirstName,
                        ),
                        //lname
                        XemoTextFormWithTitleAndNote(
                          width: 1.sw,
                          enableRightMargin: false,
                          controller: contactsController.lnameController,
                          formKey: contactsController.formKey.value,
                          textFieldKey: contactsController.lastNameKey,
                          enableNext: contactsController.enableSave,
                          title: "common.forms.lastName.title".tr,
                          note: "common.note.required".tr,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-ZÀ-ÿZàâäæáãåāèéêëęėēîïīįíìôōøõóòöœùûüūúÿçćčńñÀÂÄÆÁÃÅĀÈÉÊËĘĖĒÎÏĪĮÍÌÔŌØÕÓÒÖŒÙÛÜŪÚŸÇĆČŃÑ ]')),
                          ],
                          validator: XemoFormValidatorWidget().requiredLastName,
                        ),
                      ],
                    ),
                    //From country
                    Container(
                      margin: EdgeInsets.only(
                        top: 25.h,
                        //left: 0.05.sw,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //    margin: EdgeInsets.only(left: 0.05.w),
                            child: Text(
                              "contact.countryFrom".tr.toUpperCase(),
                              style: Get.textTheme.headline2!.copyWith(fontWeight: FontWeight.w600, fontSize: 16.sp),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (is_from_send_money == "false") {
                                await selectCountryDialog(fromContact: true);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5.0),
                              height: 45.h,
                              width: contactsController.selectedDestinationCountry!.value != null ? 200.w : 230.w,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipOval(
                                    child: contactsController.selectedDestinationCountry?.value != null
                                        ? SvgPicture.asset(
                                            contactsController.selectedDestinationCountry?.value != null
                                                ? "assets/flags/${contactsController.selectedDestinationCountry!.value!.iso_code.toLowerCase()}.svg"
                                                : 'assets/images/placeholder.svg',
                                            height: 30,
                                            width: 30,
                                          )
                                        : Container(),
                                  ),
                                  contactsController.selectedDestinationCountry?.value != null
                                      ? Container(
                                          padding: const EdgeInsets.only(
                                            left: 4.0,
                                            //  top: 5.h,
                                          ),
                                          alignment: Alignment.center,
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  contactsController.selectedDestinationCountry!.value != null
                                                      ? contactsController.selectedDestinationCountry!.value!.name.tr
                                                      : '',
                                                  textAlign: TextAlign.center,
                                                  style: Get.textTheme.subtitle2!.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w700),
                                                )
                                              ]),
                                        )
                                      : Text(
                                          'contact.selectCountry'.tr.toUpperCase(),
                                          textAlign: TextAlign.center,
                                          style: XemoTypography.bodySemiBold(context)!.copyWith(fontSize: 15.sp),
                                        ),
                                  GestureDetector(
                                    onTap: () async {
                                      //showDialog(context: context, builder: (context) => SelectCountryDialogWidget());
                                      if (is_from_send_money == "false") {
                                        await selectCountryDialog(fromContact: true);
                                      }
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1, color: Colors.black)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(1, 2))],
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.black, width: 1)),
                                        child: SvgPicture.asset(
                                          'assets/xemo/icon-dropdown.svg',
                                          height: 30.h,
                                          width: 30.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: !(contactsController.selectedDestinationCountry!.value != null),
                      child: Opacity(
                        opacity: contactsController.selectedDestinationCountry!.value != null ? 1 : 0.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //phone number field
                            Container(
                              margin: EdgeInsets.only(top: 40.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    //          margin: EdgeInsets.only(left: 6.w),
                                    child: Text(
                                      "common.label.phoneNumber".tr.toUpperCase(),
                                      style: Get.textTheme.headline2!.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(
                                        top: 5.h,
                                      ),
                                      child: Text("common.note.required".tr,
                                          style: InternationlPhoneValidator().validator(
                                                    value: contactsController.phoneNumberController.value.text,
                                                  ) !=
                                                  null
                                              ? XemoTypography.captionItalic(context)!.copyWith(
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: 14,
                                                )
                                              : XemoTypography.captionItalic(context)!.copyWith(
                                                  fontWeight: FontWeight.w300,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 14,
                                                  color: kLightDisplaySecondaryTextColor,
                                                ))),
                                  Container(
                                    // margin: EdgeInsets.only(right: 8.w),
                                    height: 75.h,
                                    padding: const EdgeInsets.only(left: 2),
                                    // margin: EdgeInsets.only(left: 1.w),
                                    child: InternationalPhoneNumberInput(
                                      phoneKey: contactsController.phoneNumberKey.value,
                                      width: 1.sw,
                                      autoFocus: false,
                                      initialValue:
                                          PhoneNumber(isoCode: contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase()),
                                      countries: [contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase()],
                                      //  countries: originController.available_origin_countries.value.map((e) => e.iso_code!.toUpperCase()).toList(),
                                      selectorTextStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                                      textFieldController: contactsController.phoneNumberController.value,
                                      selectorConfig:
                                          SelectorConfig(useEmoji: true, leadingPadding: 2.w, selectorType: PhoneInputSelectorType.DIALOG),
                                      onInputChanged: (value) async {
                                        contactsController.phoneNumberController.refresh();
                                        // log(value.dialCode.toString() + '5');
                                        contactsController.calling_code_iso.value = value.dialCode!;
                                        if (contactsController.formKey.value.currentState!.validate()) {
                                          contactsController.enableSave.value = true;
                                        }
                                        contactsController.phoneNumberKey.update((val) {});
                                        contactsController.phoneNumberKey.refresh();
                                        InternationlPhoneValidator()
                                            .update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                                        InternationlZipCodesValidator()
                                            .update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                                      },
                                      textStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                                      keyboardType: TextInputType.phone,
                                      inputFormatters: [
                                        PhoneNumberInputFormatter(
                                            countryIso: contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase()),
                                        //  FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (val) {
                                        InternationlPhoneValidator()
                                            .update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                                        return InternationlPhoneValidator().validator(
                                          value: val,
                                        );
                                      },
                                      spaceBetweenSelectorAndTextField: 0,
                                      selectorButtonOnErrorPadding: 0,
                                      searchBoxDecoration: InputDecoration(
                                        prefix: const Icon(
                                          Icons.search,
                                          color: kDarkDisplayPrimaryAction,
                                        ),
                                        focusedErrorBorder: errorBorderDecoration,
                                        errorBorder: borderDecoration,
                                        enabledBorder: borderDecoration,
                                        border: borderDecoration,
                                        disabledBorder: borderDecoration,
                                        focusedBorder: primayColorborderDecoration,
                                      ),
                                      inputDecoration: InputDecoration(
                                        isDense: true,
                                        suffix: ClearTextFormFieldWidget(
                                          controller: contactsController.phoneNumberController,
                                          enabelNext: contactsController.enableSave,
                                          textFieldKey: contactsController.phoneNumberKey,
                                        ),
                                        prefixStyle: Get.textTheme.headline2!
                                            .copyWith(color: Get.theme.primaryColorLight, fontSize: 16, fontWeight: FontWeight.w500),
                                        contentPadding: const EdgeInsets.only(left: 0),
                                        fillColor: Colors.transparent,
                                        focusedErrorBorder: errorBorderDecoration,
                                        errorBorder: borderDecoration,
                                        enabledBorder: borderDecoration,
                                        border: borderDecoration,
                                        disabledBorder: borderDecoration,
                                        focusedBorder: primayColorborderDecoration,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Opacity(
                              opacity: contactsController.mobileNetwors.isEmpty ? 0.5 : 1,
                              child: Container(
                                // padding: EdgeInsets.only(left: 1.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                top: 10.h,
                                              ),
                                              child: Text(
                                                "contact.note.mobileNetwork".tr.toUpperCase(),
                                                style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                top: 5.h,
                                              ),
                                              child: Text(
                                                  is_mobile_network_required == "true"
                                                      ? "common.note.required".tr
                                                      : "common.form.field.note.optional".tr,
                                                  style: contactsController.selectedMobileNetwork.value.isNotEmpty
                                                      ? XemoTypography.captionItalic(context)!.copyWith(
                                                          fontWeight: FontWeight.w300,
                                                          fontStyle: FontStyle.italic,
                                                          fontSize: 14,
                                                          color: kLightDisplaySecondaryTextColor,
                                                        )
                                                      : XemoTypography.captionItalic(context)!.copyWith(
                                                          fontWeight: FontWeight.w300,
                                                          fontStyle: FontStyle.italic,
                                                          fontSize: 14,
                                                          color: is_mobile_network_required == "true" ? kErrorColor : kLightDisplaySecondaryTextColor,
                                                        )),
                                            ),
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (contactsController.mobileNetwors.isNotEmpty) {
                                              openNetworkTypeDialog(context, is_from_send_money == "true" ? true : false,
                                                  is_mobile_network_required == "true" ? true : false);
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(top: 38.0, right: 0.015.sw),
                                            child: const Icon(
                                              Icons.arrow_drop_down,
                                              size: 27,
                                              color: kLightDisplayPrimaryAction,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (contactsController.mobileNetwors.isNotEmpty) {
                                          openNetworkTypeDialog(context, is_from_send_money == "true" ? true : false,
                                              is_mobile_network_required == "true" ? true : false);
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 16.h, right: 0.w, left: 2),
                                        padding: EdgeInsets.only(bottom: 4.h, left: 0.w),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: !(contactsController.selectedMobileNetwork.value.isNotEmpty)
                                                    ? const BorderSide(color: Color(0x9B9B9B80), width: 1.7)
                                                    : BorderSide(color: Get.theme.primaryColorLight, width: 1.7))),
                                        width: 1.sw,
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                            canvasColor: Colors.white,
                                          ),
                                          child: Text(
                                            contactsController.selectedMobileNetwork.value,
                                            style: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  //   authController.countryOfBirth.value = newValue.toString();
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 40.h),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                XemoTextFormWithTitleAndNote(
                                  width: 1.sw,
                                  enableRightMargin: false,
                                  controller: contactsController.addressController,
                                  formKey: contactsController.formKey.value,
                                  textFieldKey: contactsController.addressKey,
                                  enableNext: contactsController.enableSave,
                                  title: "common.forms.fullAddress.title".tr,
                                  note: "common.note.required".tr,
                                  validator: XemoFormValidatorWidget().requiredFullAddress,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 8.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(right: 0.02.sw),
                                          child: XemoTextFormWithTitleAndNote(
                                            optional: true,
                                            enableRightMargin: false,
                                            controller: contactsController.zipCodeController,
                                            formKey: contactsController.formKey.value,
                                            textFieldKey: contactsController.zipCodeKey,
                                            enableNext: contactsController.enableSave,
                                            title: "common.forms.zipCode.title".tr,
                                            note: "common.note.optional".tr,
                                            validator: InternationlZipCodesValidator().validator,
                                            inputFormatters: [
                                              ZipCodeInputFormatter(
                                                  countryIso: contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase())
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 0.02.sw),
                                          child: XemoTextFormWithTitleAndNote(
                                            enableRightMargin: false,
                                            controller: contactsController.cityController,
                                            formKey: contactsController.formKey.value,
                                            textFieldKey: contactsController.cityKey,
                                            enableNext: contactsController.enableSave,
                                            title: "common.forms.city.title".tr,
                                            note: "common.note.required".tr,
                                            validator: XemoFormValidatorWidget().requiredCity,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),

                            //account number
                            Container(
                              margin: EdgeInsets.only(top: 15.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //account number
                                  XemoTextFormWithTitleAndNote(
                                    width: 1.sw,
                                    enableRightMargin: false,
                                    optional: is_swift_account_required == 'true' ? false : true,
                                    controller: contactsController.accountNumberController,
                                    formKey: contactsController.formKey.value,
                                    textFieldKey: contactsController.accountNumberKey,
                                    enableNext: contactsController.enableSave,
                                    title: "contact.ibanOrSwift".tr,
                                    note: is_swift_account_required == 'true'
                                        ? "common.note.required".tr
                                        : ('(' + "common.form.field.note.optional".tr + ')'),
                                    validator: is_swift_account_required == 'true'
                                        ? XemoFormValidatorWidget().ibanValidator
                                        : XemoFormValidatorWidget().optionalIbanValidator,
                                  ),
                                  //swift

                                  XemoTextFormWithTitleAndNote(
                                    width: 1.sw,
                                    enableRightMargin: false,
                                    optional: is_swift_account_required == 'true' ? false : true,
                                    controller: contactsController.swiftController,
                                    formKey: contactsController.formKey.value,
                                    textFieldKey: contactsController.swiftKey,
                                    enableNext: contactsController.enableSave,
                                    title: "SWIFT",
                                    note: is_swift_account_required == 'true'
                                        ? "common.note.required".tr
                                        : ('(' + "common.form.field.note.optional".tr + ')'),
                                    validator: is_swift_account_required == 'true'
                                        ? XemoFormValidatorWidget().swiftValidator
                                        : XemoFormValidatorWidget().opationalSwiftValidator,
                                  ),
                                ],
                              ),
                            ), //address data

//
                            SizedBox(
                              height: 50.h,
                              width: 40.w,
                            ),
                            SizedBox(
                              width: 1.sw,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      try {
                                        Get.dialog(Center(
                                          child: RotatedSpinner(
                                            spinnerColor: SpinnerColor.GREEN,
                                            height: 45,
                                            width: 45,
                                          ),
                                        ));
                                        await contactsController.deleteContact(addressBook!);
                                        // Get.offAndToNamed(HomeView.id);
                                        if (is_from_send_money == 'true') {
                                          Get.back();
                                        } else {
                                          Get.offAllNamed(HomeView.id);
                                        }

                                        // Get.until(ModalRoute.withName(HomeView.id));
                                      } catch (error, stackTrace) {
                                        Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
                                        if (Get.isOverlaysOpen) {
                                          Get.back();
                                        }
                                      }
                                    },
                                    child: Container(
                                      height: 45.5.h,
                                      width: 235.w,
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(left: 18.w, bottom: 18.h, right: 18.w),
                                      padding: EdgeInsets.only(left: 13.w),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 3))]),
                                      child: Center(
                                        child: Row(
                                          //    mainAxisAlignment: MainAxisAlignment,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/xemo/contact-icon_remove.svg',
                                              height: 35.h,
                                              width: 35.w,
                                            ),
                                            Expanded(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'contact.removeContact'.tr.toUpperCase(),
                                                  style: XemoTypography.captionSemiBold(context),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Opacity(
                                    opacity: contactsController.enableSave.value ? 1 : 0.5,
                                    child: GestureDetector(
                                      onTap: () async {
                                        //TODO FORM VALIDATION BEFORE SAVE
                                        if (contactsController.formKey.value.currentState != null
                                            ? contactsController.formKey.value.currentState!.validate()
                                            : false) {
                                          Get.dialog(Center(
                                            child: RotatedSpinner(
                                              spinnerColor: SpinnerColor.GREEN,
                                              height: 45,
                                              width: 45,
                                            ),
                                          ));
                                          try {
                                            AddressBook updatedAddressBook = await contactsController.updateContact(addressBook!);
                                            //it takes two seconds to get save based on the logs
                                            //the ds async function are not real time or porperly implemented
                                            //for us to know that the async function really ended or
                                            //still function in the background
                                            // await Future.delayed(const Duration(seconds: 2));

                                            if (Get.isOverlaysOpen) {
                                              Get.back();
                                            }
                                            if (sendMoneyController.fromContact.value) {
                                              sendMoneyController.selectTransferReasonState.enter();
                                              sendMoneyController.nextStep();
                                              sendMoneyController.selectedReceiver.value = updatedAddressBook;
                                            } else {
                                              Get.back<AddressBook>(result: updatedAddressBook);
                                            }
                                            contactsController.selectedAddressBook.value = updatedAddressBook;
                                            startSuccessfullyUpdatedDataSnackbar();
                                          } catch (error, stackTrace) {
                                            Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
                                            log("error?" + error.toString());
                                            //display error?
                                            if (Get.isOverlaysOpen) {
                                              Get.back();
                                            }
                                            startWarningSnackbar();
                                          }
                                        }
                                      },
                                      child: Container(
                                        //alignment: Alignment.bottomCenter,
                                        height: 58.h,
                                        width: 1.sw,
                                        margin: EdgeInsets.only(bottom: 8.0, left: 0.015.sw, right: 0.01.sw),
                                        decoration: BoxDecoration(
                                          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 2))],
                                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                                          color: kLightDisplayPrimaryAction,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'common.save'.tr.toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: Get.textTheme.headline4!.copyWith(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))),
      );
    });
  }
}
