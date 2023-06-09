import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter_amplifysdk/models/generic_user.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_models/app_mixin.dart';
import 'package:mobileapp/errors.dart';
import 'package:mobileapp/models/ModelProvider.dart';

import '../utils/utils.dart';

class AppProfile extends GenericUser with Status {
  static final AppProfile _appUser = AppProfile._internal();

  factory AppProfile() => _appUser;

  AppProfile._internal() {
    primaryClassType = Profile.classType;
    primaryModelName = 'Profile';
    primaryIdField = Profile.ID;
    primaryRelations = {};
  }

  @override
  Model createModel<T extends Model>({required Json data, String? modelName}) {
    Model _myObject;
    data['status'] = castGenericStatus(data['status']);
    if (modelName == null || modelName == 'Profile') {
      _myObject = Profile(
        id: data['id'],
        addressID: data['addressID'],
        birth_dateID: data['birth_dateID'],
        country: data['country'],
        first_name: data['first_name'],
        identity_document: IdentityDocument.fromJson(data['identity_document']),
        address: Address.fromJson(data['address']),
        birth_date: BirthDate.fromJson(data['birth_date']),
        gender: Gender.values.firstWhere((element) => data['gender'].toString().toLowerCase() == element.name.toString().toLowerCase()),
        identity_documentID: data['identity_documentID'],
        last_name: data['last_name'],
      );
    } else {
      dbg('We did not find the model');
      throw UnknownErrorAmplifyException('model-not-found'.tr);
    }
    return _myObject;
  }

  Future<Profile?> getProfileById({String? id}) async {
    Profile? _profile;
    const _getProfile = 'getProfile';
    String graphQLDocument = '''query $_getProfile(\$id: ID!) {
          $_getProfile(id: \$id) {
            gender
            first_name
            last_name
            identity_documentID
            id
            identity_document {
              createdAt
              number
              type
              id
              expiration_date
              updatedAt
            }
            updatedAt
            createdAt
            country
            birth_date {
              birth_city
              birth_country
              createdAt
              date_of_birth
              id
              updatedAt
            }
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
            birth_dateID
          }
        }''';
    if (id != null) {
      final _getProfileRequest = GraphQLRequest<Profile>(
        document: graphQLDocument,
        modelType: Profile.classType,
        variables: <String, String>{'id': id},
        decodePath: _getProfile,
      );
      try {
        _profile = await getById(request: _getProfileRequest);
        return _profile;
      } catch (e) {
        log(e.toString());
        return _profile;
      }
    }
    return _profile;
  }

  Future<Profile?> save({
    required Json data,
  }) async {
    Profile? _profile;
    try {
      GraphQLRequest<Profile>? _request;
      bool _isCreateNew = true;
      if (data['id'] != null && data['id'].isNotEmpty) {
        _profile = await getProfileById(id: data['id']);
        _isCreateNew = (_profile == null);
      }
      if (_isCreateNew) {
        _profile = (createModel(
          data: data,
          modelName: 'Profile',
        )) as Profile?;
        if (_profile != null) {
          _request = ModelMutations.create(_profile);
        }
      } else {
        if (_profile != null) {
          Json _json = _profile.toJson();
          Json _updateInput = Utils.getUpdateInput(model: _json, input: data);
          _profile = Profile.fromJson(_updateInput);
          _request = ModelMutations.update(_profile);
        }
      }
      if (_request != null) {
        _profile = await updateData<Profile>(
          request: _request,
        );
      }
    } catch (error, stackTrace) {
      throw XemoException(errorCode: XemoErrorType().saveUserFailed, exception: error, stackTrace: stackTrace, category: 'ERROR SAVE USER');
    }
    return _profile;
  }
}
