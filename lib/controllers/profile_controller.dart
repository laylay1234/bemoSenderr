import 'dart:async';
import 'dart:convert';
import 'dart:developer' as d;

import 'package:amplify_api/model_subscriptions.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Locale, Route, StatelessWidget, TextEditingController, ThemeMode, Widget;
import 'package:flutter_amplifysdk/controllers/generic.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:mobileapp/app_models/app_currency.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/helpers/api_helper.dart';
import 'package:mobileapp/helpers/notifications_manager.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/views/home/contacts_views/contacts_view.dart';
import 'package:mobileapp/views/home/history_views/history_view.dart';
import 'package:mobileapp/views/home/send_money_views/send_view.dart';
import 'package:mobileapp/views/home/settings_views/settings_view.dart';
import 'package:statemachine/statemachine.dart';
import '../app_models/app_appSettings.dart';
import '../app_models/app_country.dart';
import '../app_models/app_user.dart';
import '../utils/error_alerts_utils.dart';

class ProfileController extends GenericController {
  Rx<bool> firstEventFlag = true.obs;
  RxMap appSettings = <String, dynamic>{}.obs;
  final List<StatelessWidget> views = [const SendView(), const HistoryView(), const ContactsView(), const SettingsView()];
  Rx<StatelessWidget> currentPage = (const SendView() as StatelessWidget).obs;
  Rx<int> currentIndex = 0.obs;

  ApiHelper dataStoreHelper = ApiHelper();
  // DEFAULT DATA
  static const fallbackLocale = Locale('en', 'US');
  static final Locale defaultLocale = Get.deviceLocale ?? fallbackLocale;
  late Rx<User>? userInstance =
      User(email: '', phone_number: '', newsletter_subscription: false, profileID: '', occupation: '', user_status: GenericStatus.ACTIVE, kyc_level: 0).obs;
  RxList<GlobalTransaction>? globalTransactions = <GlobalTransaction>[].obs;
  RxList<AddressBook>? addressBooks = <AddressBook>[].obs;

  RxList<AddressBook>? recentAddressBooks = <AddressBook>[].obs;

  //RxList<Address>? addresses = <Address>[].obs; // this one belongs to the adressBooks
  //Rx<UserProfileEntity> profle = UserProfileEntity().obs;
  Rx<Locale> appLocale = const Locale('en', 'US').obs;
  late Rx<String> themeType;
  //for search
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<bool> enableSearch = false.obs;
  RxList<AddressBook>? searchResult = <AddressBook>[].obs;

  // TODO: We should probably use TextControllers instead of observables
  // Add address variables
  //
  Rx<bool> addressBooksIsLoading = true.obs;
  Rx<bool> globalTransactionsIsLoading = true.obs;
  Rx<bool> recentAddressBooksIsLoading = true.obs;
  Rx<bool> addressBooksSearchResultLoading = false.obs;

  Rx<bool> isLoadingMoreAddressBooks = false.obs;
  Rx<bool> isLoadingMoreRecentAddressBooks = false.obs;
  Rx<bool> isLoadingMoreGlabalTransaction = false.obs;
  Rx<bool> isLoadingMoreAddressBooksSearchResult = false.obs;

  Rx<int> loadedGlobalTransactionsItems = 0.obs;
  Rx<int> loadedAddressBooksItems = 0.obs;
  Rx<int> loadedRecentAddressBooksItems = 0.obs;
  Rx<int> loadedAddressBooksSearchResults = 0.obs;

  StreamSubscription? _streamUserCreated;
  StreamSubscription? _streamParameterUpdated;
  StreamSubscription? _streamGlobalTransactionCreated;
  StreamSubscription? _streamCollectTransactionCreated;
  StreamSubscription? _streamCollectTransactionUpdated;

  //
  bool isDebugBuild = !kReleaseMode;

  // CONTROLLER STATE
  // var setupIntent;

  /* TODO: Document state + draw.io
  */
  late State homeState;

  Worker? worker;

  OriginController get originController {
    return Get.find<OriginController>();
  }

  SendMoneyController get sendMoneyController {
    return Get.find<SendMoneyController>();
  }

  AuthController get authController {
    return Get.find<AuthController>();
  }

  ProfileController() {
    SendMoneyController sendMoneyController = Get.find<SendMoneyController>();

    loggedInState.onEntry(() async {
      loading();
      //await Amplify.DataStore.clear();
      //await Amplify.DataStore.start();
      //set the right view in case user logged in after a log out
      //
      //this is used to check wether the user completed the sign up forms or not
      // if not we enter the missingInformation state
      // and let the user complete the forms
      // no need to send an email alert
      try {
        var result = await AppUser().getUserById(id: authController.userId.value);
        if (result != null) {
          // TODO: check why the profile of userInstance is null
          if (userInstance!.value.profile != null) {
            if (((authController.userFirstName.value != result.profile!.first_name) && (authController.userFirstName.value.isNotEmpty)) ||
                ((authController.userLastName.value != result.profile!.last_name) && (authController.userFirstName.value.isNotEmpty))) {
              result = result.copyWith(
                  profile: userInstance!.value.profile!.copyWith(first_name: authController.userFirstName.value, last_name: authController.userLastName.value));
              //
              //
              await AppUser().save(data: userInstance!.value.toJson());
            }
          }

          userInstance!.value = result;
          //
        } else {
          authController.goNextStep(state: authController.missingInformation);
          loggedOutState.enter();
          return;
        }
      } catch (e) {
        log(e.toString());
        authController.goNextStep(state: authController.missingInformation);
        loggedOutState.enter();
        return;
      }
      await loadData();

      if (sendMoneyController.getCurrentState() != sendMoneyController.loggedInState) {
        sendMoneyController.loggedInState.enter();
      }

      //

      /*
      Amplify.DataStore.observe<GlobalTransaction>(GlobalTransaction.classType).listen((event) async {
        //only update first level fields
        log('event reciever ');
        if (event.eventType == EventType.update) {
          updateGlobalTransactionLocally(event.item);
        } else if (event.eventType == EventType.delete) {
          //TODO handle this event type

        } else if (event.eventType == EventType.create) {
          //TODO handle this event type
        }
      });*/
      _subscribeOnUpdateUser();
      _subscribeOnUpdateTransaction();
      _subscribeOnUpdateCollectTransaction();
      _subscribeOnUpdateParameters();

      NotificationsManger().updateEndpoints(user: userInstance!.value);
      setAppSettingsFromCloud();

      try {
        succeed();
      } catch (error, stackTrace) {
        Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
        throw UnknownErrorAmplifyException(error.toString());
      }
    });

    loggedOutState.onEntry(() async {
      //

      addressBooks!.value = [];
      globalTransactions!.value = [];
      recentAddressBooks!.value = [];
      //profileController.currentIndex.value = 0;
      searchResult!.value = [];
      if (userInstance!.value != null) {
        userInstance!.value = userInstance!.value.copyWith(
            phone_number: '',
            email: '',
            id: '',
            profile: userInstance!.value.profile != null ? userInstance!.value.profile!.copyWith(first_name: '', last_name: '') : null);
      }

      if (currentIndex.value != 0) {
        currentIndex.value = 0;
        currentPage.value = views[0];
      }
    });

    stateMachine.onAfterTransition.forEach((event) {
      dbg("TRANSITION  ${event.source?.identifier} -> ${event.target?.identifier}", cat: 'STATE', isError: false);
    });
  }

  void _subscribeOnUpdateUser() {
    if (_streamUserCreated == null) {
      var _subscriptionRequest = ModelSubscriptions.onUpdate(User.classType);
      var _operation = Amplify.API
          .subscribe(
        _subscriptionRequest,
        onEstablished: () => d.log('Updated User Subscription established'),
      )
          .handleError((error) {
        d.log('Error in Updated User subscription stream: $error');
      });
      _streamUserCreated = _operation.listen(
        (event) {
          d.log('Received Updated user ' + event.data.toString());
          d.log("Received Updated user");
          try {
            if (event.data != null) {
              User? _model = event.data;
              if (_model != null) {
                var _currentUserId = AppUser().userId;
                // Only update if user owns the data
                if (_model.id == _currentUserId) {
                  updateUserLocally(_model);
                }
              }
            }
          } catch (e, stackTrace) {
            Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

            d.log("from observe " + e.toString());
          }
        },
        onError: (Object e) => d.log('Error in Updated User subscription stream: $e'),
      );
    }
  }

  void _subscribeOnUpdateTransaction() {
    if (_streamGlobalTransactionCreated == null) {
      var _subscriptionRequest = ModelSubscriptions.onUpdate(GlobalTransaction.classType);
      var _operation = Amplify.API
          .subscribe(
        _subscriptionRequest,
        onEstablished: () => dbg('Updated GlobalTransaction Subscription established'),
      )
          .handleError((error) {
        dbg('Error in Updated Updated GlobalTransaction stream: $error');
      });
      _streamParameterUpdated = _operation.listen(
        (event) {
          dbg('Received Updated GlobalTransaction ' + event.data.toString());
          try {
            if (event.data != null) {
              GlobalTransaction? _model = event.data;
              if (_model != null) {
                var _currentUserId = AppUser().userId;
                // Only update if user owns the data
                if (_model.user?.id == _currentUserId) {
                  updateGlobalTransactionLocally(_model);
                }
              }
            }
          } catch (e, stackTrace) {
            Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

            log("from observe " + e.toString());
          }
        },
        onError: (Object e) => dbg('Error in Updated GlobalTransaction subscription stream: $e'),
      );
    }
  }

  void _subscribeOnUpdateParameters() {
    if (_streamParameterUpdated == null) {
      var _subscriptionRequest = ModelSubscriptions.onUpdate(Parameters.classType);
      var _operation = Amplify.API
          .subscribe(
        _subscriptionRequest,
        onEstablished: () => dbg('Updated Parameters Subscription established'),
      )
          .handleError((error) {
        dbg('Error in Updated Updated Parameters stream: $error');
      });
      _streamParameterUpdated = _operation.listen(
        (event) async {
          dbg('Received Updated Parameters ' + event.data.toString());
          try {
            if (event.data != null) {
              Parameters parameters = event.data!;
              log('Parameters event' + parameters.toString());
              try {
                GlobalTransaction transaction = globalTransactions!.firstWhere((e) => e.parameters!.id == parameters.id);
                var _currentUserId = AppUser().userId;
                // Only update if user owns the data
                if (transaction.user?.id == _currentUserId) {
                  //transaction = transaction.copyWith(parameters: (event.item));

                  if (parameters.destination_country == null) {
                    Country? countryA = AppCountry().loadedCountries.firstWhereOrNull((element) => element.id == transaction.parameters!.destination_countryID);
                    parameters = parameters.copyWith(destination_country: countryA);
                  }
                  //
                  //
                  if (parameters.origin_country == null) {
                    //transaction.parameters!.origin_countryID
                    Country? countryB = AppCountry().loadedCountries.firstWhereOrNull((element) => element.id == transaction.parameters!.origin_countryID);
                    parameters = parameters.copyWith(origin_country: countryB);
                  }
                  //
                  //
                  if (parameters.currency_origin == null) {
                    //transaction.parameters!.currency_originID
                    Currency? currencyA = AppCurrency().loadedCurrencies.firstWhereOrNull((element) => element.id == transaction.parameters!.currency_originID);

                    parameters = parameters.copyWith(currency_origin: currencyA);
                  }
                  //
                  //
                  if (parameters.currency_destination == null) {
                    //transaction.parameters!.currency_destinationID
                    Currency? currencyB =
                        AppCurrency().loadedCurrencies.firstWhereOrNull((element) => element.id == transaction.parameters!.currency_destinationID);

                    parameters = parameters.copyWith(currency_destination: currencyB);
                  }
                  transaction = transaction.copyWith(parameters: parameters);
                  //
                  //
                  globalTransactions!.value[globalTransactions!.indexWhere((e) => e.parameters!.id == event.data!.id)] = transaction;
                  sortGlobalTransactions(sort: true, fromSendMoney: false);
                }
              } catch (error, stackTrace) {
                Utils().sendEmail(message: '${event.data!.toString()}\n${error.toString()}\n${stackTrace.toString()}');
                log(error.toString());
              }
            }
          } catch (e, stackTrace) {
            Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

            log("from observe " + e.toString());
          }
        },
        onError: (Object e) => dbg('Error in Updated GlobalTransaction subscription stream: $e'),
      );
    }
  }

  void _subscribeOnUpdateCollectTransaction() {
    if (_streamCollectTransactionCreated == null) {
      var _subscriptionRequest = ModelSubscriptions.onCreate(CollectTransaction.classType);
      var _operation = Amplify.API
          .subscribe(
        _subscriptionRequest,
        onEstablished: () => dbg('Updated GlobalTransaction Subscription established'),
      )
          .handleError((error) {
        dbg('Error in Updated Updated GlobalTransaction stream: $error');
      });
      _streamCollectTransactionCreated = _operation.listen(
        (event) {
          dbg('Received Updated GlobalTransaction ' + event.data.toString());
          try {
            if (event.data != null) {
              CollectTransaction _collectTransaction = event.data!;
              log('collect code event' + _collectTransaction.toString());
              try {
                GlobalTransaction transaction = globalTransactions!.firstWhere((e) => e.id == _collectTransaction.globalTransactionID);
                var _currentUserId = AppUser().userId;
                // Only update if user owns the data
                if (transaction.user?.id == _currentUserId) {
                  List<CollectTransaction> new_collect_codes = transaction.collect_transactions != null ? transaction.collect_transactions! : [];
                  new_collect_codes.add(_collectTransaction);
                  transaction = transaction.copyWith(collect_transactions: new_collect_codes);
                  globalTransactions!.value[globalTransactions!.indexWhere((e) => e.id == _collectTransaction.globalTransactionID)] = transaction;

                  sortGlobalTransactions(sort: true, fromSendMoney: false);
                }
              } catch (error, stackTrace) {
                Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

                log(error.toString());
              }
            }
          } catch (e, stackTrace) {
            Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

            log("from observe " + e.toString());
          }
        },
        onError: (Object e) => dbg('Error in Updated GlobalTransaction subscription stream: $e'),
      );
    }
    if (_streamCollectTransactionUpdated == null) {
      var _subscriptionRequest = ModelSubscriptions.onUpdate(CollectTransaction.classType);
      var _operation = Amplify.API
          .subscribe(
        _subscriptionRequest,
        onEstablished: () => dbg('Updated GlobalTransaction Subscription established'),
      )
          .handleError((error) {
        dbg('Error in Updated Updated GlobalTransaction stream: $error');
      });
      _streamCollectTransactionUpdated = _operation.listen(
        (event) {
          dbg('Received Updated GlobalTransaction ' + event.data.toString());
          try {
            if (event.data != null) {
              CollectTransaction _collectTransaction = event.data!;
              log('collect code event' + _collectTransaction.toString());
              try {
                GlobalTransaction transaction = globalTransactions!.firstWhere((e) => e.id == _collectTransaction.globalTransactionID);
                var _currentUserId = AppUser().userId;
                // Only update if user owns the data
                if (transaction.user?.id == _currentUserId) {
                  List<CollectTransaction> new_collect_codes = transaction.collect_transactions != null ? transaction.collect_transactions! : [];
                  new_collect_codes.add(_collectTransaction);
                  transaction = transaction.copyWith(collect_transactions: new_collect_codes);
                  globalTransactions!.value[globalTransactions!.indexWhere((e) => e.id == _collectTransaction.globalTransactionID)] = transaction;

                  sortGlobalTransactions(sort: true, fromSendMoney: false);
                }
              } catch (error, stackTrace) {
                Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

                log(error.toString());
              }
            }
          } catch (e, stackTrace) {
            Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

            log("from observe " + e.toString());
          }
        },
        onError: (Object e) => dbg('Error in Updated GlobalTransaction subscription stream: $e'),
      );
    }
  }

  Future<void> loadData() async {
    //await Amplify.DataStore.clear();
    //await Amplify.DataStore.start();
    await authController.loadOriginCountryFromAttriutes();
    try {
      //
      /*
      if (userInstance!.value.origin_calling_code == null || userInstance!.value.origin_calling_code!.isEmpty) {
        originController.origin_calling_code.value = "+1"; //target_country_code
      } else {
        originController.origin_calling_code.value = userInstance!.value.origin_calling_code!; //target_country_code
      }
      if (userInstance!.value.origin_country_iso == null || userInstance!.value.origin_country_iso!.isEmpty) {
        originController.origin_country_iso.value = "ca"; //target_country_iso
      } else {
        originController.origin_country_iso.value = userInstance!.value.origin_country_iso!.toLowerCase(); //target_country_iso
      }
    */
      //
      //
      await loadCompleteGlobalTransactions().then((value) {
        // ignore: invalid_use_of_protected_member
        //
        //todo find another workaroudn for this
        //sorting
        //sortGlobalTransactions(sort: true);
        loadCompleteRecentAddressBooks();
      });
      //
      //
      //
      //
      loadCompleteAddressBooks();
      sortGlobalTransactions(sort: true, fromSendMoney: false);
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      // goNextStep(state: loggedOutState);
      // authController.goNextStep(state: authController.loggedOutState);
    }
  }

  Future<void> loadCompleteAddressBooks() async {
    addressBooksIsLoading.value = true;
    addressBooks!.value = (await dataStoreHelper.getCompleteAddressBooks(userInstance!.value.id));
    sortContacts();
    addressBooksIsLoading.value = false;
  }

  void sortContacts() async {
    addressBooks!.sort(((a, b) {
      if (a.first_name.compareTo(b.first_name) == 0) {
        return a.last_name.compareTo(b.last_name);
      }
      return a.first_name.compareTo(b.first_name);
    }));
  }

  void sortRecentContacts() async {
    recentAddressBooks!.sort(((a, b) {
      if (b.first_name.compareTo(a.first_name) == 0) {
        return b.last_name.compareTo(a.last_name);
      }
      return b.first_name.compareTo(a.first_name);
    }));
  }

  Future<void> loadCompleteGlobalTransactions() async {
    globalTransactionsIsLoading.value = true;
    globalTransactions!.value = await dataStoreHelper.getCompleteGlobalTransactions(authController.userId.value);
    globalTransactionsIsLoading.value = false;
  }

  Future<void> loadCompleteRecentAddressBooks() async {
    recentAddressBooksIsLoading.value = true;
    recentAddressBooks!.value = (await getRecentAddressBookByGlobalTransactions()) ?? [];
    sortRecentContacts();
    recentAddressBooksIsLoading.value = false;
  }

  void sortGlobalTransactions({sort = false, call = true, required fromSendMoney}) {
    if (globalTransactions == null) {
      return;
    }
    if (globalTransactions!.isEmpty) {
      //do nothing , destination will be selected by random
    } else {
      //we sort the transactions again
      globalTransactions!.sort(((a, b) => b.created_at.compareTo(a.created_at)));
      if (sort) {
        //log("from sortGlobalTransactions");
        //We set the destination by the first latest destination country
        if (fromSendMoney) {
          setDestinationCountry(globalTransactions!.first.parameters!.destination_country!);
        }
      }
    }
  }

  void setDestinationCountry(Country country) {
    //assigning an obs country and updating it
    sendMoneyController.selectedDestinationCountry = country.obs;
    sendMoneyController.selectedDestinationCountry!.value = country;
    sendMoneyController.selectedDestinationCountry!.update((val) {});

    if (sendMoneyController.sendEditingController.value.text == sendMoneyController.minValue.value) {
      sendMoneyController.getExchangeRate(sendMoneyController.minValue.value);
      sendMoneyController.calculateTotal();
    } else {
      sendMoneyController.getExchangeRate(sendMoneyController.sendEditingController.value.text);
      sendMoneyController.calculateTotal();
    }
  }

  Future<List<AddressBook>?> getRecentAddressBookByGlobalTransactions() async {
    Set<AddressBook> uniqueSorted = {};
    List<AddressBook>? sorted = [];
    try {
      sorted = globalTransactions!.map((e) => e.receiver!).where((element) => uniqueSorted.add(element)).toList();
    } catch (e, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log("from getRecentAddressBookByGlobalTransactions " + e.toString());
    }
    try {
      sorted = await dataStoreHelper.getCompleteAddressBooksByIds(uniqueSorted.map((e) => e.id).toList());
    } catch (e, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log('getRecentAddressBookByGlobalTransactions ' + e.toString());
    }
    return sorted;
  }

  Future<void> updateUserLocally(User user) async {
//onUserTierUpgradeErrorSnackBar
    /*
    if (user.user_status == GenericStatus.CONFIRMED && userInstance!.value.user_status != GenericStatus.CONFIRMED) {
      if (Get.currentRoute == WelcomeScreen.id) {
        Future.delayed(const Duration(seconds: 15)).then((value) {
          onEmailConfirmationSnackBar();
        });
      } else {
        if (Get.isSnackbarOpen) {
          Future.delayed(const Duration(seconds: 3)).then((value) {
            if (!firstEventFlag.value) {
              onEmailConfirmationSnackBar();
            }
          });
        } else {
          if (!firstEventFlag.value) {
            onEmailConfirmationSnackBar();
          }
        }
      }
    }
      */
    //
    userInstance!.value =
        userInstance!.value.copyWith(kyc_level: user.kyc_level, user_status: user.user_status, bank_verification_status: user.bank_verification_status);
  }

  Future<void> updateGlobalTransactionsLocally(List<GlobalTransaction> eventItem) async {
    var items = eventItem;

    List<GlobalTransaction> finalItems = [];
    for (var item in items) {
      if (globalTransactions!.where((p0) => p0.id == item.id).isNotEmpty) {
        if (globalTransactions!.contains(item)) {
          log("updateGlobalTransactionsLocally:true");
        } else {
          //
          var oldGT = globalTransactions!.where((p0) => p0.id == item.id).first;
          var updatedGT = oldGT.copyWith(status: item.status, collect_transactions: item.collect_transactions ?? []);
          //var result = globalTransactions!.where((p0) => p0.id != item.id).toList();
          globalTransactions![globalTransactions!.indexWhere((e) => e.id == item.id)] = updatedGT;
          //  globalTransactions!.add(updatedGT);
          finalItems.add(updatedGT);
        }
      }
    }
    sortGlobalTransactions(sort: true, fromSendMoney: true);

    //globalTransactions!.value = finalItems;
  }

  Future<void> updateGlobalTransactionLocally(GlobalTransaction eventItem) async {
    var item = eventItem;
    if (globalTransactions!.where((p0) => p0.id == item.id).isNotEmpty) {
      var oldGT = globalTransactions!.where((p0) => p0.id == item.id).first;
      var updatedGT = oldGT.copyWith(status: item.status);
      if (oldGT.status == GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS && updatedGT.status == GlobalTransactionStatus.SUCCESS) {
        //

      } else {
        updatedGT = updatedGT.copyWith(collect_transactions: item.collect_transactions ?? []);
      }
      globalTransactions![globalTransactions!.indexWhere((e) => e.id == item.id)] = updatedGT;
      // globalTransactions!.add(updatedGT);
      //globalTransactions!.value
    }
    sortGlobalTransactions(sort: true, fromSendMoney: false);
  }

  List<GlobalTransaction> getTransactionsByAddressBook(AddressBook addressBook) {
    List<GlobalTransaction> transactions = [];
    try {
      transactions = globalTransactions!.where((e) => e.receiver!.id == addressBook.id).toList();
    } catch (e, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log(e.toString());
    }
    return transactions;
  }

  List<DateTime> getUniqueDatesFromGlobalTransactions() {
    List<DateTime> result = [];
    for (var e in globalTransactions!) {
      var date = DateTime(e.created_at.getDateTimeInUtc().year, e.created_at.getDateTimeInUtc().month, e.created_at.getDateTimeInUtc().day);
      //bool contains = false;
      if (!result.contains(date)) {
        // log('unique?');
        result.add(date);
      }
    }
    //log(result.length);
    result.sort(((a, b) => b.compareTo(a)));
    //log(result.length);

    return result;
  }

  List<GlobalTransaction> getGlobalTransactionsByDate(DateTime date) {
    List<GlobalTransaction> transactions = [];
    for (var e in globalTransactions!) {
      var year = e.created_at.getDateTimeInUtc().year;
      var month = e.created_at.getDateTimeInUtc().month;
      // var day = e.created_at.getDateTimeInUtc().day;
      if (year == date.year && month == date.month) {
        transactions.add(e);
      }
    }
    return transactions;
  }

  @override
  void onReady() {
    change(controllerState, status: RxStatus.loading());
    super.onReady();
  }

  void updateLang(Locale locale) {
    Get.updateLocale(locale);
    appLocale.value = locale;
    Jiffy.locale(locale.languageCode.toUpperCase());
  }

  // TODO: Remove toggleTheme
  void toggleTheme() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }

  void changeTheme({
    String themeSelected = 'system',
  }) {
    ThemeMode _themeMode = ThemeMode.system;

    switch (themeSelected) {
      case "light":
        _themeMode = ThemeMode.light;
        break;
      case "dark":
        _themeMode = ThemeMode.dark;
        break;
      default:
    }

    Get.changeThemeMode(_themeMode);
    themeType.value = themeSelected;
  }

  void searchForAddressBooksByValue(String value) {
    try {
      searchResult!.value = addressBooks!
          .where((e) =>
              (e.first_name.toLowerCase().contains(value.toLowerCase())) ||
              (e.last_name.toLowerCase().contains(value.toLowerCase())) ||
              (e.phone_number.toLowerCase().replaceAll(' ', '').contains(value.toLowerCase().replaceAll(' ', '')) ||
                  (e.address!.address_line_1!.toLowerCase().contains(value.toLowerCase()))))
          .toList();
      initLoadedSearchResultAddressBooks();
    } catch (e, stackTrace) {
      //
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      dbg(e.toString(), isError: true);
    }
  }

  void searchForAddressBooksByValueInSendMoney(String value) {
    // sendMoneyController.filtredAddressBooks;
    searchResult!.value = sendMoneyController.filtredAddressBooks!
        .where((e) =>
            (e.first_name.toLowerCase().contains(value.toLowerCase())) ||
            (e.last_name.toLowerCase().contains(value.toLowerCase())) ||
            (e.phone_number.toLowerCase().contains(value.toLowerCase()) || (e.address!.address_line_1!.toLowerCase().contains(value.toLowerCase()))))
        .toList();
    sendMoneyController.initFilteredRecentAddressBooks();
  }

  Future<void> sendConfirmationEmail() async {
    //SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    var token = await authController.getToken();
    String id = (await Amplify.Auth.getCurrentUser()).userId;
    //_cognitoSession.credentials
    try {
      Response response = await getConnect.post("${sendMoneyController.api}/send-email", {
        'user_id': id,
        'email': userInstance!.value.email
      }, headers: {
        'Authorization': 'bearer $token',
        'Content-Type': 'application/json',
      });
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log('sendConfirmationEmail: ' + error.toString());
    }
  }

  void initLoadedGlobalTransaction() {
    var index = 1;

    index = (globalTransactions != null
        ? globalTransactions!.length > 10
            ? 10
            : globalTransactions!.length
        : 0);
    loadedGlobalTransactionsItems.value = index;

    //
  }
  //

  Future<void> initLoadedAddressBooks() async {
    //await Future.delayed(const Duration(seconds: 1));
    //var filtredRecentAddressBooks = sendMoneyController.filtredRecentAddressBooks!.value;
    if (addressBooks!.isEmpty) {
      loadedAddressBooksItems.value = 0;
    } else {
      if (addressBooks!.length >= 6) {
        loadedAddressBooksItems.value = 6;
      } else {
        loadedAddressBooksItems.value = addressBooks!.length;
      }
    }
  }

  void initLoadedSearchResultAddressBooks() {
    if (searchResult!.isEmpty) {
      loadedAddressBooksSearchResults.value = 0;
    } else {
      if (addressBooks!.length >= 6) {
        loadedAddressBooksSearchResults.value = 6;
      } else {
        loadedAddressBooksSearchResults.value = searchResult!.length;
      }
    }
  }

  void initLoadedRecentAddressBooks() {
    if (recentAddressBooks!.isEmpty) {
      loadedRecentAddressBooksItems.value = 0;
    } else {
      if (addressBooks!.length >= 6) {
        loadedRecentAddressBooksItems.value = 6;
      } else {
        loadedRecentAddressBooksItems.value = recentAddressBooks!.length;
      }
    }
    //log(val)
  }

  //
  Future<void> setAppSettingsFromCloud() async {
    try {
      //String data = ((await Amplify.DataStore.query(AppSettings.classType)).first.content);
      String result = (await AppSettingsModel().listAppSettings())!.content;
      appSettings.value = json.decode(result) as Map<String, dynamic>;
      sendMoneyController.getDefaultValueForOriginAmount();
      // log(appSettings.value);
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log(error.toString());
    }
  }

  Future<void> loadMoreGlobalTransaction() async {
    isLoadingMoreGlabalTransaction.value = true;
    await Future.delayed(const Duration(seconds: 1));
    if (loadedGlobalTransactionsItems.value < (globalTransactions!.length - 6)) {
      loadedGlobalTransactionsItems.value = loadedGlobalTransactionsItems.value + 6;
    } else if (loadedGlobalTransactionsItems.value < (globalTransactions!.length - 3)) {
      loadedGlobalTransactionsItems.value = loadedGlobalTransactionsItems.value + 3;
    } else {
      loadedGlobalTransactionsItems.value = globalTransactions!.length;
    }
    isLoadingMoreGlabalTransaction.value = false;
  }

  Future<void> loadMoreAddressBooks() async {
    isLoadingMoreAddressBooks.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if ((loadedAddressBooksItems.value + 3) >= addressBooks!.length) {
      loadedAddressBooksItems.value = addressBooks!.length;
    } else {
      loadedAddressBooksItems.value = loadedAddressBooksItems.value + 3;
    }
    isLoadingMoreAddressBooks.value = false;
  }

  Future<void> loadMoreSearchResultAddressBooks() async {
    isLoadingMoreAddressBooksSearchResult.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if ((loadedAddressBooksSearchResults.value + 3) >= addressBooks!.length) {
      loadedAddressBooksSearchResults.value = searchResult!.length;
    } else {
      loadedAddressBooksSearchResults.value = loadedAddressBooksSearchResults.value + 3;
    }
    isLoadingMoreAddressBooksSearchResult.value = false;
  }

  Future<void> loadMoreRecentAddressBooks() async {
    isLoadingMoreRecentAddressBooks.value = true;
    await Future.delayed(const Duration(seconds: 2));
    if ((loadedRecentAddressBooksItems.value + 3) >= recentAddressBooks!.length) {
      loadedRecentAddressBooksItems.value = recentAddressBooks!.length;
    } else {
      loadedAddressBooksItems.value = loadedRecentAddressBooksItems.value + 3;
    }
    isLoadingMoreRecentAddressBooks.value = false;
  }

  @override
  void handleOnPop(Route route, Route? previousRoute) {
    // TODO: implement handleOnPop
  }

  @override
  void initVariables() {
    // TODO: implement initVariables
  }

  @override
  void resetVariables() {
    // TODO: implement resetVariables
  }
}

@override
void handleOnPop(Route route, Route? previousRoute) {
  // TODO: implement handleOnPop
  switch (previousRoute!.settings.name) {
  }
}

@override
void initVariables() {
  // TODO: implement initVariables
}

@override
void resetVariables() {
  // TODO: implement resetVariables
}

// Future<Address> newAddress({
//   required String name,
//   required String line1,
//   String line2 = '',
//   required String city,
//   required String state,
//   required String country,
//   required String postalCode,
//   required AddressType type,
//   bool isBilling = false,
//   bool isShipping = false,
// }) async {
//   if (isBilling == false && isShipping == false) throw throwsArgumentError;
//   return await AppAddressModel().newAddress(
//       country: country,
//       name: name,
//       line1: line1,
//       line2: line2,
//       isBilling: isBilling,
//       isShipping: isShipping,
//       state: state,
//       postalCode: postalCode,
//       city: city);
// }
