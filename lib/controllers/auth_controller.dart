// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:developer' as d;
import 'dart:io';

import 'package:alphanum_comparator/alphanum_comparator.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_pinpoint_api/pinpoint-2016-12-01.dart' as p;
import 'package:flutter/material.dart' show FormFieldState, FormState, GlobalKey, Locale, TextEditingController;
import 'package:flutter_amplifysdk/controllers/generic_auth.dart';
import 'package:flutter_amplifysdk/errors.dart';
import 'package:flutter_amplifysdk/flutter_amplifysdk.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:mobileapp/app_models/app_address.dart';
import 'package:mobileapp/app_models/app_birthdate.dart';
import 'package:mobileapp/app_models/app_identityDocument.dart';
import 'package:mobileapp/app_models/app_profile.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/entities/bank_verification_entity.dart';
import 'package:mobileapp/entities/user_snapshot_entity.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/helpers/device_data_manager.dart';
import 'package:mobileapp/helpers/notifications_manager.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/utils/app_utils.dart';
import 'package:mobileapp/views/auth/auth.dart';
import 'package:mobileapp/views/auth/auth_connect_flinks_view.dart';
import 'package:mobileapp/views/auth/auth_register_address_view.dart';
import 'package:mobileapp/views/auth/password_confirm_reset_form_view.dart';
import 'package:mobileapp/views/home_view.dart';
import 'package:statemachine/statemachine.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../entities/app_version_entity.dart';
import '../entities/user_bank_verify_response.dart';
import '../utils/error_alerts_utils.dart';
import '../views/flinks_views/flinks_failed_view.dart';
import '../views/flinks_views/flinks_pending_view.dart';
import '../views/flinks_views/flinks_success_view.dart';
import '../widgets/dialogs/version_validation_dialog_widget.dart';

import '../app_models/app_user.dart';

enum FlinksResultStatus { pending, failed, successful }

class AuthController<T extends Model> extends GenericAuthController {
  final StreamController<SessionState> sessionTimeoutManagerStateStream = StreamController<SessionState>();

  Rx<bool> isSignUpFlow = false.obs;
  Rx<String> langPreference = 'English'.obs;
  // OBSERVABLES
  Rx<String> userFirstName = ''.obs;
  Rx<String> userLastName = ''.obs;
  Rx<String> userEmail = ''.obs;
  Rx<String> userPhone = ''.obs;
  Rx<String> userId = ''.obs;
  Rx<FlinksResultStatus> flinksResultStatus = FlinksResultStatus.failed.obs;
  Rx<String> bankRequestUUID = ''.obs;
  // Rx<Family?> myFamily = null.obs;
  Rx<String> flinksUrl = ''.obs;
  late State credsLoginState;
  late State credsRegisterState;
  late State missingInformation;
  // late State onboardingState;
  late State passwordResetState;
  late State passwordResetConfirmState;
  //app version controlling
  Rx<AppStoreVersion> appStoreVersion = AppStoreVersion().obs;
  //TODO:Greg > this needs to be in generic_auth
  Rx<bool> showPassword = false.obs;
  Rx<bool> isSubscribedToNewsLetter = false.obs;
  //password key
  Rx<GlobalKey<FormFieldState>> passKey = GlobalKey<FormFieldState>().obs;

  //email and password key field state
  Rx<GlobalKey<FormFieldState>> emailKey = GlobalKey<FormFieldState>().obs;
  Rx<GlobalKey<FormFieldState>> confirmEmailKey = GlobalKey<FormFieldState>().obs;
  Rx<GlobalKey<FormFieldState>> passwordKey = GlobalKey<FormFieldState>().obs;
  Rx<GlobalKey<FormFieldState>> confirmPasswordKey = GlobalKey<FormFieldState>().obs;

  Rx<TextEditingController> emailRxController = TextEditingController().obs;
  Rx<TextEditingController> passwordRxController = TextEditingController().obs;
  Rx<TextEditingController> confirmEmailController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController = TextEditingController().obs;
  //
  Rx<TextEditingController> confirmPassResetCodeController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> confirmPassResetCodeKey = GlobalKey<FormFieldState>().obs;

  //
  Rx<GlobalKey<FormFieldState>> firstNameKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> firstNameRxController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> lastNameKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> lastNameRxController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> occupationKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> occupationRxController = TextEditingController().obs;

//
  Completer<WebViewController> webViewController = Completer<WebViewController>();

  Rx<DateTime?> dob = (null as DateTime?).obs;
  Rx<GlobalKey<FormFieldState>> phoneKey = GlobalKey<FormFieldState>().obs;
  Rx<GlobalKey<FormFieldState>> phoneResetKey = GlobalKey<FormFieldState>().obs;
  Rx<GlobalKey<FormFieldState>> phonepassResetKey = GlobalKey<FormFieldState>().obs;

  Rx<GlobalKey<FormFieldState>> phoneRegisterKey = GlobalKey<FormFieldState>().obs;

  Rx<TextEditingController> phoneController = TextEditingController().obs;
  //documents form
  Rx<String?>? documentIdType = (null as String?).obs;
  Rx<GlobalKey<FormFieldState>> documentIdKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> documentIdNumber = TextEditingController().obs;
  Rx<DateTime?> documentExpDate = (null as DateTime?).obs;
  Rx<String> countryOfBirth = ''.obs;
  Rx<Gender?> gender = (null as Gender?).obs;
  Rx<GlobalKey<FormFieldState>> cityOfBirthKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> cityOfBirth = TextEditingController().obs;
  //address form
  Rx<GlobalKey<FormFieldState>> fullAddressKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> fullAddressController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> zipCodeKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> zipCodeController = TextEditingController().obs;
  Rx<GlobalKey<FormFieldState>> cityKey = GlobalKey<FormFieldState>().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;

  //for form validation
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> confirmResetFormKey = GlobalKey<FormState>();
  Rx<bool> enableConfirmResetButton = false.obs;
  //change password form key
  GlobalKey<FormState> changePasswordFormKey = GlobalKey<FormState>();
  Rx<GlobalKey<FormFieldState>> newPasswordControllerKey = GlobalKey<FormFieldState>().obs;
  Rx<GlobalKey<FormFieldState>> confirmNewPasswordControllerKey = GlobalKey<FormFieldState>().obs;

  Rx<TextEditingController> newPasswordController = TextEditingController().obs;
  Rx<bool> enableChangePassword = false.obs;
  GlobalKey<FormState> changePasswordKey = GlobalKey<FormState>();
  final RxMap<String, dynamic> _userData = <String, dynamic>{}.obs;
  Rx<bool> isAppNeedUpdate = false.obs;
  //for sign up flow
  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];

  Rx<bool> enablePhoneNext = false.obs;
  Rx<bool> enableUserInfoNext = false.obs;
  Rx<bool> enableIdentityNext = false.obs;
  Rx<bool> enableEmailPassNext = false.obs;
  Rx<bool> enableLogin = false.obs;
  Rx<bool> enableCodeContinue = false.obs;
  Rx<bool> enableCreateAccount = false.obs;
  //For updating the profile
  Rx<bool> enableUpdateProfile = false.obs;
  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();
  //Flinks related variables
  Rx<String> loginId = ''.obs;
  Rx<String> accountId = ''.obs;

  //change password variables
  //
  ProfileController get profileController {
    return Get.find<ProfileController>();
  }

  OriginController get originController {
    return Get.find<OriginController>();
  }

  SendMoneyController get sendMoneyController {
    return Get.find<SendMoneyController>();
  }

  //SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
  AuthController() {
    startState.onEntry(() async {
      change({'status': AuthControllerStatus.init}, status: RxStatus.loading());
      await validateVersion();
    });
    confirmationNeededState.onEntry(() {
      Get.toNamed(RegisterConfirmView.id);
    });
    configuredState.onEntry(() async {
      bool _isAppNeedUpdate = await validateVersion();
      if (_isAppNeedUpdate == true) return;
      // clearTextControllers();
      //remove the splash
      // try {
      //   FlutterNativeSplash.remove();
      // } catch (e) {
      //   log(e.toString());
      // }
      //originController.origin_countries.value = await Amplify.DataStore.query(Country.classType);
      //d.log('here =>' + originController.origin_countries.length.toString());
      originController.getAvailableOriginCountries();
      updateLocaleByDeviceLocale();

      //we use the device lagnuage
      if (!(Get.currentRoute == LoginView.id ||
          Get.currentRoute == AuthRegisterAddressView.id ||
          Get.currentRoute == PasswordConfirmResetFormView.id ||
          Get.currentRoute == RegisterConfirmView.id)) {
        Get.offAllNamed(LandingView.id);
      }
    });
    credsLoginState = stateMachine.newState('credsLogin')
      ..onEntry(() async {
        bool _isAppNeedUpdate = await validateVersion();
        if (_isAppNeedUpdate == false) {
          startSessionTimer();
          await Get.toNamed(LoginView.id);
          // Go back to auth view page, no need to start the timer
          stopSessionTimer();
        }
      });
      // TODO: not used anywhere??
    // credsRegisterState = stateMachine.newState('credsRegister')
    //   ..onEntry(() async {
    //     bool _isAppNeedUpdate = await validateVersion();
    //     if (_isAppNeedUpdate == false) {
    //       Get.toNamed(AuthRegisterAddressView.id);
    //     }
    //   });

    passwordResetState = stateMachine.newState('passwordReset')
      ..onEntry(() async {
        bool _isAppNeedUpdate = await validateVersion();
        if (_isAppNeedUpdate == false) {
          Get.toNamed(PasswordResetView.id);
        }
      });
    missingInformation = stateMachine.newState('missingInformation')
      ..onEntry(() async {
        //
        if (Get.isOverlaysOpen) {
          Get.back(); // Removes loading dialog
        }
        if (Get.currentRoute == RegisterConfirmView.id || Get.currentRoute == LoginView.id) {
          Get.offAllNamed(AuthConnectWithFlinksView.id);
        } else if (Get.currentRoute == WelcomeScreen.id || Get.currentRoute == HomeView.id) {
          var userAttibutes = await Amplify.Auth.fetchUserAttributes();
          originController.origin_country_iso.value =
              userAttibutes.where((e) => e.userAttributeKey.key == const CognitoUserAttributeKey.custom('origin_country_iso').key).first.value.toLowerCase();
          originController.origin_country_name.value =
              userAttibutes.where((e) => e.userAttributeKey.key == const CognitoUserAttributeKey.custom('origin_country_name').key).first.value.toLowerCase();
          originController.origin_calling_code.value =
              userAttibutes.where((e) => e.userAttributeKey.key == const CognitoUserAttributeKey.custom('origin_calling_code').key).first.value.toLowerCase();

          userPhone.value = userAttibutes.where((e) => e.userAttributeKey.key == CognitoUserAttributeKey.phoneNumber.key).first.value;
          //originController
          //            const CognitoUserAttributeKey.custom('origin_iso'):originController.origin_country_iso.toLowerCase(),
          // const CognitoUserAttributeKey.custom('origin_name'):originController.origin_country_name.toLowerCase(),

          Get.offAllNamed(AuthConnectWithFlinksView.id);
        }

        isSignUpFlow.value = true;
      });
    confirmationNeededState.onEntry(() {
      Get.toNamed(RegisterConfirmView.id);
    });
    loggedOutState.onEntry(() {
      if (Get.isOverlaysOpen) {
        return;
      } else {
        Get.offAllNamed(LandingView.id);
      }
    });
    loggedInState.onEntry(
      () async {
        //we check wether we have the user data or not , if not we enter the missingInformation state
        //
        bool _isAppNeedUpdate = await validateVersion();
        if (_isAppNeedUpdate == true) return;

        List<AuthUserAttribute> _userAttributes;
        try {
          _userAttributes = await Amplify.Auth.fetchUserAttributes();
        } catch (e) {
          loggedOutState.enter();
          return;
        }

        var _apiGetRes = await RestService.instance.getProfile();

        //save user data into datastore
        //first we get current user from auth to get the id
        //save user data into datastore
        //first we get current user from auth to get the id

        // try {
        //TODO implement confirmationNeededState later

        bool _hasLocale = false;

        Map<String, String> propertyMap = {'given_name': 'first_name', 'family_name': 'last_name', 'email': 'email', 'phone_number': 'phone_number'};
        //

        //
        //

        for (var attribute in _userAttributes) {
          String _attrKey = attribute.userAttributeKey.key;
          dynamic _attrVal = attribute.value;
          String? _profileKey = propertyMap[_attrKey];
          if (_profileKey != null && _attrVal != _apiGetRes[_profileKey]) {
            // ignore: invalid_use_of_protected_member
            _userData.value[_profileKey] = _attrVal;
          }
          if (_profileKey == 'first_name') {
            userFirstName.value = _attrVal;
          }
          if (_profileKey == 'last_name') {
            userLastName.value = _attrVal;
          }
          if (_profileKey == 'email') {
            userEmail.value = _attrVal;
          }
        }
        if (profileController.userInstance!.value.phone_number.isEmpty) {
          if (Get.currentRoute != WelcomeScreen.id && Get.currentRoute != HomeView.id) {
            Get.offAllNamed(WelcomeScreen.id);
          }
        }
        //_userData['device_token'] = (NotificationsManger().getDeviceType() + '-' + device_token);
        //_userData['device_type'] = NotificationsManger().getDeviceType();
        // ignore: invalid_use_of_protected_member
        _userData.value['locale'] = Get.locale!.languageCode.toString().toUpperCase();
        if (!_hasLocale) {
          // For some case e.g. Google login, it doesn't have locale user attribute, this will get the locale from the user profile instead
          try {
            String _attrVal;
            if (_userAttributes.where((e) => e.userAttributeKey == CognitoUserAttributeKey.locale).isNotEmpty) {
              _attrVal = _userAttributes.where((e) => e.userAttributeKey == CognitoUserAttributeKey.locale).first.value;
            } else {
              _attrVal = 'en_US';
            }
            // if (_attrVal == null) _attrVal = 'en_US'; // set default
            List<String> localeCodes = _attrVal.split('_');
            profileController.updateLang(Locale(localeCodes[0], localeCodes[1]));
          } catch (e, stackTrace) {
            Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

            log(e.toString());
          }
        }

        //
        //
        //

        //
        //
        //

        var value = await Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true));
        CognitoAuthSession authSession = value as CognitoAuthSession;
        var currentUser = await Amplify.Auth.getCurrentUser();
        userId.value = currentUser.userId;
        DeviceDataManager().initDeviceData().then((value) {
          DeviceDataManager().sendDeviceDataToBackend();
        });
        var _token = await NotificationsManger().getCurrentToken();
        NotificationsManger().initPinpoint(
            credentials: p.AwsClientCredentials(
                accessKey: authSession.credentials!.awsAccessKey!,
                secretKey: authSession.credentials!.awsSecretKey!,
                sessionToken: authSession.credentials!.sessionToken),
            id: currentUser.userId);
        AnalyticsService().setUserId(userId: currentUser.userId);
        AnalyticsService().analytics.logLogin(loginMethod: "phone_number");
        loggedInUserEventAnalytics(device_token: (_token ?? ''), userAttributes: _userAttributes);
        resetauthData();

        // await (Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true))).then((value) async {
        //   CognitoAuthSession authSession = value as CognitoAuthSession;
        //   await Amplify.Auth.getCurrentUser().then((currentUser) async {
        //     userId.value = currentUser.userId;
        //     DeviceDataManager().initDeviceData().then((value) {
        //       DeviceDataManager().sendDeviceDataToBackend();
        //     });
        //     NotificationsManger().getCurrentToken().then((value) {
        //       NotificationsManger().initPinpoint(
        //           credentials: p.AwsClientCredentials(
        //               accessKey: authSession.credentials!.awsAccessKey!,
        //               secretKey: authSession.credentials!.awsSecretKey!,
        //               sessionToken: authSession.credentials!.sessionToken),
        //           id: currentUser.userId);
        //       AnalyticsService().setUserId(userId: currentUser.userId);
        //       AnalyticsService().analytics.logLogin(loginMethod: "phone_number");
        //       loggedInUserEventAnalytics(device_token: (value ?? ''), userAttributes: _userAttributes);
        //     });
        //   });
        // });

        //load user data
        // try {
        //   //it can be already removed so an exception can be thrown
        //   FlutterNativeSplash.remove();
        // } catch (e) {
        //   log(e.toString());
        //   //
        // }
        // profileController.loggedInState.enter();
        // profileController.loggedInState.enter()
        if (_userData.isNotEmpty && (_userData.value['email'] != null || _userData.value['email'].toString().isNotEmpty)) {
          change({'status': AuthControllerStatus.loggedIn}, status: RxStatus.success());
          // ignore: invalid_use_of_protected_member
          RestService.instance.updateProfile(_userData.value);
        }
        profileController.goNextStep(state: profileController.loggedInState);

        //clearAll();
        //profileController.goNextStep(state: profileController.loggedInState);

        //dbg('TEST PATCH RESPONSE\n' + _apiPatchRes.toString());
      },
    );

    stateMachine.onAfterTransition.forEach((event) {
      d.log("TRANSITION  ${event.source?.identifier} -> ${event.target?.identifier}");
      dbg("TRANSITION  ${event.source?.identifier} -> ${event.target?.identifier}", cat: 'STATE', isError: false);
      try {
        AnalyticsEvent analyticsEvent = AnalyticsEvent('events-transitions');
        analyticsEvent.properties.addStringProperty('event-source', event.source?.identifier);
        analyticsEvent.properties.addStringProperty('event-target', event.target?.identifier);
        analyticsEvent.properties.addStringProperty('userEmail', userEmail.value);

        Amplify.Analytics.recordEvent(event: analyticsEvent);
      } catch (error, stackTrace) {
        // Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

        //
        ///
        ///      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
        //Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      }
    });
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  String formateAndStandardizePhoneNumber() {
    //OriginController originController = Get.find<OriginController>();
    String result;
    if (phoneController.value.text.contains('+')) {
      result = phoneController.value.text;
    } else {
      if (phoneController.value.text.isEmpty) {
        if (userPhone.value.contains('+')) {
          result = userPhone.value;
        } else {
          result = (originController.origin_calling_code + userPhone.value);
        }
        return result;
      }
      result = (originController.origin_calling_code + phoneController.value.text.replaceAll(' ', '').replaceAll('-', ''));
    }
    log("=>" + result);
    return result;
  }

  void updateLocaleByDeviceLocale() {
    try {
      Locale deviceLocale = Get.locale!;
      if (deviceLocale.languageCode == 'en') {
        langPreference.value = 'English';
        Get.updateLocale(const Locale('en', 'US'));
      } else {
        langPreference.value = 'French';
        Get.updateLocale(const Locale('fr', 'FR'));
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("from updateLocaleByDeviceLocale: " + error.toString());
    }
  }

  Future<void> loadOriginCountryFromAttriutes() async {
    var userAttibutes = await Amplify.Auth.fetchUserAttributes();
    originController.origin_country_iso.value =
        userAttibutes.where((e) => e.userAttributeKey.key == const CognitoUserAttributeKey.custom('origin_country_iso').key).first.value.toLowerCase();
    originController.origin_country_name.value =
        userAttibutes.where((e) => e.userAttributeKey.key == const CognitoUserAttributeKey.custom('origin_country_name').key).first.value.toLowerCase();
    originController.origin_calling_code.value =
        userAttibutes.where((e) => e.userAttributeKey.key == const CognitoUserAttributeKey.custom('origin_calling_code').key).first.value.toLowerCase();
    getFlinksUrl(origine_iso_code: originController.origin_country_iso.value);
  }

  Future<void> signup() async {
    try {
      Map<CognitoUserAttributeKey, String> userAttributes = {
        CognitoUserAttributeKey.phoneNumber: formateAndStandardizePhoneNumber(),
        CognitoUserAttributeKey.preferredUsername: formateAndStandardizePhoneNumber(),
        CognitoUserAttributeKey.locale: Get.locale!.toString(),
        const CognitoUserAttributeKey.custom('origin_country_iso'): originController.origin_country_iso.toLowerCase(),
        const CognitoUserAttributeKey.custom('origin_country_name'): originController.origin_country_name.toLowerCase(),
        const CognitoUserAttributeKey.custom('origin_calling_code'): originController.origin_calling_code.toLowerCase(),
      };
      d.log('from signup' + formateAndStandardizePhoneNumber());
      /*
      //        var userModel = (await Amplify.DataStore.query(User.classType, where: User.ID.eq(user_auth.userId)))[0];
        this.profileController.userInstance!.update((val) {
          val = userModel;
        });*/

      // log('REGISTER USER');
      // dbg(userAttributes.toString());
      dbg(passwordController.text);
      AnalyticsEvent event = AnalyticsEvent('pre-sign-up');
      event.properties.addStringProperty('userAttributes', userAttributes.values.toList().toString());
      Amplify.Analytics.recordEvent(event: event);

      SignUpResult signupRes = await Amplify.Auth.signUp(
        username: formateAndStandardizePhoneNumber(),
        password: passwordRxController.value.text,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      AnalyticsService().analytics.logSignUp(signUpMethod: "phone_number");
      AnalyticsEvent postSignUpEvent = AnalyticsEvent('post-sign-up');
      event.properties
        ..addStringProperty('userAttributes', userAttributes.values.toList().toString())
        ..addStringProperty('isIOS', Platform.isIOS.toString())
        ..addStringProperty('isSignUpComplete', signupRes.isSignUpComplete.toString())
        ..addStringProperty('signUpStep', signupRes.nextStep.signUpStep)
        ..addStringProperty('additionalInfo', signupRes.nextStep.additionalInfo.toString());
      await Amplify.Analytics.recordEvent(event: postSignUpEvent);
      dbg(signupRes.isSignUpComplete);
      dbg(signupRes.nextStep);
      log(signupRes.isSignUpComplete.toString());
      log(signupRes.nextStep.toString());

      //TODO: implement missing next steps.
      // await this.sendConfirmationCode(username: "+213562135439");
      goNextStep(state: confirmationNeededState);
    } on UsernameExistsException catch (error, stackTrace) {
      AnalyticsEvent event = AnalyticsEvent('sign-up-error');
      event.properties
        ..addStringProperty('phone_number', formateAndStandardizePhoneNumber())
        ..addStringProperty('isIOS', Platform.isIOS.toString())
        ..addStringProperty('password', passwordRxController.value.text)
        ..addStringProperty('error', error.toString())
        ..addStringProperty('stacktrace', stackTrace.toString());

      Amplify.Analytics.recordEvent(event: event);
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      throw SDKException(errorCode: SDKErrorType().authUserExists, exception: error, stackTrace: stackTrace, category: 'ERROR REGISTER');
    } catch (error, stackTrace) {
      AnalyticsEvent event = AnalyticsEvent('sign-up-error');
      event.properties
        ..addStringProperty('phone_number', formateAndStandardizePhoneNumber())
        ..addStringProperty('isIOS', Platform.isIOS.toString())
        ..addStringProperty('password', passwordRxController.value.text)
        ..addStringProperty('error', error.toString())
        ..addStringProperty('stacktrace', stackTrace.toString());

      Amplify.Analytics.recordEvent(event: event);
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      throw SDKException(errorCode: SDKErrorType().signUpFailed, exception: error, stackTrace: stackTrace, category: 'ERROR REGISTER');
    }
  }

  Future<void> redirectToStore() async {
    try {
      String appId = '';
      Json? _appVersionNode = AppUtils.forceUpdate[defaultTargetPlatform.name.toLowerCase()];
      if (_appVersionNode != null) {
        appId = _appVersionNode['app_id'];
      }
      if (TargetPlatform.iOS == defaultTargetPlatform) {
        StoreRedirect.redirect(iOSAppId: appId);
      } else if (TargetPlatform.android == defaultTargetPlatform) {
        StoreRedirect.redirect(androidAppId: appId);
      }
    } catch (error, stackTrace) {
      //TODO handle this
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      dbg(error.toString(), isError: true);
    }
  }

  void startSessionTimer() {
    sessionTimeoutManagerStateStream.add(SessionState.startListening);
  }

  void stopSessionTimer() {
    sessionTimeoutManagerStateStream.add(SessionState.stopListening);
  }

  Future<bool> validateVersion() async {
    bool _isAppNeedUpdate = false;

    // NOTE: get flinks url before login for signup case which will have no country iso i.e. it's blank
    await getFlinksUrl(origine_iso_code: originController.origin_country_iso.value);

    String buildVersion = originController.version.value;
    Rx<String> latestVersion = ''.obs;
    Json? _appVersionNode = AppUtils.forceUpdate[defaultTargetPlatform.name.toLowerCase()];
    if (_appVersionNode != null) {
      latestVersion.value = _appVersionNode['version'] ?? '';
      if (latestVersion.value.isNotEmpty) _isAppNeedUpdate = AlphanumComparator.compare(buildVersion, latestVersion.value) == -1;
      if (_isAppNeedUpdate) {
        //the user needs to be logged out and update the app
        try {
          await openVersionValidationDialog();
          goNextStep(state: loggedOutState);
        } catch (e) {
          Get.offNamed(LandingView.id);
        }
      }
    }
    isAppNeedUpdate.value = _isAppNeedUpdate;
    return _isAppNeedUpdate;
  }

  Future<void> getFlinksUrl({required String origine_iso_code}) async {
    Rx<String> currentLang = 'en'.obs;
    if (Get.locale != null) currentLang.value = Get.locale!.languageCode.toLowerCase();

    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    //
    //var token = await getToken();
    String api = dotenv.env['API_URL']!;
    try {
      var response = await getConnect.get("$api/flinks/iframe?country=${origine_iso_code.toUpperCase()}&language=${currentLang.value}");
      final String receivedJson = response.bodyString!;
      d.log(receivedJson);
      final Map<String, dynamic> data = json.decode(receivedJson);
      flinksUrl.value = data['iframe_url'];
    } catch (e, stackTrace) {
      d.log('from getFlinksUrl :' + e.toString());
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
    }
    //v1/flinks/iframe?country=US&language=fr
  }

  @override
  Future<void> login({
    required String username,
    required String password,
  }) async {
    try {
      // TODO: Validate IF after authStatus updates
      //await logout();
      // await Amplify.Auth.signIn(username: username, password: password);
      // NOTE: This is an alternative to fix the amplify auth sign-in issue in iOS only (Android doesn't have the issue) which needs to trigger the User Migragion lambda to migrate the old user accounts to the Xemo Cognito Users Pool. Once Amplify iOS fixes the library, we can remove this line.
      //String apiUrl = dotenv.env['API_URL']!;
      try {
        //  await RestService.instance.init(apiUrl: apiUrl);

        var response = await RestService.instance.migrateAccount(username, password);
        // log(response.toString());
      } catch (e, stackTrace) {
        Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

        log(e.toString());
      }

      // This signIn requires USER_SRP_AUTH set in amplifyconfiguration.dart, Once Amplify iOS fixes the library (to support USER_PASSWORD_AUTH), then we can remove the line above and update the auth type in the amplifyconfiguration.dart to USER_PASSWORD_AUTH.
      //await logout();
      await Amplify.Auth.signIn(username: username, password: password);

      var _myService = Get.find<AmplifyService>();
      await _myService.updateAuth();
    } on UserNotConfirmedException {
      // TODO: refactor this to use SDKException
      throw AuthUserNotConfirmed();
    } catch (error, stackTrace) {
      //UserNotFoundException
      //CodeMismatchException
      //CodeDeliveryFailureException
      //InvalidParameterException
      //AuthException
      goNextStep(state: loggedOutState);
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      throw SDKException(errorCode: SDKErrorType().loginFailed, exception: error, stackTrace: stackTrace, category: 'ERROR LOGIN');
    }
  }

  Future<void> confirmSignUp() async {
    try {
      log('CONFIRM USER ACCOUNT');
      log({'username': "${phoneController.value.text}	", 'confirmationCode': confirmCodeController.text});
      String _username = formateAndStandardizePhoneNumber();
      SignUpResult confirmRes = await Amplify.Auth.confirmSignUp(username: _username, confirmationCode: confirmCodeController.text);
      dbg(confirmRes.isSignUpComplete);
      dbg(confirmRes.nextStep);
      log('LOGGING IN AFTER CONFIRM');
      isSignUpFlow.value = true;

      await login(
        username: _username,
        password: passwordRxController.value.text,
      );
      //
      // await saveUserIntoDataStore();
      // await triggerKycVerification();
      //clearAll();
      //save data in datastore
    } catch (error, stackTrace) {
      AnalyticsEvent event = AnalyticsEvent('confirm-sign-up-error');
      event.properties
        ..addStringProperty('phone_number', formateAndStandardizePhoneNumber())
        ..addStringProperty('code', confirmCodeController.text)
        ..addStringProperty('password', passwordRxController.value.text)
        ..addStringProperty('error', error.toString())
        ..addStringProperty('stacktrace', stackTrace.toString());
      await Amplify.Analytics.recordEvent(event: event);
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      if (Get.isOverlaysOpen) {
        Get.back(); // Removes loading dialog
      }
      throw SDKException(errorCode: SDKErrorType().confirmSignUpFailed, exception: error, stackTrace: stackTrace, category: 'ERROR CONFIRM ACCOUNT');
    }
  }

  Future<void> updateUserAttributes() async {
    try {
      Map<CognitoUserAttributeKey, String> userAttributes = {
        CognitoUserAttributeKey.email: emailRxController.value.text,
        CognitoUserAttributeKey.givenName: firstNameRxController.value.text,
        CognitoUserAttributeKey.familyName: lastNameRxController.value.text,
        CognitoUserAttributeKey.locale: Get.locale!.toString()
      };
      userAttributes.forEach((key, value) async {
        try {
          await Amplify.Auth.updateUserAttribute(userAttributeKey: key, value: value);
        } catch (e) {
          log("updateUserAttributes:forEeach : " + e.toString());
        }
      });
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log('from updateUserAttributes ' + error.toString());
    }
  }

  Future<void> saveUserIntoDataStore() async {
    try {
      //await Amplify.DataStore.start();
      //
      //OriginController originController = Get.find<OriginController>();
      //save user data into datastore
      //first we get current user from auth to get the id
      Rx<int> kyc_level = 0.obs;
      Rx<UserBankVerificaitonStatus> userBankVerificationStatus = UserBankVerificaitonStatus.NOT_VERIFIED.obs;
      if (FlinksResultStatus.successful == flinksResultStatus.value) {
        kyc_level.value = 1;
        userBankVerificationStatus.value = UserBankVerificaitonStatus.VERIFIED;
      }
      var user_auth = await Amplify.Auth.getCurrentUser();
      await updateUserAttributes();
      var birthdata =
          BirthDate(id: user_auth.userId, date_of_birth: TemporalDateTime(dob.value!), birth_country: countryOfBirth.value, birth_city: cityOfBirth.value.text);
      var identity = IdentityDocument(
          id: user_auth.userId, type: documentIdType!.value!, number: (documentIdNumber.value.text), expiration_date: TemporalDateTime(documentExpDate.value!));

      //TODO country should be origin country
      var address = Address(
        id: user_auth.userId,
        address_line_1: fullAddressController.value.text.trim(),
        address_line_2: '',
        state: '',
        city: cityController.value.text.trim(),
        postal_code: zipCodeController.value.text.trim(),
      );

      // await Amplify.DataStore.save(birthdata);
      // await Amplify.DataStore.save(identity);
      // await Amplify.DataStore.save(address);
      var birth_result = await AppBirthDate().save(data: birthdata.toJson());
      d.log('birthdata saved');

      var identity_result = await AppIdentity().save(data: identity.toJson());
      d.log('identity saved');

      var address_result = await AppAddress().save(data: address.toJson());
      d.log('address saved');
      //
      //
      Profile profile = Profile(
        id: user_auth.userId,
        first_name: firstNameRxController.value.text.trim(),
        last_name: lastNameRxController.value.text.trim(),
        gender: gender.value!,
        country: originController.origin_country_name.toUpperCase(),
        birth_date: birthdata,
        address: address,
        identity_document: identity,
        addressID: address.id,
        birth_dateID: birthdata.id,
        identity_documentID: identity.id,
      );
      // await Amplify.DataStore.save(profile);
      var profile_result = await AppProfile().save(data: profile.toJson());
//
      User user = User(
          id: user_auth.userId,
          email: emailRxController.value.text.trim(),
          profile: profile,
          profileID: profile.id,
          address_books: [],
          global_transactions: [],
          phone_number: formateAndStandardizePhoneNumber(),
          origin_calling_code: originController.origin_calling_code.value.toLowerCase(),
          origin_country_iso: originController.origin_country_iso.value.toLowerCase(),
          newsletter_subscription: isSubscribedToNewsLetter.value,
          occupation: occupationRxController.value.text.trim(),
          bank_verification_status: userBankVerificationStatus.value,
          user_status: GenericStatus.ACTIVE,
          kyc_level: kyc_level.value);
      var user_result = await AppUser().save(data: user.toJson());
      // await Amplify.DataStore.save(user);
      //await Amplify.DataStore.start();
      user = user.copyWith(id: user_result!.id);
      if (loginId.value.isNotEmpty) {
        Future.delayed(const Duration(seconds: 5)).then((v) {
          //sendBankVerificationApiRequest(user);
        });
      }
      profileController.userInstance = Rx(user);
      profileController.userInstance!.value = user;
      //clearAll();
      profileController.loggedInState.enter();
      updateMeEndpoint();
      if ((FlinksResultStatus.pending == flinksResultStatus.value) || (FlinksResultStatus.successful == flinksResultStatus.value)) {
        userBankVerifyAssignUser();
      }
      Future.delayed(const Duration(seconds: 5)).then((value) => clearAll());
      //Get.offAllNamed(HomeView.id);
    } catch (error, stackTrace) {
      //TODO handle exceptions
      AnalyticsEvent event = AnalyticsEvent('saveUserIntoDataStoreError');
      event.properties
        ..addStringProperty('email', emailRxController.value.text.trim())
        ..addStringProperty('error', error.toString());
      await Amplify.Analytics.recordEvent(event: event);
      if (Get.isOverlaysOpen) {
        Get.back();
      }
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
    }
  }

  Future<void> saveUserType({required String userType}) async {
    try {
      //await AppUser().setProfileKey(key: 'userType', value: userType);
    } catch (error) {
      if (error.runtimeType == UnknownErrorAmplifyException) {
        rethrow;
      } else {
        throw UnknownErrorAmplifyException(error.toString());
      }
    }
  }

  Future<void> updateMeEndpoint() async {
    try {
      Json _apiGetRes = await RestService.instance.getProfile();

      var _userAttributes = await Amplify.Auth.fetchUserAttributes();
      Map<String, String> propertyMap = {'given_name': 'first_name', 'family_name': 'last_name', 'email': 'email', 'phone_number': 'phone_number'};
      for (var attribute in _userAttributes) {
        String _attrKey = attribute.userAttributeKey.key;
        dynamic _attrVal = attribute.value;
        String? _profileKey = propertyMap[_attrKey];
        if (_profileKey != null && _attrVal != _apiGetRes[_profileKey]) {
          _userData.value[_profileKey] = _attrVal;
        }
        if (_profileKey == 'first_name') {
          userFirstName.value = _attrVal;
        }
        if (_profileKey == 'last_name') {
          userLastName.value = _attrVal;
        }
        if (_profileKey == 'email') {
          userEmail.value = _attrVal;
        }
      }
      Json _apiPatchRes = await RestService.instance.updateProfile(_userData.value);
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log(error.toString());
    }
  }

  int currentCarousselIndex = 0;
  int carousselLength = 3;
  void goToNextCarousselItem() {
    if (currentCarousselIndex < carousselLength) {
      currentCarousselIndex++;
    } else {
      currentCarousselIndex = 0;
    }
    update();
  }

  Future<void> setLoginIdFromUrl(String url, bool fromRegister) async {
    try {
      //url.split('loginId')[1].split('=')[1].split('&').first
      loginId.value = url.split('loginId')[1].split('=')[1].split('&').first;
      accountId.value = url.split('accountId')[1].split('=')[1].split('&').first;

      //in case its a call from register flow
      d.log(loginId.value);
      if (fromRegister) {
        await sendBankVerificationApiRequest(profileController.userInstance!.value);
        //Get.offNamed(AuthRegisterUserInfosView.id);
      } else {
        Get.offAllNamed(HomeView.id);
        if (Get.isOverlaysOpen) {
          Get.back();
        }
        await sendBankVerificationApiRequest(profileController.userInstance!.value);
      }
    } catch (e) {
      loginId.value = '';
      d.log(e.toString());
      dbg(e.toString(), isError: true);
    }
  }

  Future<void> sendBankVerificationApiRequest(User user) async {
    // SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    BankVerificationEntity bankVerificationEntity = BankVerificationEntity(user: user, ip: '', loginId: loginId.value, accountId: accountId.value);
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    //
    Map<String, String>? _headers;
    if (!isSignUpFlow.value) {
      var token = await getToken();

      _headers = {
        'Authorization': 'Bearer $token', //sign u
        'Content-Type': 'application/json',
      };
    } else {
      _headers = {
        'Content-Type': 'application/json',
      };
    }
    //
    //d.log(bankVerificationEntity.toJson().toString());
    try {
      var response = await getConnect.post("${sendMoneyController.api}/user-bank-verify/", bankVerificationEntity.toJson(), headers: _headers);
      if (response.statusCode == 201 && !isSignUpFlow.value) {
        //response.bodyString!
        final String receivedJson = response.bodyString!;
        //  '{"user_data": {"first_name": "ddd", "last_name": "ggg", "address_1": "hhhh", "city": "vvv", "state": "ddd", "zip_code": "F4F 4G4", "email": "gggdd@gmail.com", "phone_number": ""},"verified": "True"}';

        final Map<String, dynamic> data = json.decode(receivedJson);
        if (data['verified'] == 'True') {
          UserBankVerifyResponse userBankVerifyResponse = UserBankVerifyResponse.fromJson(data);
          setUserFormsByUserBankVerifyResponseData(userBankVerifyResponse);
          bankRequestUUID.value = data['uuid'];
          flinksResultStatus.value = FlinksResultStatus.successful;
          Get.offAllNamed(FlinksSuccessView.id);
        } else if (data['verified'] == 'False') {
          bankRequestUUID.value = data['uuid'] ?? '';
          flinksResultStatus.value = FlinksResultStatus.failed;
          Get.offAllNamed(FlinksFailedView.id);
        } else if (data['verified'] == 'Pending') {
          bankRequestUUID.value = data['uuid'];
          flinksResultStatus.value = FlinksResultStatus.pending;
          Get.offAllNamed(FlinksPendingView.id);
        }
      }
      d.log(response.statusCode.toString());
    } catch (e) {
      log(e.toString());
      dbg(e.toString(), isError: true);
    }
  }

  Future<void> userBankVerifyAssignUser() async {
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    //
    var token = await getToken();
    try {
      var response = await getConnect.post("${sendMoneyController.api}/user-bank-verify/${bankRequestUUID.value}/assign-user/", {}, headers: {
        'Authorization': 'Bearer $token', //sign u
        'Content-Type': 'application/json',
      });
    } catch (e) {
      //
    }
  }

  void setUserFormsByUserBankVerifyResponseData(UserBankVerifyResponse userBankVerifyResponse) {
    firstNameRxController.value.text = 'userBankVerifyResponse.firstName!';
    lastNameRxController.value.text = userBankVerifyResponse.lastName!;
    fullAddressController.value.text = userBankVerifyResponse.address_1!;
    zipCodeController.value.text = userBankVerifyResponse.zipCode!;
    cityController.value.text = userBankVerifyResponse.city!;
    emailRxController.value.text = userBankVerifyResponse.email!;
  }

  void setInitialDataForEditProfile() {
    User user = profileController.userInstance!.value;
    phoneController.value.text = (user.phone_number.substring(originController.origin_calling_code.value.length));
    occupationRxController.value.text = user.occupation;
    emailRxController.value.text = user.email;
  }

  Future<void> updateProfile() async {
    User user = profileController.userInstance!.value;

    await Amplify.Auth.updateUserAttribute(userAttributeKey: CognitoUserAttributeKey.email, value: emailRxController.value.text);

    if (user.phone_number == phoneController.value.text) {
      //no updating username and phone_number
      User updatedUser = user.copyWith(
          occupation: occupationRxController.value.text, email: emailRxController.value.text, newsletter_subscription: isSubscribedToNewsLetter.value);
      await AppUser().save(data: updatedUser.toJson());

      profileController.userInstance!.value = updatedUser;
    } else {
      //update
      //update datastore data
      User updatedUser = user.copyWith(
          occupation: occupationRxController.value.text, email: emailRxController.value.text, newsletter_subscription: isSubscribedToNewsLetter.value);
      await AppUser().save(data: updatedUser.toJson());

      profileController.userInstance!.value = updatedUser;
    }
    await triggerKycVerification();
    _userData.value['email'] = emailRxController.value.text;
    await RestService.instance.updateProfile(_userData.value);

    //TODO api call to notify the backend for kyc verification again
  }

  Future<void> getAppVersionsDataFromApi() async {
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);

    try {
      var response = await getConnect.get("${RestService.instance.url}/init/");
      d.log("from getAppVersionsDataFromApi => " + RestService.instance.url);
      if (response.statusCode == 200) {
        String receivedJson = response.bodyString!;
        AppUtils.init(jsonDecode(receivedJson));
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      //log("from triggerKycVerification" + error.toString());
      // log("from triggerKycVerification" + error.toString());
    }
  }

  Future<void> triggerKycVerification() async {
    try {
      //  SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
      //   ProfileController profileController = Get.find<ProfileController>();
      GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
      UserSnapshotEntity userSnapshotEntity =
          UserSnapshotEntity(origin_iso_code: originController.origin_country_iso.value, user: profileController.userInstance!.value);
      //token
      var token = await getToken();

      try {
        var response = await getConnect.post("${RestService.instance.url}/kyc-verify/", userSnapshotEntity.toJson(), headers: {
          'Authorization': 'Bearer $token', //sign u
          'Content-Type': 'application/json',
        });
        //log('from triggerKycVerification' + response.statusCode.toString());
        log("from triggerKycVerification response " + response.body.toString());
      } catch (e) {
        //dbg(e.toString(), isError: true);
        // log("from triggerKycVerification" + e.toString());
        log("from triggerKycVerification" + e.toString());
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log(error.toString());
    }
  }

  Future<void> updatePassword() async {
    await Amplify.Auth.updatePassword(
      oldPassword: passwordRxController.value.text,
      newPassword: newPasswordController.value.text,
    );
  }

  Future<void> disconnect() async {
    try {
      await logout();
      //await Amplify.DataStore.clear();
      Get.offAllNamed(LandingView.id);
      profileController.goNextStep(state: profileController.loggedOutState);
      clearData();
      clearForms();
      userEmail.value = '';
      userFirstName.value = '';
      userEmail.value = '';
      userPhone.value = '';
      userId.value = '';
      sendMoneyController.loggedOutState.enter();
    } catch (e) {
      log(e.toString());
      clearData();
      clearForms();
      sendMoneyController.loggedOutState.enter();
    }
  }

  Future<void> resetPassword() async {
    try {
      String phone_number = (originController.origin_calling_code.value + phoneController.value.text);

      await Amplify.Auth.confirmResetPassword(
          username: formateAndStandardizePhoneNumber(),
          newPassword: newPasswordController.value.text,
          confirmationCode: confirmPassResetCodeController.value.text);
    } catch (error, stackTrace) {
      //error
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      dbg(error.toString());
    }
  }

  Future<void> loggedInUserEventAnalytics({required String device_token, required List<AuthUserAttribute> userAttributes}) async {
    try {
      var user = await Amplify.Auth.getCurrentUser();
      String userId = user.userId;
      String fname = '';
      String lname = '';
      String email = '';
      String phone_number = '';
      if (userAttributes.any((element) => element.userAttributeKey == CognitoUserAttributeKey.familyName)) {
        fname = userAttributes.where((e) => e.userAttributeKey == CognitoUserAttributeKey.familyName).first.value;
      }
      if (userAttributes.any((element) => element.userAttributeKey == CognitoUserAttributeKey.givenName)) {
        lname = userAttributes.where((e) => e.userAttributeKey == CognitoUserAttributeKey.givenName).first.value;
      }
      if (userAttributes.any((element) => element.userAttributeKey == CognitoUserAttributeKey.email)) {
        email = userAttributes.where((e) => e.userAttributeKey == CognitoUserAttributeKey.email).first.value;
      }
      if (userAttributes.any((element) => element.userAttributeKey == CognitoUserAttributeKey.phoneNumber)) {
        phone_number = userAttributes.where((e) => e.userAttributeKey == CognitoUserAttributeKey.phoneNumber).first.value;
      }
      //
      AnalyticsUserProfile userProfile = AnalyticsUserProfile();
      AnalyticsProperties userProperties = AnalyticsProperties();
      userProfile.name = (fname + ' ' + lname);
      userProfile.email = email;
      //
      //
      if (Platform.isAndroid) {
        List<String> token_into_parts = get100LengthOfStrings(device_token);
        for (var i = 0; i < token_into_parts.length; i++) {
          userProperties.addStringProperty('device_token_android_$i', token_into_parts[i]);
        }
        userProperties.addIntProperty('device_token_android_array_length', token_into_parts.length);
      }
      if (Platform.isIOS) {
        List<String> token_into_parts = get100LengthOfStrings(device_token);
        for (var i = 0; i < token_into_parts.length; i++) {
          userProperties.addStringProperty('device_token_ios_$i', token_into_parts[i]);
        }
        userProperties.addIntProperty('device_token_ios_array_length', token_into_parts.length);
      }
      //
      //
      userProperties.addStringProperty('phone_number', phone_number);
      userProfile.properties = userProperties;
      await Amplify.Analytics.identifyUser(userId: userId, userProfile: userProfile);
      log("loggedInUserEventAnalytics " + device_token.toString());
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log('from loggedInUserEventAnalytics ' + error.toString());
    }
  }

  List<String> get100LengthOfStrings(String token) {
    List<String> result = [];
    int index = 0;
    String part = ''; //contains 100length string
    if (token.length <= 100) {
      result.add(token);
      return result;
    }

    //
    //
    for (var i = 0; i < token.length; i++) {
      if (index == 100) {
        index = 0;
        result.add(part);
        part = '';
      }
      part = part + token[i];
      index++;
    }
    if (!result.contains(part)) {
      result.add(part);
    }
    return result;
  }

  void clearForms() {
    documentIdNumber.value.text = '';
    occupationRxController.value.text = '';
    zipCodeController.value.text = '';
    cityController.value.text = '';
  }

  void clearData() {
    try {
      phoneController.value.text = '';
      passwordRxController.value.text = '';
      newPasswordController.value.text = '';
      // Start the session timer when go back to previous page
      AuthController _authController = Get.find<AuthController>();
      _authController.startSessionTimer();
    } catch (e) {
      //setState() or markNeedsBuild() called during build exception start from here
      log(e.toString());
    }
  }

  Future<bool> isPhoneNumberUnique() async {
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    try {
      var phoneWithCountryCode = formateAndStandardizePhoneNumber();
      if (phoneController.value.text.isEmpty) {
        return false;
      }
      var response = await getConnect.post(dotenv.env['LAMBDA_USERNAME_URL']!, {"phone_number": phoneWithCountryCode});
      log(response.body);
      int numberResult = (response.body) as int;
      if (numberResult == 0) {
        return true;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log(e.toString());
      return false;
    }
  }

  void resetLoginData() {
    //Todo handle setState() or markNeedsBuild() called during build. error
    //TODO find the real issue
    try {
      // phoneController.value.text = '';

      passwordRxController.value.text = '';
      newPasswordController.value.text = '';
      confirmPasswordController.value.text = '';
    } catch (e) {
      log(e.toString());
    }
  }

  void resetauthData() {
    //Todo handle setState() or markNeedsBuild() called during build. error
    //TODO find the real issue
    try {
      phoneController.value.text = '';

      passwordRxController.value.text = '';
      newPasswordController.value.text = '';
      confirmPasswordController.value.text = '';
    } catch (e) {
      log(e.toString());
    }
  }

  void resetChangePasswordData() {
    //Todo handle setState() or markNeedsBuild() called during build. error
    //TODO find the real issue
    try {
      // phoneController.value.text = '';

      passwordRxController.value.text = '';
      newPasswordController.value.text = '';
      confirmPasswordController.value.text = '';
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> isEmailUnique() async {
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    try {
      if (emailRxController.value.text.isEmpty) {
        return false;
      }
      var response = await getConnect.post(dotenv.env['LAMBDA_EMAIL_URL']!, {"email": emailRxController.value.text});

      //prod lambd https://o4xiz4ob5oxh2so6brspuwdji40cyher.lambda-url.us-west-1.on.aws/
      //dev lambda https://aibc3zspu4q3nry4zkna47j5re0wextq.lambda-url.us-west-1.on.aws/

      log(response.statusCode);
      int numberResult = (response.body) as int;
      if (numberResult == 0) {
        return true;
      } else {
        return false;
      }
    } catch (e, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');

      log(e.toString());
      return false;
    }
  }
//    _cognitoSession.userSub;

  Future<String> getToken() async {
    var _cognitoSession = (await Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true))) as CognitoAuthSession;
    String? token = _cognitoSession.userPoolTokens?.accessToken;
    return (token ?? '');
  }

  Future<String> getSub() async {
    var _cognitoSession = (await Amplify.Auth.fetchAuthSession(options: CognitoSessionOptions(getAWSCredentials: true))) as CognitoAuthSession;
    String? sub = _cognitoSession.userSub;
    return (sub ?? '');
  }

  Future<void> blockUserRequest() async {
    GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
    //token
    String sub = await getSub();
    String token = await getToken();
    var response = await getConnect.post("${RestService.instance.url}/block-user", {
      "user_id": sub
    }, headers: {
      'Authorization': 'Bearer $token', //sign u
      'Content-Type': 'application/json',
    });
    log('from blockUserRequest' + response.statusCode.toString());
    log("from blockUserRequest response " + response.body.toString());
  }

  Future<void> deleteAccount() async {
    //await Amplify.DataStore.save(profileController.userInstance!.value.copyWith(user_status: GenericStatus.BLOCKED));
    //await Amplify.Auth.deleteUser();
    await blockUserRequest();
    await logout();
    Get.offNamed(LandingView.id);

    //await deleteAccount();
    //remove data
    //remove user data
    //await Amplify.DataStore.delete(profileController.userInstance!.value);
    //remove profile
    //await Amplify.DataStore.delete(profileController.userInstance!.value.profile!);
    //remove address
    //await Amplify.DataStore.delete(profileController.userInstance!.value.profile!.address!);
    //remove bdata
    //await Amplify.DataStore.delete(profileController.userInstance!.value.profile!.birth_date!);
    //remove identity_document
    //await Amplify.DataStore.delete(profileController.userInstance!.value.profile!.identity_document!);
    //remove transactions
    // ignore: invalid_use_of_protected_member
    //for (var element in profileController.globalTransactions!.value) {
    //  await Amplify.DataStore.delete(element);
    //  for (var e in (element.collect_transactions ?? [])) {
    //     await Amplify.DataStore.delete<CollectTransaction>(e);
    //  }
    //  await Amplify.DataStore.delete(element.parameters!);
    // }
    //remove addressBooks
    // ignore: invalid_use_of_protected_member
    //for (var element in profileController.addressBooks!.value) {
    //   await Amplify.DataStore.delete(element);
    //}

    //
    //disconnect();
  }

  //clear forms
  void clearAll() {
    try {
      clearIdentityForm();
      clearUserInfoForm();
      clearPhoneField();
      clearAddressForm();
      clearEmailAndPasswordForms();
    } catch (e) {
      //
      //
    }
  }

  void clearIdentityForm() {
    documentIdType!.value = null;
    documentIdNumber.value.text = '';
    documentExpDate.value = null;
    occupationRxController.value.text = '';
    countryOfBirth.value = '';
    cityOfBirth.value.text = '';
  }

  void clearUserInfoForm() {
    firstNameRxController.value.text = '';
    lastNameRxController.value.text = '';
    dob.value = null;
    gender.value = null;
  }

  void clearAddressForm() {
    fullAddressController.value.text = '';
    zipCodeController.value.text = '';
    cityController.value.text = '';
  }

  void clearEmailAndPasswordForms() {
    emailRxController.value.text = '';
    confirmEmailController.value.text = '';
    passwordRxController.value.text = '';
    confirmPasswordController.value.text = '';
  }

  void clearPhoneField() {
    phoneController.value.text = '';
  }
}
