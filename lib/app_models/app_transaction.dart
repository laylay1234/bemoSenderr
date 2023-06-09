import 'dart:developer';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_amplifysdk/errors.dart';
import 'package:flutter_amplifysdk/models/generic_user.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:get/get.dart';
import 'package:mobileapp/errors.dart';

import '../models/ModelProvider.dart';
import '../utils/utils.dart';
import 'app_mixin.dart';

class AppTransaction extends GenericUser with Status {
  static final AppTransaction _appUser = AppTransaction._internal();

  factory AppTransaction() => _appUser;

  AppTransaction._internal() {
    primaryClassType = GlobalTransaction.classType;
    primaryModelName = 'GlobalTransaction';
    primaryIdField = GlobalTransaction.ID;
    primaryRelations = {};
  }

  @override
  Model createModel<T extends Model>({required Json data, String? modelName}) {
    Model _myObject;
    // data['status'] = castGenericStatus(data['status']);
    if (modelName == null || modelName == 'GlobalTransaction') {
      _myObject = GlobalTransaction(
          collect_transactions: List.from(data['collect_transactions'] ?? []).map((e) => CollectTransaction.fromJson(e)).toList(),
          collect_date: TemporalDateTime.now(),
          created_at: TemporalDateTime.now(),
          funding_date: TemporalDateTime.now(),
          user: User.fromJson(data['user']),
          receiver: AddressBook.fromJson(data['receiver']),
          parameters: Parameters.fromJson(data['parameters']),
          parametersID: data['parametersID'],
          status: (enumFromString(data['status']!.toString(), GlobalTransactionStatus.values) as GlobalTransactionStatus));
    } else {
      dbg('We did not find the model');
      throw UnknownErrorAmplifyException('model-not-found'.tr);
    }
    return _myObject;
  }

  Future<List<GlobalTransaction>?> listTransactions({required String userId}) async {
    List<GlobalTransaction> result = [];
    try {
      String grapQlDocument = '''
          query listGlobalTransactionsQuery (\$filter: ModelGlobalTransactionFilterInput, \$limit: Int, \$nextToken: String){
            listGlobalTransactions (filter: \$filter, limit: \$limit, nextToken: \$nextToken){
            items {
                  collect_date
                  createdAt
                  created_at
                  funding_date
                  id
                  userID
                  updatedAt
                  status
                  receiverID
                  parametersID
                  owner
                  collect_transactions {
                    items {
                      updatedAt
                      status
                      partner_name
                      img_urls
                      id
                      globalTransactionID
                      createdAt
                      collect_code
                    }
                    nextToken
                  }
                  parameters {
                    amount_destination
                    amount_origin
                    applicable_rate
                    collect_method
                    collect_method_fee
                    createdAt
                    currency_destinationID
                    currency_originID
                    destination_countryID
                    funding_method
                    id
                    updatedAt
                    transfer_reason
                    total
                    owner
                    origin_countryID
                    currency_destination {
                      updatedAt
                      sign
                      short_sign
                      name
                      iso_code
                      id
                      createdAt
                    }
                    currency_origin {
                      updatedAt
                      sign
                      short_sign
                      name
                      id
                      iso_code
                      createdAt
                    }
                    destination_country {
                      updatedAt
                      name
                      id
                      iso_code
                      enabled_as_origin
                      enabled_as_destination
                      createdAt
                      calling_code
                      active
                    }
                    origin_country {
                      updatedAt
                      name
                      iso_code
                      id
                      enabled_as_origin
                      enabled_as_destination
                      calling_code
                      createdAt
                      active
                    }
                  }
                  receiver {
                    account_number
                    addressID
                    bank_swift_code
                    createdAt
                    first_name
                    gender
                    language
                    id
                    last_name
                    mobile_network
                    owner
                    phone_number
                    removed
                    address {
                      updatedAt
                      state
                      postal_code
                      id
                      createdAt
                      countryID
                      country {
                          updatedAt
                          name
                          id
                          iso_code
                          enabled_as_origin
                          enabled_as_destination
                          createdAt
                          calling_code
                          active
                      }
                      city
                      address_line_2
                      address_line_1
                      owner
                    }
                    userID
                  }
                  user {
                    profileID
                    phone_number
                    owner
                    origin_country_iso
                    origin_calling_code
                    occupation
                    newsletter_subscription
                    kyc_level
                    id
                    email
                    data
                    createdAt
                    bank_verification_status
                    user_status
                    updatedAt
                  }
                }
                nextToken
              }
          }
      ''';

      final _getUserRequest = GraphQLRequest<PaginatedResult<GlobalTransaction>>(
        document: grapQlDocument,
        modelType: const PaginatedModelType(GlobalTransaction.classType),
        variables: <String, dynamic>{
          'filter': {
            "and": [
              {
                "userID": {"eq": '$userId'}
              }
            ]
          },
          'nextToken': null
        },
        decodePath: 'listGlobalTransactions',
      );
      var _items = await retrievePaginateData<GlobalTransaction>(request: _getUserRequest);
      if (_items != null) {
        for (var _item in _items) {
          if (_item != null) {
            //handle this state
            if (_item.parameters != null) {
              result.add(_item);
            } else {
              log("check this transaction =>" + _item.id);
            }
          }
        }
      }
      return result;
    } catch (e, s) {
      if (e.runtimeType == SDKException) {
        var t = e as SDKException;
        log(t.message);
        log(t.errorCode);
        log(s.toString());
      }
      //Utils().sendEmail(message: '\n${e.toString()}\n${s.toString()}');
      log(e.toString());
    }
    return null;
  }

  Future<GlobalTransaction?> getTransactionById({String? id}) async {
    GlobalTransaction? _transaction;
    const _getGlobalTransaction = 'getGlobalTransaction';
    String graphQLDocument = '''query $_getGlobalTransaction(\$id: ID!) {
          $_getGlobalTransaction(id: \$id) {
          id
          collect_date
          collect_transactions {
          items {
              id
            }
          }
          parametersID
          receiverID
          status
          userID
          updatedAt
          funding_date
          created_at
          createdAt
          receiver {
                  addressID
                  bank_swift_code
                  createdAt
                  first_name
                  gender
                  id
                  language
                  last_name
                  phone_number
                  updatedAt
                  userID
                   }
          }
          }''';
    if (id != null) {
      final _getUserRequest = GraphQLRequest<GlobalTransaction>(
        document: graphQLDocument,
        modelType: GlobalTransaction.classType,
        variables: <String, String>{'id': id},
        decodePath: _getGlobalTransaction,
      );
      _transaction = await getById<GlobalTransaction>(request: _getUserRequest);
    }
    return _transaction;
  }

  Future<GlobalTransaction?> save({
    required Json data,
  }) async {
    GlobalTransaction? _transaction;
    try {
      GraphQLRequest<GlobalTransaction>? _request;
      bool _isCreateNew = true;
      if (data['id'] != null && data['id'].isNotEmpty) {
        _transaction = await getTransactionById(id: data['id']);
        _isCreateNew = (_transaction == null);
      }
      if (_isCreateNew) {
        _transaction = (createModel(
          data: data,
          modelName: 'GlobalTransaction',
        )) as GlobalTransaction?;
        if (_transaction != null) {
          _request = ModelMutations.create<GlobalTransaction>(_transaction);
          // NOTE: fix the missing data
          if (data['user'] != null) _request.variables['input']['userID'] = data['user']['id'];
          // NOTE: fix the missing data
          if (data['receiver'] != null) _request.variables['input']['receiverID'] = data['receiver']['id'];
        }
        //"Variable 'input' has coerced Null value for NonNull type 'ID!'"
      } else {
        if (_transaction != null) {
          Json _json = _transaction.toJson();
          Json _updateInput = Utils.getUpdateInput(model: _json, input: data);
          _transaction = GlobalTransaction.fromJson(_updateInput);
          _request = ModelMutations.update(_transaction);
        }
      }
      if (_request != null) {
        await updateData<GlobalTransaction>(
          request: _request,
        );
      }
    } catch (error, stackTrace) {
      throw XemoException(errorCode: XemoErrorType().saveUserFailed, exception: error, stackTrace: stackTrace, category: 'ERROR SAVE USER');
    }
    return _transaction;
  }
}
