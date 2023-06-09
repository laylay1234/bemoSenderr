import 'dart:developer';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_models/app_addressBook.dart';
import 'package:mobileapp/app_models/app_transaction.dart';
import 'package:mobileapp/models/ModelProvider.dart';

import '../utils/error_alerts_utils.dart';

//this helper class is to manage the nested data problem (amplify flutter limitations)
//
class ApiHelper {
  static final ApiHelper _instance = ApiHelper._internal();
  ApiHelper._internal();
  factory ApiHelper() => _instance;

  Future<List<AddressBook>> getCompleteAddressBooks(String userId) async {
    List<AddressBook> result = [];
    result = (await AppAddressBook().listAddressBooks(userId: userId)) ?? [];
    return result;
  }

  Future<List<AddressBook>> getCompleteAddressBooksByIds(List<String> ids) async {
    List<AddressBook> result = [];

    for (var id in ids) {
      try {
        var tmp = (await AppAddressBook().getAddressBookById(id: id));
        if (tmp != null) {
          if (tmp.removed == false) {
            result.add(tmp);
          }
        }
      } catch (error, stackTrace) {
        Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
        log('getCompleteAddressBooksByIds ' + error.toString());
      }
    }
    return result;
  }

  Future<List<GlobalTransaction>> getCompleteGlobalTransactions(String userId) async {
    List<GlobalTransaction> result = [];
    try {
      result = (await AppTransaction().listTransactions(userId: userId)) ?? [];
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
    }
    return result;
  }
}
