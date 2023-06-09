import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter_amplifysdk/models/generic_user.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_models/app_mixin.dart';
import 'package:mobileapp/errors.dart';
import 'package:mobileapp/models/ModelProvider.dart';

import '../utils/utils.dart';

class AppAddress extends GenericUser with Status {
  static final AppAddress _appUser = AppAddress._internal();

  factory AppAddress() => _appUser;

  AppAddress._internal() {
    primaryClassType = Address.classType;
    primaryModelName = 'Address';
    primaryIdField = Address.ID;
    primaryRelations = {};
  }

  @override
  Model createModel<T extends Model>({required Json data, String? modelName}) {
    Model _myObject;
    data['status'] = castGenericStatus(data['status']);
    if (modelName == null || modelName == 'Address') {
      _myObject = Address(
          id: data['id'],
          address_line_1: data['address_line_1'] ?? '',
          address_line_2: data['address_line_2'] ?? '',
          state: data['state'] ?? '',
          city: data['city'],
          country: data['country'] == null ? null : Country.fromJson(data['country']),
          postal_code: data['postal_code']);
    } else {
      dbg('We did not find the model');
      throw UnknownErrorAmplifyException('model-not-found'.tr);
    }
    return _myObject;
  }

  Future<Address?> getAddressById({String? id}) async {
    Address? _address;
    const _getAddress = 'getAddress';
    String graphQLDocument = '''query $_getAddress(\$id: ID!) {
          $_getAddress(id: \$id) {
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
          createdAt
          id
          postal_code
          state
          updatedAt  
          }
        }''';
    if (id != null) {
      final _getAddressRequest = GraphQLRequest<Address>(
        document: graphQLDocument,
        modelType: Address.classType,
        variables: <String, String>{'id': id},
        decodePath: _getAddress,
      );
      try {
        _address = await getById(request: _getAddressRequest);
        return _address;
      } catch (e) {
        log(e.toString());
        return _address;
      }
    }
    return _address;
  }

  Future<Address?> save({
    required Json data,
  }) async {
    Address? _profile;
    try {
      GraphQLRequest<Address>? _request;
      bool _isCreateNew = true;
      if (data['id'] != null && data['id'].isNotEmpty) {
        _profile = await getAddressById(id: data['id']);
        _isCreateNew = (_profile == null);
      }
      if (_isCreateNew) {
        _profile = (createModel(
          data: data,
          modelName: 'Address',
        )) as Address?;
        if (_profile != null) {
          _request = ModelMutations.create(_profile);
          // NOTE: fix the missing data
          if (data['country'] != null) _request.variables['input']['countryID'] = data['country']['id'];
        }
      } else {
        if (_profile != null) {
          Json _json = _profile.toJson();
          Json _updateInput = Utils.getUpdateInput(model: _json, input: data);
          _profile = Address.fromJson(_updateInput);
          _request = ModelMutations.update(_profile);
        }
      }
      if (_request != null) {
        _profile = await updateData<Address>(
          request: _request,
        );
      }
    } catch (error, stackTrace) {
      throw XemoException(errorCode: XemoErrorType().saveUserFailed, exception: error, stackTrace: stackTrace, category: 'ERROR SAVE USER');
    }
    return _profile;
  }
}
