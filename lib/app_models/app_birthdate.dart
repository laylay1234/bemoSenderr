import 'dart:developer' as d;

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter_amplifysdk/errors.dart';
import 'package:flutter_amplifysdk/models/generic_user.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_models/app_mixin.dart';
import 'package:mobileapp/errors.dart';
import 'package:mobileapp/models/ModelProvider.dart';

import '../utils/utils.dart';

class AppBirthDate extends GenericUser with Status {
  static final AppBirthDate _appUser = AppBirthDate._internal();

  factory AppBirthDate() => _appUser;

  AppBirthDate._internal() {
    primaryClassType = BirthDate.classType;
    primaryModelName = 'BirthDate';
    primaryIdField = BirthDate.ID;
    primaryRelations = {};
  }

  @override
  Model createModel<T extends Model>({required Json data, String? modelName}) {
    Model _myObject;
    data['status'] = castGenericStatus(data['status']);
    if (modelName == null || modelName == 'BirthDate') {
      _myObject = BirthDate(
        id: data['id'],
        birth_city: data['birth_city'],
        birth_country: data['birth_country'],
        date_of_birth: TemporalDateTime.fromString(data['date_of_birth'].toString()),
      );
    } else {
      dbg('We did not find the model');
      throw UnknownErrorAmplifyException('model-not-found'.tr);
    }
    return _myObject;
  }

  Future<BirthDate?> getIdentityDocumentById({String? id}) async {
    BirthDate? _birthDateDocument;
    const _getBirthdateDocument = 'getBirthDate';
    String graphQLDocument = '''query $_getBirthdateDocument(\$id: ID!) {
          $_getBirthdateDocument(id: \$id) {
            birth_city
            birth_country
            createdAt
            date_of_birth
            updatedAt
            id
          }
        }''';
    if (id != null) {
      final _getBirthDateDocumentRequest = GraphQLRequest<BirthDate>(
        document: graphQLDocument,
        modelType: BirthDate.classType,
        variables: <String, String>{'id': id},
        decodePath: _getBirthdateDocument,
      );
      try {
        _birthDateDocument = await getById(request: _getBirthDateDocumentRequest);
        return _birthDateDocument;
      } catch (e) {
        log(e.toString());
        return null;
      }
    }
    return null;
  }

  Future<BirthDate?> save({
    required Json data,
  }) async {
    BirthDate? _identityDocument;
    try {
      GraphQLRequest<BirthDate>? _request;
      bool _isCreateNew = true;
      if (data['id'] != null && data['id'].isNotEmpty) {
        _identityDocument = await getIdentityDocumentById(id: data['id']);
        _isCreateNew = (_identityDocument == null);
      }
      if (_isCreateNew) {
        _identityDocument = (createModel(
          data: data,
          modelName: 'BirthDate',
        )) as BirthDate?;
        if (_identityDocument != null) {
          _request = ModelMutations.create(_identityDocument);
        }
      } else {
        if (_identityDocument != null) {
          Json _json = _identityDocument.toJson();
          Json _updateInput = Utils.getUpdateInput(model: _json, input: data);
          _identityDocument = BirthDate.fromJson(_updateInput);
          _request = ModelMutations.update(_identityDocument);
        }
      }
      if (_request != null) {
        _identityDocument = await updateData<BirthDate>(
          request: _request,
        );
      }
    } catch (error, stackTrace) {
      d.log(error.toString() + stackTrace.toString());
      d.log((error as SDKException).message + stackTrace.toString());

      throw XemoException(errorCode: XemoErrorType().saveUserFailed, exception: error, stackTrace: stackTrace, category: 'ERROR SAVE USER');
    }
    return _identityDocument;
  }
}
