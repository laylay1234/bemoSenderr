// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/controllers/transaction_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/models/AddressBook.dart';
import 'package:mobileapp/models/GlobalTransaction.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/views/home/send_money_views/send_money_view.dart';
import 'package:mobileapp/widgets/common/lazy_loading_widget.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/dialogs/transaction_dialog_widgets/reciever_data_widget.dart';
import 'package:mobileapp/widgets/home/transaction_history_card_widget.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../../utils/countries_tr_helper.dart';
import '../../../utils/error_alerts_utils.dart';
import 'edit_contact_view.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_model.dart' as cm;
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/providers/country_provider.dart' as cp;

class SendToContactView extends StatelessWidget {
  static const String id = '/send-to-contact-view';

  const SendToContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AddressBook addressBook;
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    ProfileController profileController = Get.find<ProfileController>();
    ContactsController contactsController = Get.find<ContactsController>();
    TransactionController transactionController = Get.find<TransactionController>();
    //addressBook = contactsController.selectedAddressBook.value!;
    List<GlobalTransaction> transactions = profileController.getTransactionsByAddressBook(contactsController.selectedAddressBook.value!);
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);
    cm.Country? tmp = CountriesTrHelper().getCountryTrDataByName(
        sendMoneyController.countries.firstWhereOrNull((e) => e.id == contactsController.selectedAddressBook.value!.address!.country!.id)!.name);
    //log((tmp != null).toString());
    //
    log(sendMoneyController.availableCountries!.value.toString());
    contactsController.initTransactions(transactions);
    return Obx(() {
      return Scaffold(
          appBar: XemoAppBar(leading: true),
          body: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    //height: 0.6.sh,
                    padding: EdgeInsets.only(top: 37.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 68.w,
                        ),
                        Column(
                          children: [
                            ClipOval(
                              child: SvgPicture.asset(
                                "assets/xemo/avatar-generic_big_3x.svg",
                                width: 103.w,
                                height: 103.h,
                              ),
                            ),
                            Container(
                              width: 0.62.sw,
                              margin: EdgeInsets.only(top: 21.5.h),
                              child: Text(
                                contactsController.selectedAddressBook.value!.first_name +
                                    ' ' +
                                    contactsController.selectedAddressBook.value!.last_name,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.fade,
                                style: XemoTypography.headLine5Black(context),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.5.h),
                              child: Text(
                                FormatPlainTextPhoneNumberByNumber().format(contactsController.selectedAddressBook.value!.phone_number.startsWith('+')
                                    ? contactsController.selectedAddressBook.value!.phone_number
                                    : ('+' + contactsController.selectedAddressBook.value!.phone_number)),
                                textAlign: TextAlign.center,
                                style: XemoTypography.captionLight(context)!.copyWith(fontSize: 16.sp),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: SvgPicture.asset(
                                      "assets/flags/${contactsController.selectedAddressBook.value!.address!.country!.iso_code.toLowerCase()}.svg",
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      tmp == null
                                          ? sendMoneyController.countries
                                              .firstWhereOrNull((e) => e.id == contactsController.selectedAddressBook.value!.address!.country!.id)!
                                              .name
                                              .tr
                                              .capitalizeFirst!
                                          : CountriesTrHelper().getCountryName(tmp)!,
                                      style: XemoTypography.bodySemiBold(context),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            // contactsController.selectedAddressBook.value = addressBook;
                            // contactsController.selectedAddressBook.refresh();
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
                              PhoneNumberInputFormatter(countryIso: contactsController.selectedDestinationCountry!.value!.iso_code.toUpperCase());
                              Get.back();
                            } catch (error, stackTrace) {
                              Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
                              dbg(error.toString(), isError: true);
                              log(error.toString());
                              Get.back();
                            }
                            Get.toNamed(EditContactView.id, parameters: {"is_from_send_money": "false"})!.then((value) {
                              if (value != null) {
                                //log('updated ! now its back');
                                AddressBook updatedAddressBook = value as AddressBook;
                                contactsController.selectedAddressBook.value = updatedAddressBook;
                                contactsController.enableSave.value = contactsController.formKey.value.currentState!.validate();
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 14.w),
                            padding: const EdgeInsets.all(5.0),
                            width: 50.w,
                            height: 50.h,
                            decoration: const BoxDecoration(color: Color(0xFFF05137), borderRadius: BorderRadius.all(Radius.circular(7))),
                            child: SvgPicture.asset(
                              'assets/xemo/edit_contact.svg',
                              height: 20.h,
                              width: 20.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    //height: 0.5.sh,
                    child: Opacity(
                      opacity: sendMoneyController.availableCountries!
                              .where((e) => contactsController.selectedAddressBook.value!.address!.country!.id == e.id)
                              .isNotEmpty
                          ? sendMoneyController.availableCountries!
                                  .where((e) => contactsController.selectedAddressBook.value!.address!.country!.id == e.id)
                                  .first
                                  .enabled_as_destination
                              ? 1
                              : 0.5
                          : 0.5,
                      child: GestureDetector(
                        onTap: () async {
                          if (sendMoneyController.availableCountries!
                              .where((e) => contactsController.selectedAddressBook.value!.address!.country!.id == e.id)
                              .isNotEmpty) {
                            if (sendMoneyController.availableCountries!
                                .where((e) => contactsController.selectedAddressBook.value!.address!.country!.id == e.id)
                                .first
                                .enabled_as_destination) {
                              try {
                                Get.dialog(Center(
                                  child: RotatedSpinner(
                                    spinnerColor: SpinnerColor.GREEN,
                                    height: 45,
                                    width: 45,
                                  ),
                                ));
                                var country = sendMoneyController.availableCountries!
                                    .where((e) => contactsController.selectedAddressBook.value!.address!.country!.id == e.id)
                                    .first;
                                log(country.toJson());
                                sendMoneyController.selectedDestinationCountry!.value = country;
                                sendMoneyController.selectedReceiver.value = contactsController.selectedAddressBook.value!;
                                // sendMoneyController.selectedReceiver.refresh();
                                sendMoneyController.fromContact.value = true;
                                await sendMoneyController.getExchangeRate('25');
                                sendMoneyController.calculateTotal();
                                await transactionController.loadUserLimits();
                                transactionController.checkAndHandleTransactionLimitsByUserInput();
                                if (Get.isOverlaysOpen) {
                                  Get.back();
                                }
                                Get.toNamed(SendMoneyView.id);
                              } catch (error, stackTrace) {
                                Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
                                log(error.toString());
                                if (Get.isOverlaysOpen) {
                                  Get.back();
                                }
                              }
                            }
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 12.h, left: 24.w),
                          height: 55.h,
                          width: 325.w,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: Offset(0, 3))],
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: kLightDisplayPrimaryAction),
                          child: Center(
                            child: Text('send.money.sendMoney'.tr.toUpperCase(),
                                textAlign: TextAlign.center, style: XemoTypography.buttonAllCapsWhite(context)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: 24.w, top: 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'send.money.latestTransactions'.tr,
                      style: Get.textTheme.caption!.copyWith(fontSize: 12.sp, color: const Color(0xFF9B9B9B)),
                    ),
                  ],
                ),
              ),
              transactions.isNotEmpty
                  ? LazyLoadScrollView(
                      onEndOfPage: () => contactsController.loadMoreTransactions(transactions),
                      isLoading: contactsController.isLoadingMoreTransaction.value,
                      child: Column(
                        children: [
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              primary: false,
                              itemCount: transactions != null
                                  ? ////////////////////
                                  (contactsController.loadedTransactions.value + 1)
                                  : 0,
                              itemBuilder: (context, index) {
                                if (index <= (transactions.length - 1)) {
                                  return TransactionHistoryCardWidget(
                                    globalTransaction: transactions[index],
                                  );
                                } else if (index == transactions.length) {
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
                          (contactsController.isLoadingMoreTransaction.value && !(contactsController.loadedTransactions.value == transactions.length))
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
                    )
                  : Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 50),
                      child: Text(
                        'history.label.noTransactionsHistory'.tr,
                        style: XemoTypography.captionItalic(context)!.copyWith(color: kLightDisplayInfoText),
                      ),
                    )
            ],
          ));
    });
  }
}
