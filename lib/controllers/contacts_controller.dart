import 'dart:convert';
import 'dart:developer';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart' show Center, FormFieldState, FormState, GlobalKey, TextEditingController;
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_amplifysdk/utils/rest_service/rest_service.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as fContacts;
import 'package:get/get.dart';
import 'package:mobileapp/app_models/app_address.dart';
import 'package:mobileapp/app_models/app_addressBook.dart';
import 'package:mobileapp/app_models/app_user.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/entities/exchange_data_entity.dart';
import 'package:mobileapp/entities/mobile_network_entity.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/utils/error_alerts_utils.dart';
import 'package:mobileapp/views/home/contacts_views/add_contact_view.dart';
import 'package:mobileapp/views/home/send_money_views/transfer_reason_view.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/dialogs/user_consent_dialog_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:statemachine/statemachine.dart';

import '../utilities/text_phone_number_formatter.dart';
import '../widgets/common/all_widgets.dart';
import '../widgets/common/xemo_form_validator.dart';
import '../widgets/dialogs/contact_dialogs_widgets/select_address_dialog_widget.dart';
import '../widgets/dialogs/contact_dialogs_widgets/select_phone_number_dialog_widget.dart';

class ContactsController extends GetxController {
  Rx<AddressBook?> selectedAddressBook = (null as AddressBook?).obs;

  //
  Rx<bool> enableSave = false.obs;
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  Rx<bool> loadingExchangeData = false.obs;
  //
  Rx<ExchangeRate>? exchangeRate = ExchangeRate().obs;
  Rx<Country?>? selectedDestinationCountry = (null as Country?).obs;
  Rx<Country?>? selectedTempoCountry = (null as Country?).obs;

  //lazy loading variables
  Rx<bool> isLoadingMoreTransaction = false.obs;
  Rx<int> loadedTransactions = 0.obs;

  //mobile network variables
  Rx<String> selectedMobileNetwork = ''.obs;
  RxList mobileNetwors = [].obs;
  Rx<MobileNetworksEntity> mobileNetworkEntity = MobileNetworksEntity(networks: []).obs;
  //
  Rx<Gender?> selectedGender = (null as Gender?).obs;
  Rx<String> selectedCountry = ''.obs;
  Rx<GlobalKey<FormFieldState>> firstNameKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> fnameController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> lastNameKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> lnameController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> addressKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> phoneNumberKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> zipCodeKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> zipCodeController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> cityKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> swiftKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> swiftController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> accountNumberKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> accountNumberController = TextEditingController().obs;
  Rx<String> calling_code_iso = ''.obs;
  SendMoneyController get sendMoneyController {
    return Get.find<SendMoneyController>();
  }

  ProfileController get profileController {
    return Get.find<ProfileController>();
  }

  AuthController get authController {
    return Get.find<AuthController>();
  }

  Machine stateMachine = Machine<String>(); //textfield controller
  late State loadingState;
  late State initState;
  late State errorState;
  late State confirmedState;
  //
  //
  //

  //
  //
  //
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    loadingState = stateMachine.newState('loadingState')
      ..onEntry(() {
        //
      });
    initState = stateMachine.newState('initState')
      ..onEntry(() {
        clearValues();
      });
    errorState = stateMachine.newState('errorState')
      ..onEntry(() {
        //
      });
    confirmedState = stateMachine.newState('confirmedState')
      ..onEntry(() {
        //
        Get.offAndToNamed(TransferReasonView.id);
        clearValues();
      });
  }

  void clearValues() {
    fnameController.value.clear();
    lnameController.value.clear();
    phoneNumberController.value.clear();
    zipCodeController.value.clear();
    cityController.value.clear();
    accountNumberController.value.clear();
    swiftController.value.clear();
  }

  Future<void> saveContact() async {
    //validate the form

    //get calling code
    await addContactToDataStore();
    profileController.sortContacts();
    //clearValues();
  }

  void updateContactsInSendMoneyController(AddressBook addressBook) {
    // SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    sendMoneyController.selectedReceiver.value = addressBook;
    //sendMoneyController.loadFiltredAddressBooks();
  }

  Future<void> addContactToDataStore({bool fromSendMoney = true}) async {
    calling_code_iso.value = int.parse(selectedDestinationCountry!.value!.calling_code!).toString();
    //ProfileController profileController = Get.find<ProfileController>();
    var tmpAdress = Address(
        country: selectedDestinationCountry!.value!,
        city: cityController.value.text.trim(),
        postal_code: zipCodeController.value.text.trim(),
        state: '',
        address_line_1: addressController.value.text.trim(),
        address_line_2: '');
    await AppAddress().save(data: tmpAdress.toJson());
    //await Amplify.DataStore.save(tmpAdress);
    // log(tmpAdress.id);

    AddressBook tmpbook = AddressBook(
      removed: false,
      account_number: accountNumberController.value.text.trim(),
      addressID: tmpAdress.id,
      bank_swift_code: swiftController.value.text.trim(),
      first_name: fnameController.value.text.trim(),
      gender: selectedGender.value!,
      language: 'fr',
      mobile_network: selectedMobileNetwork.value,
      last_name: lnameController.value.text.trim(),
      phone_number: (calling_code_iso.value + phoneNumberController.value.text.replaceAll('-', '')),
      address: tmpAdress,
      transactions: const [],
      user: profileController.userInstance!.value,
    );
    AddressBook? result = await AppAddressBook().save(data: tmpbook.toJson());
    tmpbook = tmpbook.copyWith(id: result!.id);
    profileController.loadData();
    profileController.addressBooks!.addIf(profileController.addressBooks!.where((e) => e.id == tmpbook.id).isEmpty, tmpbook);
    if (fromSendMoney) {
      updateContactsInSendMoneyController(tmpbook);
    }
    //sort
    profileController.sortGlobalTransactions(sort: true, fromSendMoney: false);
    //update the filtred contacts in the profileController (recent and all contacts)
    sendMoneyController.loadFiltredAddressBooks();
  }

  void goToAddReceiver({bool is_swift_bank_required = false, bool is_mobile_network_required = false, bool fromSendMoney = false}) {
    clearValues();
    Get.toNamed(AddContactView.id, parameters: {
      'is_swift_account_required': is_swift_bank_required.toString(),
      'is_mobile_network_required': is_mobile_network_required.toString(),
      'is_from_send_money': fromSendMoney.toString()
    });
  }

  //used for add contact view when its from the send money flow
  Future<void> setInitialDataForContactFromSendMoney() async {
    selectedDestinationCountry!.value = sendMoneyController.selectedDestinationCountry!.value;
    //calling_code_iso.value = selectedDestinationCountry!.value!.calling_code;
  }

  Future<Country?> setDestinationCountryByCallingCode(String callingCode, {bool fromContact = true}) async {
    try {
      String callingCodeWithoutPlus = callingCode.startsWith('+') ? callingCode.substring(1) : callingCode;

      Rx<Country> country =
          sendMoneyController.countries.where((e) => callingCodeWithoutPlus.startsWith(int.parse(e.calling_code!).toString())).first.obs;

      if (fromContact == false) {
        if (sendMoneyController.selectedDestinationCountry!.value.id != country.value.id) {
          //TODO handle this case
          selectedDestinationCountry!.value =
              sendMoneyController.availableCountries!.where((e) => callingCodeWithoutPlus.startsWith(int.parse(e.calling_code!).toString())).first;
          phoneNumberController.value.text = callingCodeWithoutPlus;
          calling_code_iso.value = int.parse(selectedDestinationCountry!.value!.calling_code!).toString();
          return null;
        }
      }
      //
      //
      if (!country.value.active) {
        selectedDestinationCountry!.value = sendMoneyController.availableCountries!.first;
        phoneNumberController.value.text = callingCodeWithoutPlus.substring(selectedDestinationCountry!.value!.calling_code!.length - 1);
        calling_code_iso.value = int.parse(selectedDestinationCountry!.value!.calling_code!).toString();

        CommonWidgets.buildErrorDialogue(
            title: 'snackbar.warning.title'.tr,
            code: '',
            message: "import.contact.error.notAvaialable".tr,
            snackPosition: SnackPosition.BOTTOM,
            context: Get.context);

        return null;
      }
      //
      //
      selectedDestinationCountry!.value =
          sendMoneyController.availableCountries!.where((e) => callingCodeWithoutPlus.startsWith(int.parse(e.calling_code!).toString())).first;
      if ((selectedDestinationCountry!.value!.iso_code.contains('ca')) || (selectedDestinationCountry!.value!.iso_code.contains('us'))) {
        selectedDestinationCountry!.value = null;
        return null;
      }
      await getExchangeRate('20');
      return selectedDestinationCountry!.value;
    } catch (error, stackTrace) {
      //the first
      //
      String callingCodeWithoutPlus = callingCode.startsWith('+') ? callingCode.substring(1) : callingCode;

      selectedDestinationCountry!.value = sendMoneyController.availableCountries!.first;
      phoneNumberController.value.text = callingCodeWithoutPlus;
      calling_code_iso.value = int.parse(selectedDestinationCountry!.value!.calling_code!).toString();

      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log("setDestinationCountryByCallingCode: " + error.toString());
      return null;
    }
  }

  Future<void> getExchangeRate(String amount) async {
    exchangeRate!.value = ExchangeRate();
    loadingExchangeData.value = true;

    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    //assing non-valid exchangeRate object
    log("from getExchangeRate:" + selectedDestinationCountry!.value!.iso_code);
    var token = await authController.getToken();
    try {
      var response = await getConnect.post('${sendMoneyController.api}/get-charges-by-amount', {
        'origin_country': sendMoneyController.originCountry.value!.iso_code,
        'amount': amount.isEmpty ? '1' : double.parse(amount),
        'destination_country': selectedDestinationCountry!.value!.iso_code,
      }, headers: {
        //TODO get user token and add it to auth
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      ExchangeRate? tmp;
      if (response.statusCode == 200) {
        String receivedJson = response.bodyString!;
        Map<String, dynamic> data = json.decode(receivedJson);
        tmp = ExchangeRate.fromJson(data['response']);
        exchangeRate!.value = tmp;
      }
    } catch (error, stackTrace) {
      if (Get.isOverlaysOpen) {
        Get.back();
      }
      log("heere exchange rate" + error.toString());
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      //dbg("heere exchange rate" + e.toString(), isError: true);
    }
    loadingExchangeData.value = false;
  }

  void setInitialValuesForUpdate(AddressBook addressBook) async {
    fnameController.value.text = addressBook.first_name;
    lnameController.value.text = addressBook.last_name;
    addressController.value.text = addressBook.address!.address_line_1 ?? '';
    zipCodeController.value.text = addressBook.address!.postal_code;
    cityController.value.text = addressBook.address!.city;
    swiftController.value.text = addressBook.bank_swift_code ?? '';
    accountNumberController.value.text = addressBook.account_number ?? '';
    selectedGender.value = addressBook.gender;

    // getExchangeRate('1');
  }

  Future<void> setInitialMobileNetwork(AddressBook addressBook) async {
    log(addressBook.address!.country!.name.toLowerCase());
    selectedDestinationCountry!.value = sendMoneyController.countries.where((e) => e.id == addressBook.address!.country!.id).first;
    await getExchangeRate('1');
    String savedMobileNetwork = addressBook.mobile_network ?? '';
    if (savedMobileNetwork.isNotEmpty) {
      await getMobileNetworks();
      String langCode = Get.locale!.languageCode.toLowerCase();
      String currentName = mobileNetworkEntity.value.networks!
          .where((i) => i.names!.where((j) => j.name!.toLowerCase().contains(savedMobileNetwork.toLowerCase())).isNotEmpty)
          .first
          .names!
          .where((e) => e.lang!.toLowerCase().contains(langCode))
          .first
          .name!;
      selectedMobileNetwork.value = currentName;
    } else {
      await getMobileNetworks();
    }

    //set old destination country and exchange rate
    String callingCode = int.parse(selectedDestinationCountry!.value!.calling_code!).toString();
    calling_code_iso.value = callingCode;
//
    String phoneWithoutCode = addressBook.phone_number.startsWith('+')
        ? addressBook.phone_number.substring(1).startsWith(callingCode)
            ? addressBook.phone_number.substring(callingCode.length + 1)
            : addressBook.phone_number.substring(1)
        : addressBook.phone_number.startsWith(callingCode)
            ? addressBook.phone_number.substring(callingCode.length)
            : addressBook.phone_number;

    //calling_code
    phoneNumberController.value.text = phoneWithoutCode;
    if (phoneNumberKey.value.currentState != null) {
      phoneNumberKey.value.currentState!.validate();
    }
  }

  Future<void> deleteContact(AddressBook addressBook) async {
    var removedAddressBook = addressBook.copyWith(removed: true);
    await AppAddressBook().save(data: removedAddressBook.toJson());
    //remove it from the local varabiles
    //update the addressBooks variable
    profileController.addressBooks!.value = profileController.addressBooks!.where((e) => e.id != addressBook.id).toList();

    //update the recent contacts
    profileController.recentAddressBooks!.value = (await profileController.getRecentAddressBookByGlobalTransactions()) ?? [];

    //sort
    profileController.sortGlobalTransactions(sort: true, fromSendMoney: false);
    //update the filtred contacts in the profileController (recent and all contacts)
    sendMoneyController.loadFiltredAddressBooks();
    profileController.sortContacts();
    profileController.sortRecentContacts();
  }

  Future<void> getMobileNetworks() async {
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    //assing non-valid exchangeRate object
    var token = await authController.getToken();
    try {
      var response = await getConnect.post('${sendMoneyController.api}/get-mobile-networks', {
        'destination_country': selectedDestinationCountry!.value!.iso_code,
      }, headers: {
        //TODO get user token and add it to auth
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });
      if (response.statusCode == 200) {
        dbg(response.body, isError: true);
        String receivedJson = response.bodyString!;
        log(receivedJson);
        mobileNetworkEntity.value = MobileNetworksEntity.fromJson(json.decode(receivedJson));
        mobileNetwors.value = mobileNetworkEntity.value.networks!.map((e) => e.getCurrentName()).toList();
        selectedMobileNetwork.value = '';
        log(mobileNetwors.length);
      } else {
        log(response.body);
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log("getMobileNetworks " + error.toString());
      //dbg("heere exchange rate" + e.toString(), isError: true);
    }
  }

  //
  Future<void> handleImportContactFromDevice({bool fromContact = true}) async {
    var requestResult = await Permission.contacts.request();

    if (requestResult.isGranted || requestResult.isLimited) {
      try {
        var contact = await fContacts.FlutterContacts.openExternalPick();
        //
        if (contact != null) {
          //log(contact.name);
          fnameController.value.text = contact.name.first;
          lnameController.value.text = (contact.name.last + " " + contact.name.middle);
          //log(contact.addresses.toList().toString());
          var phones = contact.phones;
          final fullName = (contact.name.first + " " + (contact.name.last + " " + contact.name.middle));
          if (contact.phones.length > 1) {
            await openSelectPhoneFromList(phones, fullName, fromContact: fromContact);
            if (phoneNumberController.value.text.isNotEmpty) {
              //Address Selection
              if (contact.addresses.isNotEmpty && (contact.addresses.length > 1)) {
                await openSelectAddressFromList(contact.addresses, fullName);
              } else if (contact.addresses.length == 1) {
                addressController.value.text = contact.addresses.first.street;
                cityController.value.text = contact.addresses.first.city;
                zipCodeController.value.text = contact.addresses.first.postalCode;
                if (Get.isOverlaysOpen) {
                  Get.back();
                }
              }
            }
          } else if (contact.phones.length == 1) {
            Get.dialog(Center(
              child: RotatedSpinner(
                spinnerColor: SpinnerColor.GREEN,
                height: 45,
                width: 45,
              ),
            ));
            //print(contact.phones.first.number);
            String phoneNumber = contact.phones.first.normalizedNumber.isEmpty
                ? contact.phones.first.number
                : contact.phones.first.normalizedNumber.replaceAll(' ', '').replaceAll('-', '');
            log("phone number =>" + phoneNumber);
            Country? result = await setDestinationCountryByCallingCode(phoneNumber, fromContact: fromContact);
            await getMobileNetworks(); //cloase loading

            //display loading
            if (result != null) {
              InternationlPhoneValidator().update(selectedDestinationCountry!.value!.iso_code.toUpperCase());
              InternationlZipCodesValidator().update(selectedDestinationCountry!.value!.iso_code.toUpperCase());
              PhoneNumberInputFormatter(countryIso: selectedDestinationCountry!.value!.iso_code.toUpperCase());

              if (phoneNumber.startsWith("+")) {
                phoneNumberController.value.text = FormatPlainTextPhoneNumberByNumber()
                    .format(phoneNumber.replaceAll(' ', '').replaceAll('-', ''))
                    .substring(selectedDestinationCountry!.value!.calling_code!.length)
                    .replaceFirst(' ', '');
              } else if (phoneNumber.startsWith('0')) {
                phoneNumberController.value.text = FormatPlainTextPhoneNumberByNumber()
                    .format("+" + phoneNumber.replaceAll(' ', '').replaceAll('-', ''))
                    .substring(selectedDestinationCountry!.value!.calling_code!.length)
                    .replaceFirst(' ', '');
              } else {
                phoneNumberController.value.text = FormatPlainTextPhoneNumberByNumber()
                    .format("+" + phoneNumber.replaceAll(' ', '').replaceAll('-', ''))
                    .substring(selectedDestinationCountry!.value!.calling_code!.length)
                    .replaceFirst(' ', '');
              }

              //cloase loading

            }
          }
          if (Get.isOverlaysOpen) {
            Get.back();
          }
          if (phoneNumberController.value.text.isNotEmpty) {
            //Address Selection
            if (contact.addresses.isNotEmpty && (contact.addresses.length > 1)) {
              await openSelectAddressFromList(contact.addresses, fullName);
            } else if (contact.addresses.length == 1) {
              addressController.value.text = contact.addresses.first.street.replaceAll('\n', ' ');
              cityController.value.text = contact.addresses.first.city;
              zipCodeController.value.text = contact.addresses.first.postalCode;
              if (Get.isOverlaysOpen) {
                Get.back();
              }
            }
          }
        }

        phoneNumberController.update((val) {});
        phoneNumberKey.update((val) {});
        phoneNumberKey.value.currentState!.validate(); //
        zipCodeController.update((val) {});
        zipCodeKey.update((val) {});
        phoneNumberKey.value.currentState!.validate();
      } catch (error, stackTrace) {
        //TODO HANDLE IT
        //
        //
        if (Get.isOverlaysOpen) {
          Get.back();
        }
        Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
        log(error.toString());
      }
    }
  }

  //
  Future<void> askForUserConsent({bool fromContact = true}) async {
    Map<String, dynamic> data = json.decode(profileController.userInstance!.value.data ?? '{}');
    bool dataConsent;
    if (data != null) {
      dataConsent = (data.containsKey('contact_consent_result') ? (data['contact_consent_result'] as bool) : false);
    } else {
      dataConsent = false;
    }
    if (dataConsent == false) {
      //display consent dialog
      bool result = await openUserConsentDialog();
      if (result) {
        if (data.containsKey('contact_consent_result')) {
          data['contact_consent_result'] = result;
        } else {
          data.addIf(true, "contact_consent_result", result);
        }
        await handleImportContactFromDevice(fromContact: fromContact);
        profileController.userInstance!.value = profileController.userInstance!.value.copyWith(data: json.encode(data));
        AppUser().save(data: profileController.userInstance!.value.copyWith(data: json.encode(data)).toJson());
      }
    } else {
      bool isgranted = (await Permission.contacts.isGranted);
      if (isgranted == false) {
        bool result = await openUserConsentDialog();
        if (result) {
          if (data.containsKey('contact_consent_result')) {
            data['contact_consent_result'] = result;
          } else {
            data.addIf(true, "contact_consent_result", result);
          }
          await handleImportContactFromDevice(fromContact: fromContact);
          profileController.userInstance!.value = profileController.userInstance!.value.copyWith(data: json.encode(data));
          AppUser().save(data: profileController.userInstance!.value.copyWith(data: json.encode(data)).toJson());
        }
      } else {
        //just display or ask for permission
        handleImportContactFromDevice(fromContact: fromContact);
      }
    }
  }

  //
  Future<AddressBook> updateContact(AddressBook addressBook) async {
    try {
      var newAddress = addressBook.address!.copyWith(
          country: selectedDestinationCountry!.value!,
          city: cityController.value.text.trim(),
          postal_code: zipCodeController.value.text.trim(),
          state: '',
          address_line_1: addressController.value.text.trim(),
          address_line_2: '');
      await AppAddress().save(data: newAddress.toJson());
      //
      AddressBook newAddressBook = addressBook.copyWith(
        address: newAddress,
        account_number: accountNumberController.value.text.trim(),
        bank_swift_code: swiftController.value.text.trim(),
        first_name: fnameController.value.text.trim(),
        mobile_network: selectedMobileNetwork.value,
        gender: selectedGender.value,
        last_name: lnameController.value.text.trim(),
        phone_number: (calling_code_iso.value + phoneNumberController.value.text.replaceAll('-', '')),
      );
      await AppAddressBook().save(data: newAddressBook.toJson());
      //under below needs to be refactored

      //update in the contacts
      //
      //we resort for recents
      //
      await profileController.loadCompleteAddressBooks();
      profileController.sortGlobalTransactions(sort: true, fromSendMoney: false);

      await profileController.loadCompleteRecentAddressBooks();

      sendMoneyController.loadFiltredAddressBooks();
      profileController.sortContacts();
      profileController.sortRecentContacts();

      return newAddressBook;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log(error.toString());
      return addressBook;
    }
  }

  void clearData() {
    fnameController.value.text = '';
    lnameController.value.text = '';
    addressController.value.text = '';
    zipCodeController.value.text = '';
    cityController.value.text = '';
    accountNumberController.value.text = '';
    swiftController.value.text = '';
    selectedGender.value = null;
    phoneNumberController.value.text = '';
    //
    selectedDestinationCountry?.value = null;
  }

  Future<void> loadMoreTransactions(List transactions) async {
    isLoadingMoreTransaction.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if ((loadedTransactions.value + 3) >= transactions.length) {
      loadedTransactions.value = transactions.length;
    } else {
      loadedTransactions.value = loadedTransactions.value + 3;
    }
    isLoadingMoreTransaction.value = false;
  }

  Future<void> initTransactions(List transactions) async {
    //await Future.delayed(const Duration(seconds: 1));
    //  var filtredRecentAddressBooks = sendMoneyController.filtredRecentAddressBooks!.value;
    if (transactions.isEmpty) {
      loadedTransactions.value = 0;
    } else {
      if (transactions.length >= 6) {
        loadedTransactions.value = 6;
      } else {
        loadedTransactions.value = transactions.length;
      }
    }
  }
}
