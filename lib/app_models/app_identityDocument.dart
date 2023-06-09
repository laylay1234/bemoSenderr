import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter_amplifysdk/models/generic_user.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_models/app_mixin.dart';
import 'package:mobileapp/errors.dart';
import 'package:mobileapp/models/ModelProvider.dart';

import '../utils/utils.dart';

class AppIdentity extends GenericUser with Status {
  static final AppIdentity _appUser = AppIdentity._internal();

  factory AppIdentity() => _appUser;

  AppIdentity._internal() {
    primaryClassType = IdentityDocument.classType;
    primaryModelName = 'IdentityDocument';
    primaryIdField = IdentityDocument.ID;
    primaryRelations = {};
  }

  @override
  Model createModel<T extends Model>({required Json data, String? modelName}) {
    Model _myObject;
    data['status'] = castGenericStatus(data['status']);
    if (modelName == null || modelName == 'IdentityDocument') {
      _myObject = IdentityDocument(
        id: data['id'],
        expiration_date: TemporalDateTime.fromString(data['expiration_date'].toString()),
        number: data['number'],
        type: data['type'],
      );
    } else {
      dbg('We did not find the model');
      throw UnknownErrorAmplifyException('model-not-found'.tr);
    }
    return _myObject;
  }

  Future<IdentityDocument?> getIdentityDocumentById({String? id}) async {
    IdentityDocument? _identityDocument;
    const _getIdentityDocument = 'getIdentityDocument';
    String graphQLDocument = '''query $_getIdentityDocument(\$id: ID!) {
          $_getIdentityDocument(id: \$id) {
            number
            owner
            updatedAt
            type
            id
            expiration_date
            createdAt
          }
        }''';
    if (id != null) {
      final _getIdentityDocumentRequest = GraphQLRequest<IdentityDocument>(
        document: graphQLDocument,
        modelType: IdentityDocument.classType,
        variables: <String, String>{'id': id},
        decodePath: _getIdentityDocument,
      );
      try {
        _identityDocument = await getById(request: _getIdentityDocumentRequest);
        return _identityDocument;
      } catch (e) {
        log(e.toString());
        return _identityDocument;
      }
    }
    return _identityDocument;
  }

  Future<IdentityDocument?> save({
    required Json data,
  }) async {
    IdentityDocument? _identityDocument;
    try {
      GraphQLRequest<IdentityDocument>? _request;
      bool _isCreateNew = true;
      if (data['id'] != null && data['id'].isNotEmpty) {
        _identityDocument = await getIdentityDocumentById(id: data['id']);
        _isCreateNew = (_identityDocument == null);
      }
      if (_isCreateNew) {
        _identityDocument = (createModel(
          data: data,
          modelName: 'IdentityDocument',
        )) as IdentityDocument?;
        if (_identityDocument != null) {
          _request = ModelMutations.create(_identityDocument);
        }
      } else {
        if (_identityDocument != null) {
          Json _json = _identityDocument.toJson();
          Json _updateInput = Utils.getUpdateInput(model: _json, input: data);
          _identityDocument = IdentityDocument.fromJson(_updateInput);
          _request = ModelMutations.update(_identityDocument);
        }
      }
      if (_request != null) {
        _identityDocument = await updateData<IdentityDocument>(
          request: _request,
        );
      }
    } catch (error, stackTrace) {
      throw XemoException(errorCode: XemoErrorType().saveUserFailed, exception: error, stackTrace: stackTrace, category: 'ERROR SAVE USER');
    }
    return _identityDocument;
  }
}
