import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_amplifysdk/models/generic_user.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:get/get.dart';
import 'package:mobileapp/errors.dart';

import '../models/ModelProvider.dart';
import '../utils/utils.dart';
import 'app_mixin.dart';

class AppParameters extends GenericUser with Status {
  static final AppParameters _appUser = AppParameters._internal();

  factory AppParameters() => _appUser;

  AppParameters._internal() {
    primaryClassType = Parameters.classType;
    primaryModelName = 'Parameters';
    primaryIdField = Parameters.ID;
    primaryRelations = {};
  }

  @override
  Model createModel<T extends Model>({required Json data, String? modelName}) {
    Model _myObject;
    if (modelName == null || modelName == 'Parameters') {
      _myObject = Parameters(
          amount_destination: data['amount_destination'],
          origin_country: Country.fromJson(data['origin_country']),
          currency_origin: Currency.fromJson(data['origin_country']),
          destination_country: Country.fromJson(data['destination_country']),
          currency_destination: Currency.fromJson(data['currency_destination']),
          collect_method: data['collect_method'],
          amount_origin: data['amount_origin'],
          applicable_rate: data['applicable_rate'],
          collect_method_fee: data['collect_method_fee'],
          currency_destinationID: data['currency_destinationID'],
          currency_originID: data['currency_originID'],
          destination_countryID: data['destination_countryID'],
          funding_method: data['funding_method'],
          origin_countryID: data['origin_countryID'],
          total: data['total'],
          transfer_reason:
              TransferReason.values.where((e) => e.name.toString().toLowerCase().contains(data['transfer_reason'].toString().toLowerCase())).first);
    } else {
      dbg('We did not find the model');
      throw UnknownErrorAmplifyException('model-not-found'.tr);
    }
    return _myObject;
  }

  Future<Parameters?> getParametersById({String? id}) async {
    Parameters? _parameters;
    const _getParameters = 'getParameters';
    String graphQLDocument = '''query $_getParameters(\$id: ID!) {
      $_getParameters(id: \$id) {
                collect_method_fee
                collect_method
                applicable_rate
                amount_origin
                amount_destination
                createdAt
                updatedAt
                transfer_reason
                total
                owner
                origin_countryID
                id
                funding_method
                destination_countryID
                currency_originID
                currency_destinationID
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
                  iso_code
                  id
                  createdAt
                }
                destination_country {
                  updatedAt
                  name
                  iso_code
                  id
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
                  createdAt
                  calling_code
                  active
                }
              }
          }''';

    //"Validation error of type FieldUndefined: Field '_getParameters' in type 'Query' is undefined @ '_getParameters'"
    if (id != null) {
      final _getUserRequest = GraphQLRequest<Parameters>(
        document: graphQLDocument,
        modelType: Parameters.classType,
        variables: <String, String>{'id': id},
        decodePath: _getParameters,
      );
      _parameters = await getById<Parameters>(request: _getUserRequest);
    }

    return _parameters;
  }

  Future<Parameters?> save({
    required Json data,
  }) async {
    Parameters? _paramaters;
    try {
      GraphQLRequest<Parameters>? _request;
      bool _isCreateNew = true;
      if (data['id'] != null && data['id'].isNotEmpty) {
        _paramaters = await getParametersById(id: data['id']);
        _isCreateNew = (_paramaters == null);
      }
      if (_isCreateNew) {
        _paramaters = (createModel(
          data: data,
          modelName: 'Parameters',
        )) as Parameters?;
        if (_paramaters != null) {
          _request = ModelMutations.create<Parameters>(_paramaters);
          // NOTE: fix the missing data
          if (data['origin_country'] != null) _request.variables['input']['origin_countryID'] = data['origin_country']['id'];
          if (data['destination_country'] != null) _request.variables['input']['destination_countryID'] = data['destination_country']['id'];
          if (data['currency_origin'] != null) _request.variables['input']['currency_originID'] = data['currency_origin']['id'];
          if (data['currency_destination'] != null) _request.variables['input']['currency_destinationID'] = data['currency_destination']['id'];
        }
      } else {
        if (_paramaters != null) {
          Json _json = _paramaters.toJson();
          Json _updateInput = Utils.getUpdateInput(model: _json, input: data);
          _paramaters = Parameters.fromJson(_updateInput);
          _request = ModelMutations.update<Parameters>(_paramaters);
        }
      }
        if (_request != null) {
          _paramaters = await updateData<Parameters>(
            request: _request,
          );
        }
    } catch (error, stackTrace) {
      throw XemoException(errorCode: XemoErrorType().saveUserFailed, exception: error, stackTrace: stackTrace, category: 'ERROR SAVE USER');
    }
    return _paramaters;
  }
}
