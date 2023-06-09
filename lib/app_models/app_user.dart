import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:flutter_amplifysdk/models/generic_user.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_models/app_mixin.dart';
import 'package:mobileapp/errors.dart';
import 'package:mobileapp/models/ModelProvider.dart';

import '../utils/utils.dart';

class AppUser extends GenericUser with Status {
  static final AppUser _appUser = AppUser._internal();

  factory AppUser() => _appUser;

  AppUser._internal() {
    primaryClassType = User.classType;
    primaryModelName = 'User';
    primaryIdField = User.ID;
    primaryRelations = {};
  }

  @override
  Model createModel<T extends Model>({required Json data, String? modelName}) {
    Model _myObject;
    // data['status'] = castGenericStatus(data['status']);
    if (modelName == null || modelName == 'User') {
      _myObject = User(
        id: data['id'],
        email: data['email'] ?? {},
        kyc_level: data['kyc_level'],
        newsletter_subscription: data['newsletter_subscription'],
        occupation: data['occupation'],
        phone_number: data['phone_number'],
        address_books: data['address_books'] != null ? List.from(data['address_books']).map((e) => AddressBook.fromJson(e)).toList() : [],
        global_transactions:
            data['global_transactions'] != null ? List.from(data['global_transactions']).map((e) => GlobalTransaction.fromJson(e)).toList() : [],
        user_status: (enumFromString(data['user_status']!.toString(), GenericStatus.values) as GenericStatus),
        origin_calling_code: data['origin_calling_code'],
        origin_country_iso: data['origin_country_iso'],
        bank_verification_status: UserBankVerificaitonStatus.values
            .firstWhere((element) => data['bank_verification_status'].toString().toLowerCase() == element.name.toString().toLowerCase()),
        //
        profileID: data['profileID'],
        profile: Profile.fromJson(data['profile']),
      );
    } else {
      dbg('We did not find the model');
      throw UnknownErrorAmplifyException('model-not-found'.tr);
    }
    return _myObject;
  }

  Future<User?> getUserById({String? id}) async {
    User? _user;
    const _getUser = 'getUser';
    String graphQLDocument = '''query $_getUser(\$id: ID!) {
          $_getUser(id: \$id) {
            id
            email
            data
            createdAt
            bank_verification_status
            kyc_level
            newsletter_subscription
            occupation
            origin_calling_code
            origin_country_iso
            owner
            phone_number
            profileID
            updatedAt
            user_status
            profile {
                gender
                first_name
                createdAt
                country
                birth_dateID
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
                  createdAt
                  id
                  owner
                  postal_code
                  state
                  updatedAt
                }
                birth_date {
                  birth_city
                  birth_country
                  createdAt
                  date_of_birth
                  id
                  updatedAt
                  owner
                }
                id
                identity_document {
                  createdAt
                  expiration_date
                  id
                  number
                  owner
                  type
                  updatedAt
                }
                identity_documentID
                last_name
                owner
                updatedAt
              }
            global_transactions {
              items {
                id
                collect_date
                created_at
                funding_date
                owner
                parametersID
                status
                receiverID
                userID
                }
            }
            address_books {
              items {
                    addressID
                    account_number
                    bank_swift_code
                    createdAt
                    first_name
                    gender
                    id
                    language
                    last_name
                    phone_number
                    removed
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
                      createdAt
                      id
                      postal_code
                      state
                    }
                }
            }
          }
        }''';
    if (id != null) {
      final _getUserRequest = GraphQLRequest<User>(
        document: graphQLDocument,
        modelType: User.classType,
        variables: <String, dynamic>{'id': id},
        decodePath: _getUser,
      );
      try {
        _user = await getById(request: _getUserRequest);
        return _user;
      } catch (e) {
        log(e.toString());
        return _user;
      }
    }
    return _user;
  }

  Future<User?> save({
    required Json data,
  }) async {
    User? _user;
    try {
      GraphQLRequest<User>? _request;
      bool _isCreateNew = true;
      if (data['id'] != null && data['id'].isNotEmpty) {
        _user = await getUserById(id: data['id']);
        _isCreateNew = (_user == null);
      }
      if (_isCreateNew) {
        _user = (createModel(
          data: data,
          modelName: 'User',
        )) as User?;
        if (_user != null) {
          _request = ModelMutations.create(_user);
        }
      } else {
        if (_user != null) {
          Json _json = _user.toJson();
          Json _updateInput = Utils.getUpdateInput(model: _json, input: data);
          _user = User.fromJson(_updateInput);
          _request = ModelMutations.update(_user);
        }
      }
      if (_request != null) {
        _user = await updateData<User>(
          request: _request,
        );
      }
    } catch (error, stackTrace) {
      throw XemoException(errorCode: XemoErrorType().saveUserFailed, exception: error, stackTrace: stackTrace, category: 'ERROR SAVE USER');
    }
    return _user;
  }
}
