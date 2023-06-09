import 'dart:developer';
import 'dart:ffi';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_amplifysdk/errors.dart';
import 'package:flutter_amplifysdk/models/generic_user.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:get/get.dart';
import 'package:mobileapp/errors.dart';

import '../models/ModelProvider.dart';
import '../utils/error_alerts_utils.dart';
import 'app_mixin.dart';

class AppAddressBook extends GenericUser with Status {
  static final AppAddressBook _appUser = AppAddressBook._internal();

  factory AppAddressBook() => _appUser;

  AppAddressBook._internal() {
    primaryClassType = AppSettings.classType;
    primaryModelName = 'AppSettings';
    primaryIdField = AppSettings.ID;
    primaryRelations = {};
  }

  @override
  Model createModel<T extends Model>({required Json data, String? modelName}) {
    Model _myObject;
    //data['status'] = castGenericStatus(data['status']);
    if (modelName == null || modelName == 'AddressBook') {
      _myObject = AddressBook(
          phone_number: data['phone_number'],
          addressID: data['addressID'],
          first_name: data['first_name'],
          gender: Gender.values.where((element) => element.toString().toLowerCase().contains(data['gender'].toString().toLowerCase())).first,
          address: Address.fromJson(data['address']),
          transactions: [],
          last_name: data['last_name'],
          bank_swift_code: data['bank_swift_code'],
          account_number: data['account_number'],
          removed: data['removed'],
          language: data['language']);
    } else {
      dbg('We did not find the model');
      throw UnknownErrorAmplifyException('model-not-found'.tr);
    }
    return _myObject;
  }

  Future<AddressBook?> getAddressBookById({String? id}) async {
    try {
      AddressBook? _addressBook;
      const _getAddressBook = 'getAddressBook';
      String graphQLDocument = '''query $_getAddressBook(\$id: ID!) {
          $_getAddressBook(id: \$id) {
                first_name
                userID
                language
                id
                updatedAt
                createdAt
                mobile_network
                phone_number
                removed
                last_name
                gender
                bank_swift_code
                addressID
                address {
                  address_line_1
                  address_line_2
                  city
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
                  id
                  createdAt
                  postal_code
                  state
                  updatedAt
                }
                account_number
                }
          }
          ''';
      if (id != null) {
        final _getUserRequest = GraphQLRequest<AddressBook>(
          document: graphQLDocument,
          modelType: AddressBook.classType,
          variables: <String, String>{'id': id},
          decodePath: _getAddressBook,
        );
        _addressBook = await getById(request: _getUserRequest);
      }
      return _addressBook;
    } catch (e, s) {
      if (e.runtimeType == SDKException) {
        var t = e as SDKException;
        log(t.message);
        log(t.errorCode);
        log(s.toString());
      }
      Utils().sendEmail(message: '\n${e.toString()}\n${s.toString()}');
      log(e.toString());
    }
  }

  Future<List<AddressBook>?> listAddressBooks({required String userId}) async {
    try {
      List<AddressBook> result = [];
      String grapQlDocument = '''query listAddressBooksQuery(\$filter: ModelAddressBookFilterInput, \$limit: Int, \$nextToken: String) {
      listAddressBooks(filter: \$filter, limit: \$limit, nextToken: \$nextToken) {
        items {
                first_name
                userID
                language
                id
                updatedAt
                createdAt
                mobile_network
                phone_number
                removed
                last_name
                gender
                bank_swift_code
                addressID
                address {
                  address_line_1
                  address_line_2
                  city
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
                  id
                  createdAt
                  postal_code
                  state
                  updatedAt
                }
                account_number
                transactions {
                  items {
                    updatedAt
                    collect_date
                    createdAt
                    created_at
                    funding_date
                    id
                    userID
                    status
                    receiverID
                    parametersID
                    receiver {
                      account_number
                      removed
                      phone_number
                      mobile_network
                      last_name
                      language
                      id
                      first_name
                      gender
                      createdAt
                      bank_swift_code
                      addressID
                      transactions {
                        items {
                          owner
                          id
                          funding_date
                          created_at
                          createdAt
                          collect_date
                          updatedAt
                          status
                          receiverID
                          userID
                          parametersID
                        }
                      }
                      updatedAt
                      userID
                      address {
                        address_line_1
                        address_line_2
                        city
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
                        id
                        createdAt
                        postal_code
                        state
                        updatedAt
                      }
                    }
                  }
                }
              }
              nextToken
            }
          }
      ''';
      final _getUserRequest = GraphQLRequest<PaginatedResult<AddressBook>>(
        document: grapQlDocument,
        modelType: const PaginatedModelType(AddressBook.classType),
        decodePath: 'listAddressBooks',
        variables: <String, dynamic>{
          'filter': {
            "and": [
              {
                "removed": {"eq": false}
              },
              {
                "userID": {"eq": '$userId'}
              }
            ]
          },
          'nextToken': null
        },
      );

      List<AddressBook?>? _items = await retrievePaginateData<AddressBook>(request: _getUserRequest);
      if (_items != null) {
        for (var _item in _items) {
          if (_item != null) {
            //handle this state
            result.add(_item);
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
      Utils().sendEmail(message: '\n${e.toString()}\n${s.toString()}');
      log(e.toString());
    }
    return null;
  }

  Future<AddressBook?> save({
    required Json data,
  }) async {
    AddressBook? _transaction;
    try {
      GraphQLRequest<AddressBook>? _request;
      bool _isCreateNew = true;
      if (data['id'] != null && data['id'].isNotEmpty) {
        _transaction = await getAddressBookById(id: data['id']);
        _isCreateNew = (_transaction == null);
      }
      if (_isCreateNew) {
        _transaction = (createModel(
          data: data,
          modelName: 'AddressBook',
        )) as AddressBook?;
        if (_transaction != null) {
          _request = ModelMutations.create<AddressBook>(_transaction);
          // NOTE: fix the missing data
          _request.variables['input']['userID'] = data['user']['id'];
          _request.variables['input']['addressID'] = data['address']['id'];
        }
      } else {
        if (_transaction != null) {
          Json _json = _transaction.toJson();
          Json _updateInput = Utils.getUpdateInput(model: _json, input: data);
          _transaction = AddressBook.fromJson(_updateInput);
          _request = ModelMutations.update<AddressBook>(_transaction);
        }
      }
      if (_request != null) {
        _transaction = await updateData<AddressBook>(
          request: _request,
        );
      }
    } catch (error, stackTrace) {
      throw XemoException(errorCode: XemoErrorType().saveUserFailed, exception: error, stackTrace: stackTrace, category: 'ERROR SAVE USER');
    }
    return _transaction;
  }
}
