// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

// ignore: implementation_imports
import 'package:flutter/src/widgets/navigator.dart';
import 'package:flutter_amplifysdk/controllers/generic.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_amplifysdk/utils/rest_service/rest_service.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';

import '../entities/user_limit_entity.dart';
import '../utils/error_alerts_utils.dart';

enum LimitErrors {
  NONE, // no errors
  MIN, //we use this when the amount is lower than the limit
  TX_LIMIT_ERROR, //when the user input is greater than the tx limit
  REMAIN_LIMIT_ERROR, // when the user input is greater than the available(remaining monthly or quarterly or yearl) limit
}

class TransactionController extends GenericController {
  GetConnect getConnect = GetConnect(timeout: RestService.instance.timeout);
  //
  Rx<String> minValue = ''.obs;
  Rx<LimitErrors> limitError = LimitErrors.NONE.obs;
  Rx<UserLimitEntity> userLimitsEntity = UserLimitEntity().obs;
  Rx<bool> isTransactionAllowed = false.obs;

  //controllers getters
  SendMoneyController get sendMoneyController {
    return Get.find<SendMoneyController>();
  }

  AuthController get authController {
    return Get.find<AuthController>();
  }

  OriginController get originController {
    return Get.find<OriginController>();
  }

  ProfileController get profileController {
    return Get.find<ProfileController>();
  }

  //methods and functions
  Future<void> loadUserLimits() async {
    String api = sendMoneyController.api;
    String token = await authController.getToken();
    try {
      //log('check:' + token);
      Response response = await getConnect.post("$api/get-user-max-tx-value", {
        'kyc_level': profileController.userInstance!.value.kyc_level.toString(),
        'origin_currency': sendMoneyController.originCurrency.value!.iso_code.toUpperCase()
      }, headers: {
        'Authorization': 'Bearer $token', //sign u
        'Content-Type': 'application/json',
      });
      // log(response.statusCode);
      if (response.statusCode == 200) {
        // log("response is :" + response.body);
        // Map<String, String> data = jsonDecode(response.bodyString!);
        final myMap = Map<String, String>.from(response.body);
        userLimitsEntity.value = UserLimitEntity.fromJson(myMap);
        log(userLimitsEntity.value.isValid());
      } else {
        isTransactionAllowed.value = false;
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("here?" + error.toString());
    }
  }

  double handleAmountInput(String amount) {
    try {
      double amount_sent;
      if (amount.isEmpty) {
        return 0;
      }
      if (RegExp(r'(\s|[0-9]|e|π)$').hasMatch(amount)) {
        double? result = double.tryParse(amount);
        if (result != null) {
          return result;
        }
        //TODO handle this case
        return 0;
      } else {
        return 0;
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("handleAmountInput: " + error.toString());
      return 0;
    }
  }

  void checkAndHandleTransactionLimitsByUserInput() {
    try {
      double user_amount = handleAmountInput(sendMoneyController.sendEditingController.value.text);
      double tx_max = double.parse(userLimitsEntity.value.tx_max!);
      double yearly_max = double.parse(userLimitsEntity.value.yearly_max!);
      double monthly_max = double.parse(userLimitsEntity.value.monthly_max!);
      double quarterly_max = double.parse(userLimitsEntity.value.quarterly_max!);
      log("=>" + sendMoneyController.sendEditingController.value.text);
      if (user_amount > tx_max) {
        limitError.value = LimitErrors.TX_LIMIT_ERROR;
        isTransactionAllowed.value = false;
        return;
      }
      if (user_amount > monthly_max) {
        limitError.value = LimitErrors.REMAIN_LIMIT_ERROR;
        isTransactionAllowed.value = false;
        return;
      }
      if (user_amount > yearly_max) {
        limitError.value = LimitErrors.REMAIN_LIMIT_ERROR;
        isTransactionAllowed.value = false;
        return;
      }
      if (user_amount > quarterly_max) {
        limitError.value = LimitErrors.REMAIN_LIMIT_ERROR;
        isTransactionAllowed.value = false;
        return;
      }
      if (checkIfIsLessThanMinTransactionValue(user_amount)) {
        limitError.value = LimitErrors.MIN;
        isTransactionAllowed.value = false;
        return;
      }
      //transaction is allowed , user's amount is allowed and validate all conditions
      limitError.value = LimitErrors.NONE;
      isTransactionAllowed.value = true;
      return;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      //probably parsing error (when parsing string to double)
      log("from checkAndHandleTransactionLimitsByUserInput" + error.toString());
    }
  }

  //
  bool checkIfIsLessThanMinTransactionValue(double user_amount) {
    // String minValue;
    Map<String, dynamic> appSettings = profileController.appSettings as Map<String, dynamic>;
    var appData = appSettings['minTransactionValue'] as Map<String, dynamic>;
    if (appData.containsKey(originController.origin_country_iso.toUpperCase())) {
      minValue.value = appData[originController.origin_country_iso.toUpperCase()];
    } else {
      minValue.value = appData['default'];
    }
    double minValueStandard = double.parse(minValue.value);
    if (user_amount >= minValueStandard) {
      //accepted
      return false;
    } else {
      return true;
    }
    //
    //
  }

  //functions and methods from the super class
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
