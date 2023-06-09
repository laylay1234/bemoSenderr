import 'dart:async';
import 'dart:convert';
import 'dart:developer' as d;
import 'dart:ffi';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart' show Center, TextEditingController;
import 'package:flutter_amplifysdk/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_models/app_address.dart';
import 'package:mobileapp/app_models/app_country.dart';
import 'package:mobileapp/app_models/app_currency.dart';
import 'package:mobileapp/app_models/app_parameters.dart';
import 'package:mobileapp/app_models/app_transaction.dart';
import 'package:mobileapp/app_models/app_user.dart';
import 'package:mobileapp/constants/countries.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/entities/available_country_entity.dart';
//import 'package:http/http.dart';
import 'package:mobileapp/entities/exchange_data_entity.dart';
import 'package:mobileapp/entities/send_money_data_entity.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/views/home/contacts_views/edit_contact_view.dart';
import 'package:mobileapp/views/home/send_money_views/checkout_view.dart';
import 'package:mobileapp/views/home/send_money_views/congrats_view.dart';
import 'package:mobileapp/views/home/send_money_views/deposit_view.dart';
import 'package:mobileapp/views/home/send_money_views/select_receiver_views/select_receiver_view.dart';
import 'package:mobileapp/views/home/send_money_views/send_money_view.dart';
import 'package:mobileapp/views/home/send_money_views/transfer_reason_view.dart';
import 'package:mobileapp/widgets/common/rotated_spinner.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/dialogs/cancel_send_money_dialog_widget.dart';
import 'package:mobileapp/widgets/dialogs/email_has_been_sent_dialog_widget.dart';
import 'package:mobileapp/widgets/scaffolds/confirm_send_money_bottom_sheet.dart';
import 'package:mobileapp/widgets/snackbars/cannot_connect_service_snackbar.dart';
import 'package:mobileapp/widgets/snackbars/warning_snackbar.dart';
import 'package:statemachine/statemachine.dart';

import '../constants/format.dart';
import '../helpers/notifications_manager.dart';
import '../utils/error_alerts_utils.dart';
import '../views/home_view.dart';
import '../widgets/dialogs/transaction_details_dialog_widget.dart';
import 'profile_controller.dart';

class SendMoneyController extends GetxController {
  List<State> stack = [];
  Machine stateMachine = new Machine<String>(); //textfield controller
  Rx<TextEditingController> sendEditingController = TextEditingController().obs;
  Rx<TextEditingController> receiveEditingController = TextEditingController().obs;
  late String api;
  Rx<bool> isSwaped = false.obs;
  Rx<bool> loadingSendMoneyData = false.obs;
  //store wether this origin country is available to do send money tasks or not
  Rx<bool> originAbleToSend = true.obs;
  //checkbox rxBool used when bank transfer is selected
  Rx<bool> isBankInfoConfirmed = false.obs;
  //states
  Rx<bool> isNetworkAvailable = true.obs;
  late State loadingState;
  late State networkState;
  late State noNetworkState;
  late State networkLoadingState;
  late State sendMoneyDoneState;
  late State loggedInState;
  late State loggedOutState;
  late State confirmBottomSheetState;
  late State selectReceiverState;
  late State selectTransferReasonState;
  late State checkoutState;
  late State congratState;
  late State cancelState;
  late State depositState;

  //editing states
  late State editReceiverState;
  late State editAmountAndDilveryMethodState;

  //loading
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  //reactive variables used for the send money process
  //sending money parameters
  // Rx<ExchangeRate> selectedExchangeData = ExchangeRate().obs;
  //RxList<ExchangeRate> availableContries = <ExchangeRate>[].obs;
  //
  Rx<TransferReason?> transferReason = (null as TransferReason?).obs;
  Rx<TransferReason?> preTransferReason = (null as TransferReason?).obs;

  //available countries
  RxList<Country> countries = <Country>[].obs;
  RxList<Country>? availableCountries = <Country>[].obs;
  RxList<Currency> currencies = <Currency>[].obs;
  Rx<Country?> originCountry = (null as Country?).obs;
  Rx<Currency?> originCurrency = (null as Currency?).obs;
  Rx<Country>? selectedDestinationCountry;
  Rx<Country>? selectedTempoCountry;
  Rx<Currency>? destinationCurrency;
  Rx<bool> fromContact = false.obs;
  //exchange rate
  Rx<ExchangeRate> exchangeRate = ExchangeRate().obs;
  RxList<DeliveryMethod> deliveryMethods = <DeliveryMethod>[].obs;
  //
  Rx<DeliveryMethod> selectedCollectMethod = DeliveryMethod().obs;
  //calculation
  Rx<double> receiveAmount = 0.0.obs;
  Rx<double> totalAmount = 0.0.obs;
  Rx<String> minValue = ''.obs;
  //addressBooks
  RxList<AddressBook>? filtredAddressBooks = <AddressBook>[].obs;
  RxList<AddressBook>? filtredRecentAddressBooks = <AddressBook>[].obs;
  Rx<bool> loadingTransactionData = false.obs;
  //select reciever STUFF
  Rx<int> selectedTab = 0.obs;
  //do not remove the "Unnecessary" cast :)
  Rx<AddressBook?> selectedReceiver = (null as AddressBook?).obs;
  //send money button
  // Rx<bool> enableSendMoneyButton = true.obs;

  AuthController get authController {
    return Get.find<AuthController>();
  }

  ProfileController get profileController {
    return Get.find<ProfileController>();
  }

  OriginController get originController {
    return Get.find<OriginController>();
  }

  ContactsController get contactsController {
    return Get.find<ContactsController>();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    api = dotenv.env['API_URL']!;

    networkLoadingState = stateMachine.newState('networkLoadingState')
      ..onEntry(() async {
        // this.isNetworkAvailable = true;
        //await getRateTiersCountry();
        loadAndSetSendMoneyData();
        // set the available countries and the origin country

        //calculateTotal();
        networkState.enter();
      });
    checkoutState = stateMachine.newState('checkoutState')
      ..onEntry(() {
        //
        addToStack(checkoutState);
      });
    congratState = stateMachine.newState('congratState')
      ..onEntry(() {
        //
        addToStack(checkoutState);
        profileController.loadData();
      });
    depositState = stateMachine.newState('depositState')
      ..onEntry(() {
        //
        addToStack(depositState);
      });
    loggedOutState = stateMachine.newState('loggedOutState')
      ..onEntry(() {
        //
        countries.value = [];
        transferReason.value = null;
        currencies.value = [];
        availableCountries!.value = [];
      });
    selectTransferReasonState = stateMachine.newState('selectTransferReasonState')
      ..onEntry(() {
        //
        addToStack(selectTransferReasonState);
      });
    confirmBottomSheetState = stateMachine.newState('confirmBottomSheetState')
      ..onEntry(() {
        //
        addToStack(confirmBottomSheetState);
      });
    cancelState = stateMachine.newState('cancelState')
      ..onEntry(() {
        //
        stack.clear();
      });
    editReceiverState = stateMachine.newState('editReceiverState')
      ..onEntry(() {
        //
        addToStack(editReceiverState);
      });
    selectReceiverState = stateMachine.newState('selectReceiverState')
      ..onEntry(() {
        //
        addToStack(selectReceiverState);
        loadFiltredAddressBooks();
      });
    editAmountAndDilveryMethodState = stateMachine.newState('editAmountAndDilveryMethodState')
      ..onEntry(() {
        //
        addToStack(editAmountAndDilveryMethodState);
      });

    loggedInState = stateMachine.newState('loggedInState')
      ..onEntry(() async {
        await loadAndSetSendMoneyData();

        Get.offAllNamed(HomeView.id);

        sendEmailVerificationAfterSignUp();
        //authController.validateVersion();
        //start observing changes
        _subscribeOnUpdateCountry();
        _subscribeOnCreateCurrency();
        _subscribeOnUpdateCurrency();
        _subscribeOnCreateCurrency();

        //TODO REFACTOR THIS
        FirebaseMessaging.instance.getInitialMessage().then((message) {
          if (message != null) {
            if (message.data['type'] == 'transaction') {
              String globalTransactionId = message.data['transaction'] ?? '';
              String status = message.data['status'] ?? '';
              GlobalTransactionStatus globalTransactionStatus =
                  GlobalTransactionStatus.values.where((e) => e.name.toString().toLowerCase().contains(status.toString().toLowerCase())).first;
              //
              //
              //log("handleTransactionNotificationEvent " + globalTransactionId);
              //
              //
              GlobalTransaction globalTransaction =
                  (profileController.globalTransactions!.where((e) => e.id == globalTransactionId).first).copyWith(status: globalTransactionStatus);

              if (Get.currentRoute == HomeView.id) {
                profileController.currentIndex.value = 1;
                profileController.currentPage.value = profileController.views[1];
                openTransactionDetailsDialog(transaction: globalTransaction);
              } else {
                Get.offAllNamed(HomeView.id);
                profileController.currentIndex.value = 1;
                profileController.currentPage.value = profileController.views[1];
                openTransactionDetailsDialog(transaction: globalTransaction);
              }
            } else if (message.data['type'] == 'user_tier') {
              if (Get.currentRoute == HomeView.id) {
                profileController.currentIndex.value = 3;
                profileController.currentPage.value = profileController.views[3];
              } else {
                Get.offAllNamed(HomeView.id);
                profileController.currentIndex.value = 3;
                profileController.currentPage.value = profileController.views[3];
              }
            }
          } else {
            log('its not from the background :/');
          }
        });
        //stack.add(loggedInState);
      });
    networkState = stateMachine.newState('networkState')
      ..onEntry(() {
        isNetworkAvailable.value = true;
        update();
      });

    noNetworkState = stateMachine.newState('noNetworkState')
      ..onEntry(() {
        isNetworkAvailable.value = false;
        if ((Get.currentRoute == SendMoneyView.id) ||
            (Get.currentRoute == SelectReceiverView.id) ||
            (Get.currentRoute == TransferReasonView.id) ||
            (Get.currentRoute == CheckOutView.id)) {
          //Get.offNamed(HomeView.id);
        }
        startCannotConnectToService();
        //  update();
      });
    sendMoneyDoneState = stateMachine.newState('sendMoneyDoneState')
      ..onEntry(() {
        //
      });
    connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      // Got a new connectivity status!
      dbg("connectivity result " + result.index.toString(), isError: true);
      if ((result == ConnectivityResult.wifi) || (result == ConnectivityResult.mobile) || (result == ConnectivityResult.ethernet)) {
        networkLoadingState.enter();
      } else {
        noNetworkState.enter();
      }
    });
    //
  }

  void _subscribeOnUpdateCountry() {
    var _subscriptionRequest = ModelSubscriptions.onUpdate(Country.classType);
    var _operation = Amplify.API
        .subscribe(
      _subscriptionRequest,
      onEstablished: () => print('Updated Country Subscription established'),
    )
        .handleError((error) {
      dbg('Error in Updated Country subscription stream: $error');
    });
    _operation.listen(
      (event) {
        dbg('Received Updated user ' + event.data.toString());
        try {
          if (event.data != null) {
            updateCountriesLocally(event.data!);
          }
        } catch (error, stackTrace) {
          Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

          //log("from observe " + e.toString());
        }
      },
      onError: (Object e) => dbg('Error in Updated Country subscription stream: $e'),
    );
  }

  void _subscribeOnCreateCountry() {
    var _subscriptionRequest = ModelSubscriptions.onCreate(Country.classType);
    var _operation = Amplify.API
        .subscribe(
      _subscriptionRequest,
      onEstablished: () => print('Updated Country Subscription established'),
    )
        .handleError((error) {
      dbg('Error in Updated Country subscription stream: $error');
    });
    _operation.listen(
      (event) {
        dbg('Received Updated user ' + event.data.toString());
        try {
          if (event.data != null) {
            addCountriesLocally(event.data!);
          }
        } catch (error, stackTrace) {
          Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

          // log("from observe " + e.toString());
        }
      },
      onError: (Object e) => dbg('Error in Updated Country subscription stream: $e'),
    );
  }

  void _subscribeOnUpdateCurrency() {
    var _subscriptionRequest = ModelSubscriptions.onUpdate(Currency.classType);
    var _operation = Amplify.API
        .subscribe(
      _subscriptionRequest,
      onEstablished: () => print('Updated Currency Subscription established'),
    )
        .handleError((error) {
      dbg('Error in Updated Currency subscription stream: $error');
    });
    _operation.listen(
      (event) {
        dbg('Received Updated Currency ' + event.data.toString());
        try {
          if (event.data != null) {
            updateCurrenciesLocally(event.data!);
          }
        } catch (error, stackTrace) {
          Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
        }
      },
      onError: (Object e) => dbg('Error in Updated Currency subscription stream: $e'),
    );
  }

  void _subscribeOnCreateCurrency() {
    var _subscriptionRequest = ModelSubscriptions.onCreate(Currency.classType);
    var _operation = Amplify.API
        .subscribe(
      _subscriptionRequest,
      onEstablished: () => print('Updated Currency Subscription established'),
    )
        .handleError((error) {
      dbg('Error in Updated Currency subscription stream: $error');
    });
    _operation.listen(
      (event) {
        dbg('Received Updated Currency ' + event.data.toString());
        try {
          if (event.data != null) {
            addCurrenciesLocally(event.data!);
          }
        } catch (error, stackTrace) {
          Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
        }
      },
      onError: (Object e) => dbg('Error in Updated Currency subscription stream: $e'),
    );
  }

  void getDefaultValueForOriginAmount() {
    Map<String, dynamic> appSettings = profileController.appSettings as Map<String, dynamic>;
    var appData = appSettings['minTransactionValue'] as Map<String, dynamic>;
    if (appData.containsKey(originController.origin_country_iso.toUpperCase())) {
      minValue.value = appData[originController.origin_country_iso.toUpperCase()];
    } else {
      minValue.value = appData['default'];
    }
    double minValueStandard = double.parse(minValue.value);
  }

  void loadFiltredAddressBooks() {
    filtredAddressBooks!.value = profileController.addressBooks!.where((e) => e.address!.country!.id == selectedDestinationCountry!.value.id).toList();
    filtredAddressBooks!.sort(((a, b) {
      if (a.first_name.compareTo(b.first_name) == 0) {
        return a.last_name.compareTo(b.last_name);
      }
      return a.first_name.compareTo(b.first_name);
    }));
    //this sort is causing error in selectReceiverState enter
    /*
   filtredAddressBooks!.sort((a, b) {
      return a.updatedAt!.compareTo(b.createdAt!);
      // return a.createdAt!.compareTo(b.createdAt!);
    });*/
    filtredRecentAddressBooks!.value =
        profileController.recentAddressBooks!.where((e) => e.address!.country!.id == selectedDestinationCountry!.value.id).toList();
    filtredRecentAddressBooks!.sort(((a, b) {
      if (a.first_name.compareTo(b.first_name) == 0) {
        return a.last_name.compareTo(b.last_name);
      }
      return a.first_name.compareTo(b.first_name);
    }));
  }

  Future<void> updateCountriesLocally(Country item) async {
    //availableCountries!.value = items.where((e) => e.active).toList();
    countries.value = countries.value.where((e) => e.id != item.id).toList();
    countries.add(item);
    getDestinationCountriesByOriginCountry();
  }

  Future<void> addCountriesLocally(Country item) async {
    //availableCountries!.value = items.where((e) => e.active).toList();
    countries.add(item);
    getDestinationCountriesByOriginCountry();
  }

  Future<void> updateCurrenciesLocally(Currency item) async {
    //availableCountries!.value = items.where((e) => e.active).toList();
    currencies.value = currencies.value.where((e) => e.id != item.id).toList();
    currencies.add(item);
  }

  Future<void> addCurrenciesLocally(Currency item) async {
    //availableCountries!.value = items.where((e) => e.active).toList();
    currencies.add(item);
  }

  Future<void> sendEmailVerificationAfterSignUp() async {
    try {
      if (authController.isSignUpFlow.value) {
        //
        profileController.sendConfirmationEmail();
        //we display the dialog to notify the user that the email has been sent
        openEmailHasBeenSentDialog();

        //
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
    }
  }

  Future<void> loadAndSetSendMoneyData() async {
    try {
      await loadAndSetCurrencies();
      await loadAndSetCountries();
      //
      //d.log(profileController.userInstance!.toJson().toString());
      if (profileController.userInstance!.value.profile == null) {
        return;
      }
      //
      //
      if (profileController.userInstance!.value.profile!.address!.country == null) {
        Country origin_country = countries.firstWhere((element) => element.iso_code.toLowerCase() == originController.origin_country_iso.toLowerCase());
        Address address = profileController.userInstance!.value.profile!.address!.copyWith(country: origin_country);
        AppAddress().save(data: address.toJson());
        User user = profileController.userInstance!.value.copyWith(profile: profileController.userInstance!.value.profile!.copyWith(address: address));
        profileController.userInstance!.value = user;
        AppUser().save(data: user.toJson());
      }
      //set the currencies for the origin and destination
      await getDestinationCountriesByOriginCountry();

      //sendEditingController.text = '1';
      //
      //
      //if originAbleToSend.Value is false this means the origin country is not available or active
      //or there's no destination available for this origin country
      if (originAbleToSend.value) {
        if (sendEditingController.value.text.isEmpty || sendEditingController.value.text == minValue.value) {
          await getExchangeRate(minValue.value);
        } else {
          log('heere');
          await getExchangeRate(sendEditingController.value.text);
        }
        calculateTotal();
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("loadAndSetSendMoneyData:" + error.toString());
    }
  }

  Future<bool> loadAndSetCountries() async {
    try {
      loadingSendMoneyData.value = true;
      countries.value = (await AppCountry().listCountries()) ?? [];
      //getDestinationCountriesByOriginCountry
      //
      // var available_origin_countries =
      //     countries.where((e) => (e.iso_code.toLowerCase() != originController.origin_country_iso.toLowerCase()) && (e.enabled_as_origin)).toList();
      //
      //log(countries.length.toString() + "heeree");
      //log(originController.origin_country_iso.toLowerCase());
      countries.map((e) => log(e.toJson()));
      originCountry.value =
          countries.where((e) => (e.iso_code.toLowerCase().contains(originController.origin_country_iso.toLowerCase()) && (e.enabled_as_origin))).first;
      return true;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("from loadAndSetCountries " + error.toString());
      return false;
    }
  }

  Future<bool> loadAndSetCurrencies() async {
    try {
      currencies.value = (await AppCurrency().listCurrencies()) ?? [];
      //we get the currency iso by the country iso (from the ds) and use the countries_data
      //log(originController.origin_country_iso.value);
      Map<String, dynamic> country_data =
          countries_data.where((e) => e['isoAlpha2'].toString().toLowerCase().contains(originController.origin_country_iso.value.toLowerCase())).first;
      String origin_currency = country_data['currency']['code'].toString().toLowerCase();
      originCurrency.value = currencies.where((e) => e.iso_code.toLowerCase().contains(origin_currency.toLowerCase())).toList().first;
      //destinationCurrency = currencies.where((e) => e..toLowerCase().contains(selectedDestinationCountry!.value.)).toList().first.obs;
      loadingSendMoneyData.value = false;
      return true;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      loadingSendMoneyData.value = false;
      log("loadAndSetCurrencies " + error.toString());
      //
      // loadAndSetCurrencies();
      return false;
    }
  }
  //confirm send money and show bottom sheet

  //note origin_code is canada
  //it need to be more dynamic and handles all origins
  //Example we put the origin country in the env variables
  //
  double handleAmountInput(String amount) {
    try {
      // double amount_sent;
      if (amount.isEmpty || (amount == '0')) {
        return double.parse(minValue.value);
      }
      if (RegExp(r'(\s|[0-9]|e|π)$').hasMatch(amount)) {
        return double.parse(amount);
      } else {
        return 1;
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("handleAmountInput: " + error.toString());
      return 0;
    }
  }

  Future<ExchangeRate?> getExchangeRate(String amount) async {
    loadingTransactionData.value = true;

    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    //assing non-valid exchangeRate object
    exchangeRate.value = ExchangeRate();
    final String token = await authController.getToken();
    final double amount_sent = handleAmountInput(amount);
    //log(selectedDestinationCountry!.value.iso_code);
    if (selectedDestinationCountry == null) {
      return null;
    }
    try {
      // log("origin is:" + originCountry.value!.iso_code);
      final response = await getConnect.post('$api/get-charges-by-amount', {
        'origin_country': originCountry.value!.iso_code,
        'amount': amount_sent,
        'destination_country': selectedDestinationCountry!.value.iso_code,
      }, headers: {
        'Authorization': 'bearer $token',
        'Content-Type': 'application/json',
      });
      ExchangeRate? tmp;
      if (response.statusCode == 200) {
        log("respons exchange rate:" + response.body.toString());
        final String receivedJson = response.bodyString!;
        final Map<String, dynamic> data = json.decode(receivedJson);
        tmp = ExchangeRate.fromJson(data['response']);
        exchangeRate.value = tmp;
        deliveryMethods.value = tmp.delivery_methods ?? [];
        // if ((!selectedCollectMethod.value.isValid())) {
        //   selectedCollectMethod.value = exchangeRate.value.delivery_methods!.where((element) => element.active!.toLowerCase().contains('true')).first;
        // }
        if (!((selectedCollectMethod.value.isValid()) &&
            (deliveryMethods
                .where((e) => ((e.code!.toUpperCase() == selectedCollectMethod.value.code!.toUpperCase()) && (e.active!.toLowerCase().contains('true'))))
                .isNotEmpty))) {
          selectedCollectMethod.value = deliveryMethods.firstWhere((element) => element.active!.toLowerCase().contains('true'));
        } else {
          selectedCollectMethod.value = deliveryMethods
              .where((e) => ((e.code!.toUpperCase() == selectedCollectMethod.value.code!.toUpperCase()) && (e.active!.toLowerCase().contains('true'))))
              .first;
        }

        //here we put the min value
        if (isSwaped.value) {
          // sendEditingController.value.text = amount;
        }

        //TODO refactor and find better way to assing/update the destination currenecy
        if (destinationCurrency != null) {
          destinationCurrency!.value = currencies.where((e) => e.id == exchangeRate.value.destination_currency_uuid).toList().first;
          //destinationCurrency!.refresh();

        } else {
          destinationCurrency = currencies.where((e) => e.id == exchangeRate.value.destination_currency_uuid).toList().first.obs;
        }
      }
      return tmp;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      if (error == FormatException) {
        loadingTransactionData.value = false;
      }
      log("invalid" + amount.toString());
      log("heere exchange rate " + error.toString());
      dbg("heere exchange rate " + error.toString(), isError: true);
    }
    return null;
  }

  Future<void> calculateTotal() async {
    try {
      if (isSwaped.value == false) {
        if (sendEditingController.value.text.isEmpty) {
          receiveAmount.value = 0.00;
          totalAmount.value = 0.00;
          receiveEditingController.value.text = "0.00";

          return;
        }
      } else {
        // log('is empty? =>' + receiveEditingController.value.text.isEmpty.toString());
        if (receiveEditingController.value.text.isEmpty) {
          receiveAmount.value = 0.00;
          totalAmount.value = 0.00;
          sendEditingController.value.text = "0.00";
          return;
        }
      }

      if (isSwaped.value == false) {
        await getExchangeRate(sendEditingController.value.text);
        if ((double.parse(sendEditingController.value.text) < double.parse(exchangeRate.value.max!)) &&
            (double.parse(sendEditingController.value.text) >= double.parse(exchangeRate.value.min!))) {
          double converted = double.parse(sendEditingController.value.text) * double.parse(exchangeRate.value.rate!);
          receiveAmount.value = converted;
          double priceWithFees = double.parse(sendEditingController.value.text) + double.parse(selectedCollectMethod.value.fee!);
          totalAmount.value = priceWithFees;
          receiveEditingController.value.text = converted.toStringAsFixed(AMOUNT_FORMAT_DECIMALS);
          //receiveAmount.value
        } else {
          log(exchangeRate.value.max.toString());
          await getExchangeRate(sendEditingController.value.text);
          //calculateTotal();
        }
      } else {
        try {
          await getExchangeRate(
              (sendEditingController.value.text.isEmpty || sendEditingController.value.text.startsWith('0')) ? '1' : sendEditingController.value.text);
          double converted = double.parse(receiveEditingController.value.text) / double.parse(exchangeRate.value.rate!);
          if (converted < 1) {
            //  log('is small? =>' + converted.toString());

            await getExchangeRate(converted.toString());
            double priceWithFees = converted + double.parse(selectedCollectMethod.value.fee!);
            receiveAmount.value = converted;
            totalAmount.value = priceWithFees;
            sendEditingController.value = TextEditingController(text: converted.toStringAsFixed(AMOUNT_FORMAT_DECIMALS));
            return;
          }
          await getExchangeRate(converted.toString());
          // log('is bigger? =>' + converted.toString());
          // log('value? =>' + receiveEditingController.value.text.toString());
          if (converted < double.parse(exchangeRate.value.max!) && converted >= double.parse(exchangeRate.value.min!)) {
            // log('is here?');
            double priceWithFees = converted + double.parse(selectedCollectMethod.value.fee!);
            receiveAmount.value = converted;
            totalAmount.value = priceWithFees;
            sendEditingController.value = TextEditingController(text: converted.toStringAsFixed(AMOUNT_FORMAT_DECIMALS));
          } else {
            //calculateTotal();
            double priceWithFees = converted + double.parse(selectedCollectMethod.value.fee!);
            receiveAmount.value = converted;
            totalAmount.value = priceWithFees;
            sendEditingController.value = TextEditingController(text: converted.toStringAsFixed(AMOUNT_FORMAT_DECIMALS));
          }
          return;
        } catch (error, stackTrace) {
          Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
          return;
        }
      }
    } catch (e, stackTrace) {
      Utils().sendEmail(message: '${e.toString()}\n${stackTrace.toString()}');

      log("calculateTotal" + e.toString());
    }
  }

  Future<void> sendMoneyApiCall(GlobalTransaction globalTransaction) async {
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    SendMoneyData sendMoneyData =
        SendMoneyData(ip: '', globalTransaction: globalTransaction, exchangeRate: exchangeRate.value, user: profileController.userInstance!.value);

    d.log(profileController.userInstance!.toJson().toString());
    try {
      var token = await authController.getToken();
      //log(token);
      var response = await getConnect.post('$api/send-money/', sendMoneyData.toJson(), headers: {
        'Authorization': 'Bearer $token', //sign u
        'Content-Type': 'application/json',
      });
      log(response.statusCode.toString());
      log(sendMoneyData.exchangeRate!.toJson().toString());
      if (response.isOk) {
        sendMoneyDoneState.enter();
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("from sendMoneyApiCall" + error.toString());
    }
  }

  Future<void> sendMoneyOperation() async {
    try {
      Parameters parameters = Parameters(
          amount_origin: sendEditingController.value.text,
          amount_destination: receiveEditingController.value.text,
          total: totalAmount.value.toString(),
          applicable_rate: exchangeRate.value.rate!,
          transfer_reason: transferReason.value!,
          origin_country: originCountry.value,
          origin_countryID: originCountry.value!.id,
          destination_country: selectedDestinationCountry!.value,
          destination_countryID: selectedDestinationCountry!.value.id,
          currency_origin: originCurrency.value,
          currency_originID: originCurrency.value!.id,
          currency_destination: destinationCurrency!.value,
          currency_destinationID: destinationCurrency!.value.id,
          collect_method_fee: selectedCollectMethod.value.fee!,
          collect_method: selectedCollectMethod.value.code,
          funding_method: 'INTERAC');
      //
      Parameters? saveParameters = await AppParameters().save(data: parameters.toJson());
      if (saveParameters == null) {
        log('saveParameters is null');
      }
      //await Future.delayed(Duration(seconds: 2));
      GlobalTransaction globalTransaction = GlobalTransaction(
          status: GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS,
          user: profileController.userInstance!.value,
          receiver: selectedReceiver.value!,
          parameters: parameters,
          parametersID: saveParameters!.id,
          funding_date: TemporalDateTime.now(),
          collect_date: TemporalDateTime.now(),
          created_at: TemporalDateTime.now());
      //
      //

      var tmp = await AppTransaction().save(data: globalTransaction.toJson());
      globalTransaction = globalTransaction.copyWith(id: tmp!.id);
      await sendMoneyApiCall(globalTransaction);
      //
      //
      profileController.globalTransactions!.add(globalTransaction);
      // profileController.sortGlobalTransactions(sort: true);
      dbg('send money done');
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("from send money" + error.toString());
      log(error.toString());
      dbg(error.toString());
    }
  }

  void addToStack(State state) {
    if (stack.isNotEmpty) {
      if (stack.last != state) {
        stack.add(state);
      } else {
        stack.removeLast();
      }
    } else {
      stack.add(state);
    }
  }

  void prevStep() {
    //log('clicked');
    if (Get.currentRoute == SendMoneyView.id) {
      openCancelSendMoneyDialog();
      clearSendMoneyData();
    } else {
      if (stack.isNotEmpty) {
        State state = stack.last;
        state.enter();
        Get.back();
      } else {
        Get.back();
      }
    }
  }

  void clearSendMoneyData() {
    selectedReceiver.value = null;
    selectedReceiver.value = null;
    transferReason.value = null;
    profileController.searchResult!.value = [];
    profileController.enableSearch.value = false;
  }

  void nextStep() async {
    if (getCurrentState() == editReceiverState) {
      //
      Get.offNamed(SelectReceiverView.id);
    } else if (getCurrentState() == editAmountAndDilveryMethodState) {
      Get.toNamed(SendMoneyView.id);
    } else if (getCurrentState() == confirmBottomSheetState) {
      confirmSendMoneyBottomSheet();
    } else if (getCurrentState() == selectReceiverState) {
      //
      // log(selectedReceiver.value != null);
      if (fromContact.value) {
        //log("from contact");
        // selectReceiverState.enter();
        try {
          contactsController.setInitialValuesForUpdate(selectedReceiver.value!);
          InternationlPhoneValidator().update(selectedDestinationCountry!.value.iso_code.toUpperCase());
          InternationlZipCodesValidator().update(selectedDestinationCountry!.value.iso_code.toUpperCase());
          PhoneNumberInputFormatter(countryIso: selectedDestinationCountry!.value.iso_code.toUpperCase());

          await contactsController.setInitialMobileNetwork(selectedReceiver.value!);

          Get.back();
        } catch (error, stackTrace) {
          Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
          dbg(error.toString(), isError: true);
          Get.back();
        }
        await missingInformationChecker().then((value) {
          if (!value) {
            Get.toNamed(TransferReasonView.id);
          }
        });
      } else {
        // selectReceiverState.enter();
        //log("to select receiver");

        Get.toNamed(SelectReceiverView.id, preventDuplicates: false);
      }
    } else if (getCurrentState() == selectTransferReasonState) {
      Get.toNamed(TransferReasonView.id);
      //Get.toNamed(CheckOutView.id);
    } else if (getCurrentState() == checkoutState) {
      Get.toNamed(CheckOutView.id);
    } else if (getCurrentState() == cancelState) {
      Get.offAllNamed(HomeView.id);
    } else if (getCurrentState() == congratState) {
      Get.toNamed(CongratsView.id);
    } else if (getCurrentState() == depositState) {
      //
      Get.toNamed(DepositView.id);
    } else if (getCurrentState() == sendMoneyDoneState) {
      //Get.offNamed(HomeView.id);
      Get.offAllNamed(HomeView.id);
      profileController.searchResult!.value = [];
      profileController.enableSearch.value = false;

      loadAndSetSendMoneyData();
      profileController.sortGlobalTransactions(sort: true, call: false, fromSendMoney: true);
    }
  }

  Future<bool> missingInformationChecker() async {
    try {
      if (selectedCollectMethod.value.code!.toLowerCase().contains('bank')) {
        //parameters: {'is_swift_account_required': 'true'} ,
        if (selectedReceiver.value!.account_number == null) {
          //  selectReceiverState.enter();
          //   nextStep();
          Get.toNamed(EditContactView.id, parameters: {"is_swift_account_required": "true"});

          return true;
        } else if (selectedReceiver.value!.account_number!.isEmpty) {
          //  selectReceiverState.enter();
          //  nextStep();
          Get.toNamed(EditContactView.id, parameters: {"is_swift_account_required": "true"});

          return true;
        } else if (selectedReceiver.value!.bank_swift_code == null) {
          //   selectReceiverState.enter();
          //  nextStep();
          Get.toNamed(EditContactView.id, parameters: {"is_swift_account_required": "true"});

          return true;
        } else if (selectedReceiver.value!.bank_swift_code!.isEmpty) {
          //   selectReceiverState.enter();
          // nextStep();
          Get.toNamed(EditContactView.id, parameters: {"is_swift_account_required": "true"});

          return true;
        } else {
          return false;
        }
      } else if (selectedCollectMethod.value.code!.toLowerCase().contains('mobile')) {
        if (selectedReceiver.value!.mobile_network == null) {
          Get.toNamed(EditContactView.id, parameters: {"is_mobile_network_required": "true"});

          return true;
        } else if (selectedReceiver.value!.mobile_network!.isEmpty) {
          Get.toNamed(EditContactView.id, parameters: {"is_mobile_network_required": "true"});

          return true;
        } else {
          return false;
        }
      }
      return false;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      return false;
    }
  }

  Future<void> sendMoneyAgain(GlobalTransaction transaction) async {
    selectedDestinationCountry!.value = transaction.parameters!.destination_country!;
    selectedDestinationCountry!.update((val) {});
    //
    destinationCurrency!.value = transaction.parameters!.currency_destination!;
    selectedReceiver.value = transaction.receiver;
    transferReason.value = transaction.parameters!.transfer_reason;
    sendEditingController.value.text = transaction.parameters!.amount_origin;
    if (exchangeRate.value.delivery_methods!.where((e) => e.code!.toUpperCase() == transaction.parameters!.collect_method!.toUpperCase()).isNotEmpty) {
      selectedCollectMethod.value =
          exchangeRate.value.delivery_methods!.where((e) => e.code!.toUpperCase() == transaction.parameters!.collect_method!.toUpperCase()).first;
    } else {
      selectedCollectMethod.value = exchangeRate.value.delivery_methods!.first;
    }
    await getExchangeRate(transaction.parameters!.amount_origin);
    //   selectedDestinationCountry!.value = transaction.parameters!.destination_country!;

    calculateTotal();
  }

  //TODO verify and validate this
  Future<bool> cancelTransactionApiCall(GlobalTransaction globalTransaction) async {
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    try {
      var token = await authController.getToken();
      //log(token);
      log(globalTransaction.id);
      var response = await getConnect.post('$api/cancel-global-transaction', {
        'status': GlobalTransactionStatus.CANCELLED.name,
        'uuid': globalTransaction.id
      }, headers: {
        'Authorization': 'Bearer $token', //sign u
        'Content-Type': 'application/json',
      });
      //log(response.statusCode.toString());
      if (response.isOk) {
        // log('true');
        // sendMoneyDoneState.enter();
        return true;
      }
      return false;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log(error.toString());

      return false;
    }
  }

  State? getCurrentState() {
    return stateMachine.current;
  }

  Future<void> cancelTransaction(GlobalTransaction transaction) async {
    //api call to cancel the transaction
    var result = await cancelTransactionApiCall(transaction);

    if (result) {
      //update the transaction status from the variables that holds transactions data
      GlobalTransaction oldTransaction = profileController.globalTransactions!.where((e) => e.id == transaction.id).first;
      GlobalTransaction newTransaction = oldTransaction.copyWith(status: GlobalTransactionStatus.CANCELLED);
      //make sure it gets saved locally and in the cloud
      // await AppTransaction().save(data: newTransaction.toJson());
      List<GlobalTransaction> oldTransactions = profileController.globalTransactions!.where((e) => e.id != transaction.id).toList();
      oldTransactions.add(newTransaction);
      profileController.globalTransactions!.value = oldTransactions;
      //get the data from the cloud , not neccessery
      //profileController.recentAddressBooks!.value = (profileController.recentAddressBooks!.where((e) => e.id != transaction.id).toList());

      //await cancelTransactionApiCall(transaction);
      profileController.sortGlobalTransactions(fromSendMoney: true);
    } else {
      //TODO handle not able to cancel
      //display a snackbar

    }
  }

  void resetSendMoneyData() {
    selectedReceiver.value = null;
    transferReason.value = null;
    fromContact.value = false;
  }

  Future<void> getDestinationCountriesByOriginCountry() async {
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    try {
      var token = await authController.getToken();
      var response = await getConnect.post('$api/get-destination-countries', {
        'origin_country': originCountry.value!.iso_code
      }, headers: {
        'Authorization': 'Bearer $token', //sign u
        'Content-Type': 'application/json',
      });
      log(response.statusCode);
      if (response.statusCode == 200) {
        //log('here');
        //Map<String, dynamic> data = json.decode(response.bodyString!);
        //log('here');
        List<AvailableCountry> result = List.from(response.body['response']).map((e) => AvailableCountry.fromJson(e)).toList();
        List<Country> availableCountriesResult = [];
        for (var r in result) {
          if (countries.where((p) => p.iso_code.toLowerCase().contains(r.iso_code!.toLowerCase())).isNotEmpty) {
            availableCountriesResult.add(countries.where((p) => p.iso_code.toLowerCase().contains(r.iso_code!.toLowerCase())).first);
          }
        }

        availableCountries!.value = availableCountriesResult.where((e) => e.enabled_as_destination).toList();
        originAbleToSend.value = true;
        if (availableCountriesResult.where((e) => (e.active && (e.iso_code.toLowerCase().contains('ma')))).isNotEmpty) {
          selectedDestinationCountry = availableCountriesResult.where((e) => (e.active && (e.iso_code.toLowerCase().contains('ma')))).first.obs;
          selectedDestinationCountry!.value = availableCountriesResult.where((e) => (e.active && (e.iso_code.toLowerCase().contains('ma')))).first;
        } else {
          selectedDestinationCountry = availableCountriesResult.where((e) => (e.active)).first.obs;
          selectedDestinationCountry!.value = availableCountriesResult.where((e) => e.active).first;
        }

        profileController.sortGlobalTransactions(sort: true, fromSendMoney: false);

        log("getDestinationCountriesByOriginCountry done =>" + (response.bodyString ?? ''));

        sortAvailableCountriesByAvailability();
      } else if (response.statusCode == 404) {
        log("getDestinationCountriesByOriginCountry 404 =>" + (response.bodyString ?? ''));

        //
        startWarningSnackbar();
      } else {
        log("getDestinationCountriesByOriginCountry  =>" + (response.bodyString ?? ''));

        //  availableCountries!.value = [];
        //  originAbleToSend.value = false;
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("getDestinationCountriesByOriginCountry =>" + error.toString());
      //  availableCountries!.value = [];
      //  originAbleToSend.value = false;
    }
  }

  //for loading filtred address books
  //All
  Rx<bool> isLoadingMoreFiltredAddressBooks = false.obs;
  Rx<int> loadedAddressFiltredBooksItems = 0.obs;
  //recents
  Rx<bool> isLoadingMoreFiltredRecentAddressBooks = false.obs;
  Rx<int> loadedAddressFiltredRecentBooksItems = 0.obs;

  Future<void> loadMoreAddressBooks() async {
    isLoadingMoreFiltredAddressBooks.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if ((loadedAddressFiltredBooksItems.value + 3) >= filtredAddressBooks!.length) {
      loadedAddressFiltredBooksItems.value = filtredAddressBooks!.length;
    } else {
      loadedAddressFiltredBooksItems.value = loadedAddressFiltredBooksItems.value + 3;
    }
    isLoadingMoreFiltredAddressBooks.value = false;
  }

  Future<void> loadMoreRecentAddressBooks() async {
    isLoadingMoreFiltredRecentAddressBooks.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if ((loadedAddressFiltredRecentBooksItems.value + 3) >= filtredRecentAddressBooks!.length) {
      loadedAddressFiltredRecentBooksItems.value = filtredRecentAddressBooks!.length;
    } else {
      loadedAddressFiltredRecentBooksItems.value = loadedAddressFiltredRecentBooksItems.value + 3;
    }
    isLoadingMoreFiltredRecentAddressBooks.value = false;
  }

  Future<void> initFilteredRecentAddressBooks() async {
    //await Future.delayed(const Duration(seconds: 1));
    //  var filtredRecentAddressBooks = sendMoneyController.filtredRecentAddressBooks!.value;
    if (filtredRecentAddressBooks!.isEmpty) {
      loadedAddressFiltredRecentBooksItems.value = 0;
    } else {
      if (filtredRecentAddressBooks!.length >= 6) {
        loadedAddressFiltredRecentBooksItems.value = 6;
      } else {
        loadedAddressFiltredRecentBooksItems.value = filtredRecentAddressBooks!.length;
      }
    }
  }

  Future<void> initFilteredAddressBooks() async {
    //await Future.delayed(const Duration(seconds: 1));
    //  var filtredRecentAddressBooks = sendMoneyController.filtredRecentAddressBooks!.value;
    if (filtredAddressBooks!.isEmpty) {
      loadedAddressFiltredRecentBooksItems.value = 0;
    } else {
      if (filtredAddressBooks!.length >= 6) {
        loadedAddressFiltredBooksItems.value = 6;
      } else {
        loadedAddressFiltredBooksItems.value = filtredAddressBooks!.length;
      }
    }
  }

  void sortAvailableCountriesByAvailability() {
    availableCountries!.sort(((a, b) {
      if (b.active) {
        return 1;
      }
      return -1;
    }));
  }

  //clear data
  void clearDestinationContact() {
    //don't touch this line
    selectedReceiver.value ??= null;
  }
}
