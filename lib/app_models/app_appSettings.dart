import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_amplifysdk/models/generic_user.dart';
import 'package:mobileapp/app_models/app_mixin.dart';
import 'package:mobileapp/models/ModelProvider.dart';

class AppSettingsModel extends GenericUser with Status {
  static final AppSettingsModel _appUser = AppSettingsModel._internal();

  factory AppSettingsModel() => _appUser;

  AppSettingsModel._internal() {
    primaryClassType = Address.classType;
    primaryModelName = 'Address';
    primaryIdField = Address.ID;
    primaryRelations = {};
  }

  Future<AppSettings?> getAppSettingsById({String? id}) async {
    AppSettings? _address;
    const _getAppSettings = 'getAppSettings';
    String graphQLDocument = '''query $_getAppSettings(\$id: ID!) {
          $_getAppSettings(id: \$id) {
          content
          createdAt
          id
          updatedAt
          }
        }''';
    if (id != null) {
      final _getAppSettingsRequest = GraphQLRequest<AppSettings>(
        document: graphQLDocument,
        modelType: AppSettings.classType,
        variables: <String, String>{'id': id},
        decodePath: _getAppSettings,
      );
      _address = await getById(request: _getAppSettingsRequest);
    }
    return _address;
  }

  Future<AppSettings?> listAppSettings() async {
    List<AppSettings> _result = [];
    final request = ModelQueries.list(AppSettings.classType);

    var response = (await Amplify.API.query(request: request).response);
    final result = response.data;
    if (result == null) {
      //TODO must throw exception and handle this case
      return (_result.first);
    } else {
      for (var element in response.data!.items) {
        if (element != null) {
          _result.add(element);
        }
      }
    }
    return (_result.first);
  }
}
