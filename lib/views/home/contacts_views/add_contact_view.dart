import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/models/Country.dart';
import 'package:mobileapp/models/Gender.dart';
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
import 'package:screen_size_test/screen_size_test.dart';
import 'dart:math' as math;

import '../../../utils/error_alerts_utils.dart';
import '../../../widgets/dialogs/contact_dialogs_widgets/select_address_dialog_widget.dart';
import '../../../widgets/dialogs/contact_dialogs_widgets/select_network_dialog_widget.dart';
import '../../../widgets/dialogs/contact_dialogs_widgets/select_phone_number_dialog_widget.dart'; // import this

class AddContactView extends StatelessWidget {
  static const String id = '/add-contact-view';

  const AddContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactsController contactsController = Get.find<ContactsController>();
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    String is_swift_account_required = Get.parameters['is_swift_account_required'] ?? 'false';
    String is_mobile_network_required = Get.parameters['is_mobile_network_required'] ?? 'false';
    String is_from_send_money = Get.parameters['is_from_send_money'] ?? 'false';

    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    contactsController.clearData();

    if (is_from_send_money == 'true') {
      contactsController.setInitialDataForContactFromSendMoney();
      contactsController.getMobileNetworks();
    }
    // contactsController.getMobileNetworks();
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          return Future.value(true);
        },
        child: Scaffold(
            appBar: XemoAppBar(leading: true),
            body: SingleChildScrollView(
                child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: contactsController.formKey.value,
              child: Container(
                margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw),
                child: Column(
                  children: [
                    Container(margin: EdgeInsets.only(top: 20.h)),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "contact.newContact".tr,
                        textAlign: TextAlign.center,
                        style: Get.textTheme.headline3!.copyWith(color: const Color(0xFFF05137), fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                    //
                    GestureDetector(
                      onTap: () async {
                        //
                        contactsController.askForUserConsent();
                        //
                        //

                        //
                      },
                      child: Container(
                        width: 0.8.sw,
                        height: 55.h,
                        margin: EdgeInsets.only(top: 14.h),
                        decoration: const BoxDecoration(
                            color: kLightDisplayPrimaryAction,
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/xemo/icon-menu-contacts.svg',
                              height: 30.h,
                              width: 30.h,
                              color: Colors.white,
                            ),
                            Container(
                              width: 10.w,
                            ),
                            Text(
                              'contacts.fromContacts'.tr.toUpperCase(),
                              style:
                                  XemoTypography.captionLight(context)!.copyWith(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                    //
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
                                              //  boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                                              border: Border.all(color: kLightDisplayPrimaryAction, width: 2))
                                          : BoxDecoration(
                                              color: Colors.white,
                                              //   boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
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
                                              //   boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                                              border: Border.all(color: kLightDisplayPrimaryAction, width: 2))
                                          : BoxDecoration(
                                              color: Colors.white,
                                              //   boxShadow: const [BoxShadow(blurRadius: 5, color: Color.fromARGB(75, 0, 0, 0), offset: Offset(0, 3))],
                                              borderRadius: const BorderRadius.all(Radius.circular(24)),
                                              border: Border.all(color: kLightDisplayPrimaryAction, width: 2)),
                                      child: Center(
                                        child: Text(
                                          "common.female".tr.capitalizeFirst!,
                                          style: Get.textTheme.headline4!.copyWith(
                                              fontSize: Get.width < 390 ? 14.sp : 17.sp,
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
                                              border: Border.all(color: kLightDisplayPrimaryAction, width: 2))
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
                    Column(
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
                          validator: XemoFormValidatorWidget().requiredFirstName,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-ZÀ-ÿZàâäæáãåāèéêëęėēîïīįíìôōøõóòöœùûüūúÿçćčńñÀÂÄÆÁÃÅĀÈÉÊËĘĖĒÎÏĪĮÍÌÔŌØÕÓÒÖŒÙÛÜŪÚŸÇĆČŃÑ ]')),
                          ],
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
                          validator: XemoFormValidatorWidget().requiredLastName,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp('[a-zA-ZÀ-ÿZàâäæáãåāèéêëęėēîïīįíìôōøõóòöœùûüūúÿçćčńñÀÂÄÆÁÃÅĀÈÉÊËĘĖĒÎÏĪĮÍÌÔŌØÕÓÒÖŒÙÛÜŪÚŸÇĆČŃÑ ]')),
                          ],
                        ),
                      ],
                    ),
                    //  name selection
                    //
                    //From country
                    Container(
                      margin: EdgeInsets.only(
                        top: 25.h,
                        // left: 0.05.sw,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            //  margin: EdgeInsets.only(left: 0.05.w),
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
                              //  padding: const EdgeInsets.all(5.0),
                              height: 45.h,

                              width: contactsController.selectedDestinationCountry!.value != null ? 200.w : 230.w,
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  color: Colors.white,
                                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(0, 0))]),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  ClipOval(
                                    child: contactsController.selectedDestinationCountry?.value != null
                                        ? Container(
                                            margin: const EdgeInsets.only(left: 3.0),
                                            child: SvgPicture.asset(
                                              contactsController.selectedDestinationCountry?.value != null
                                                  ? "assets/flags/${contactsController.selectedDestinationCountry!.value!.iso_code.toLowerCase()}.svg"
                                                  : 'assets/images/placeholder.svg',
                                              height: 30,
                                              width: 30,
                                            ),
                                          )
                                        : Container(),
                                  ),
                                  contactsController.selectedDestinationCountry?.value != null
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                            left: 4.0,
                                            // top: 8.h,
                                          ),
                                          child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                // contactsController.exchangeRate!.value.isValid()
                                                SizedBox(
                                                  width: 128.w,
                                                  child: Text(
                                                    contactsController.selectedDestinationCountry!.value != null
                                                        ? contactsController.selectedDestinationCountry!.value!.name
                                                        : '',
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Get.textTheme.subtitle2!.copyWith(fontSize: 17.sp, fontWeight: FontWeight.w700),
                                                  ),
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
//                                    selectCountryDialog(fromContact: true);
                                      if (is_from_send_money == "false") {
                                        await selectCountryDialog(fromContact: true);
                                      }
                                      //   selectCountryDialog(fromContact: true);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      margin: const EdgeInsets.only(right: 3.0),
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
                        opacity: contactsController.selectedDestinationCountry!.value != null ? 1 : 0.2,
                        child: !(contactsController.selectedDestinationCountry!.value != null)
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //phone number field
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 40.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "common.label.phoneNumber".tr.toUpperCase(),
                                          style: Get.textTheme.headline2!.copyWith(fontWeight: FontWeight.w800, fontSize: 16),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5.h),
                                          child: Text("common.note.required".tr,
                                              style: InternationlPhoneValidator().validator(
                                                        value: contactsController.phoneNumberController.value.text.replaceAll(' ', ''),
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
                                                    )),
                                        ),
                                        Container(
                                          // margin: EdgeInsets.only(right: 8.w),
                                          height: 75.h,
                                          padding: const EdgeInsets.only(left: 2),
                                          // margin: EdgeInsets.only(left: 1.w),
                                          child: InternationalPhoneNumberInput(
                                            phoneKey: contactsController.phoneNumberKey.value,
                                            width: 1.sw,
                                            autoFocus: false,
                                            initialValue: PhoneNumber(isoCode: 'MA'),
                                            countries: ['MA'],
                                            //  countries: originController.available_origin_countries.value.map((e) => e.iso_code!.toUpperCase()).toList(),
                                            selectorTextStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                                            textFieldController: contactsController.phoneNumberController.value,
                                            inputFormatters: [
                                              PhoneNumberInputFormatter(countryIso: 'MA'),
                                              //  FilteringTextInputFormatter.digitsOnly,
                                            ],
                                            selectorConfig:
                                                SelectorConfig(useEmoji: true, leadingPadding: 2.w, selectorType: PhoneInputSelectorType.DIALOG),
                                            onInputChanged: (value) async {
                                              contactsController.phoneNumberController.refresh();
                                              log(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                                              InternationlPhoneValidator().update('MA');
                                              InternationlZipCodesValidator().update('MA');
                                            },
                                            textStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                                            keyboardType: TextInputType.phone,
                                            validator: (val) {
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
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //phone number field
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 40.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "common.label.phoneNumber".tr.toUpperCase(),
                                          style: Get.textTheme.headline2!.copyWith(fontWeight: FontWeight.w800, fontSize: 16),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5.h),
                                          child: Text("common.note.required".tr,
                                              style: !(contactsController.phoneNumberKey.value.currentState != null &&
                                                      contactsController.phoneNumberKey.value.currentState!.validate())
                                                  ? XemoTypography.captionItalic(context)!.copyWith(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 14,
                                                    )
                                                  : XemoTypography.captionItalic(context)!.copyWith(
                                                      fontWeight: FontWeight.w300,
                                                      fontStyle: FontStyle.italic,
                                                      fontSize: 14,
                                                      color: kLightDisplaySecondaryTextColor,
                                                    )),
                                        ),
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
                                            inputFormatters: [
                                              PhoneNumberInputFormatter(
                                                  countryIso: contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase()),
                                              //  FilteringTextInputFormatter.digitsOnly,
                                            ],
                                            selectorConfig:
                                                SelectorConfig(useEmoji: true, leadingPadding: 2.w, selectorType: PhoneInputSelectorType.DIALOG),
                                            onInputChanged: (value) async {
                                              contactsController.phoneNumberController.refresh();
                                              log(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                                              InternationlPhoneValidator()
                                                  .update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                                              InternationlZipCodesValidator()
                                                  .update(contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                                            },
                                            textStyle: XemoTypography.bodyBold(context)!.copyWith(color: kLightDisplayPrimaryAction),
                                            keyboardType: TextInputType.phone,
                                            validator: (val) {
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
                                  //address data
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
                                                                color: is_mobile_network_required == "true"
                                                                    ? kErrorColor
                                                                    : kLightDisplaySecondaryTextColor,
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
                                  //
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
                                        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\n"))],
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
                                                        countryIso: contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase()),
                                                    FilteringTextInputFormatter.deny(RegExp(r"\n"))
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
                                                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\n"))],
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
                                    margin: EdgeInsets.only(
                                      top: 15.h,
                                    ),
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
                                              ? "common.note.requiredred".tr
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
                                  ),
                                  //swift

                                  SizedBox(
                                    height: 50.h,
                                    width: 40.w,
                                  ),
                                  SizedBox(
                                    width: 1.sw,
                                    child:
                                        Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      Opacity(
                                        opacity: contactsController.formKey.value.currentState != null
                                            ? (contactsController.enableSave.value && contactsController.selectedGender.value != null)
                                                ? 1
                                                : 0.5
                                            : 1,
                                        child: GestureDetector(
                                          onTap: () async {
                                            //TODO FORM VALIDATION BEFORE SAVE
                                            bool formValidationState = contactsController.formKey.value.currentState != null
                                                ? ((contactsController.enableSave.value && contactsController.selectedGender.value != null))
                                                : false;
                                            if (is_mobile_network_required == "true") {
                                              formValidationState = formValidationState && contactsController.selectedMobileNetwork.isNotEmpty;
                                            }
                                            if (formValidationState) {
                                              Get.dialog(Center(
                                                child: RotatedSpinner(
                                                  spinnerColor: SpinnerColor.GREEN,
                                                  height: 45,
                                                  width: 45,
                                                ),
                                              ));
                                              try {
                                                await contactsController.saveContact();
                                                //it takes two seconds to get save based on the logs
                                                //the ds async function are not real time or porperly implemented
                                                //for us to know that the async function really ended or
                                                //still function in the background
                                                // await Future.delayed(const Duration(seconds: 2));
                                                if (Get.isOverlaysOpen) {
                                                  Get.back();
                                                }
                                                if (is_from_send_money == 'true') {
                                                  Get.back();
                                                } else {
                                                  Get.offAllNamed(HomeView.id);
                                                }

                                                startSuccessfullyUpdatedDataSnackbar();
                                              } catch (error, stackTrace) {
                                                Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
                                                log(error.toString());
                                                //display error?
                                                if (Get.isOverlaysOpen) {
                                                  Get.back();
                                                }
                                                startWarningSnackbar();
                                              }
                                            }
                                          },
                                          child: Container(
                                            alignment: Alignment.bottomCenter,
                                            height: 58.h,
                                            width: 1.sw,
                                            margin: const EdgeInsets.only(bottom: 8.0),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                              color: kLightDisplayPrimaryAction,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'common.save'.tr.toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style:
                                                    Get.textTheme.headline4!.copyWith(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
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
