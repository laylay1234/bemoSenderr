/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _email;
  final String? _phone_number;
  final bool? _newsletter_subscription;
  final List<AddressBook>? _address_books;
  final List<GlobalTransaction>? _global_transactions;
  final Profile? _profile;
  final String? _profileID;
  final String? _occupation;
  final String? _origin_country_iso;
  final String? _origin_calling_code;
  final UserBankVerificaitonStatus? _bank_verification_status;
  final GenericStatus? _user_status;
  final int? _kyc_level;
  final String? _data;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get phone_number {
    try {
      return _phone_number!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get newsletter_subscription {
    try {
      return _newsletter_subscription!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<AddressBook>? get address_books {
    return _address_books;
  }
  
  List<GlobalTransaction>? get global_transactions {
    return _global_transactions;
  }
  
  Profile? get profile {
    return _profile;
  }
  
  String get profileID {
    try {
      return _profileID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get occupation {
    try {
      return _occupation!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get origin_country_iso {
    return _origin_country_iso;
  }
  
  String? get origin_calling_code {
    return _origin_calling_code;
  }
  
  UserBankVerificaitonStatus? get bank_verification_status {
    return _bank_verification_status;
  }
  
  GenericStatus get user_status {
    try {
      return _user_status!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get kyc_level {
    try {
      return _kyc_level!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get data {
    return _data;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, required email, required phone_number, required newsletter_subscription, address_books, global_transactions, profile, required profileID, required occupation, origin_country_iso, origin_calling_code, bank_verification_status, required user_status, required kyc_level, data, createdAt, updatedAt}): _email = email, _phone_number = phone_number, _newsletter_subscription = newsletter_subscription, _address_books = address_books, _global_transactions = global_transactions, _profile = profile, _profileID = profileID, _occupation = occupation, _origin_country_iso = origin_country_iso, _origin_calling_code = origin_calling_code, _bank_verification_status = bank_verification_status, _user_status = user_status, _kyc_level = kyc_level, _data = data, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory User({String? id, required String email, required String phone_number, required bool newsletter_subscription, List<AddressBook>? address_books, List<GlobalTransaction>? global_transactions, Profile? profile, required String profileID, required String occupation, String? origin_country_iso, String? origin_calling_code, UserBankVerificaitonStatus? bank_verification_status, required GenericStatus user_status, required int kyc_level, String? data}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      email: email,
      phone_number: phone_number,
      newsletter_subscription: newsletter_subscription,
      address_books: address_books != null ? List<AddressBook>.unmodifiable(address_books) : address_books,
      global_transactions: global_transactions != null ? List<GlobalTransaction>.unmodifiable(global_transactions) : global_transactions,
      profile: profile,
      profileID: profileID,
      occupation: occupation,
      origin_country_iso: origin_country_iso,
      origin_calling_code: origin_calling_code,
      bank_verification_status: bank_verification_status,
      user_status: user_status,
      kyc_level: kyc_level,
      data: data);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      id == other.id &&
      _email == other._email &&
      _phone_number == other._phone_number &&
      _newsletter_subscription == other._newsletter_subscription &&
      DeepCollectionEquality().equals(_address_books, other._address_books) &&
      DeepCollectionEquality().equals(_global_transactions, other._global_transactions) &&
      _profile == other._profile &&
      _profileID == other._profileID &&
      _occupation == other._occupation &&
      _origin_country_iso == other._origin_country_iso &&
      _origin_calling_code == other._origin_calling_code &&
      _bank_verification_status == other._bank_verification_status &&
      _user_status == other._user_status &&
      _kyc_level == other._kyc_level &&
      _data == other._data;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("phone_number=" + "$_phone_number" + ", ");
    buffer.write("newsletter_subscription=" + (_newsletter_subscription != null ? _newsletter_subscription!.toString() : "null") + ", ");
    buffer.write("profileID=" + "$_profileID" + ", ");
    buffer.write("occupation=" + "$_occupation" + ", ");
    buffer.write("origin_country_iso=" + "$_origin_country_iso" + ", ");
    buffer.write("origin_calling_code=" + "$_origin_calling_code" + ", ");
    buffer.write("bank_verification_status=" + (_bank_verification_status != null ? enumToString(_bank_verification_status)! : "null") + ", ");
    buffer.write("user_status=" + (_user_status != null ? enumToString(_user_status)! : "null") + ", ");
    buffer.write("kyc_level=" + (_kyc_level != null ? _kyc_level!.toString() : "null") + ", ");
    buffer.write("data=" + "$_data" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? email, String? phone_number, bool? newsletter_subscription, List<AddressBook>? address_books, List<GlobalTransaction>? global_transactions, Profile? profile, String? profileID, String? occupation, String? origin_country_iso, String? origin_calling_code, UserBankVerificaitonStatus? bank_verification_status, GenericStatus? user_status, int? kyc_level, String? data}) {
    return User._internal(
      id: id ?? this.id,
      email: email ?? this.email,
      phone_number: phone_number ?? this.phone_number,
      newsletter_subscription: newsletter_subscription ?? this.newsletter_subscription,
      address_books: address_books ?? this.address_books,
      global_transactions: global_transactions ?? this.global_transactions,
      profile: profile ?? this.profile,
      profileID: profileID ?? this.profileID,
      occupation: occupation ?? this.occupation,
      origin_country_iso: origin_country_iso ?? this.origin_country_iso,
      origin_calling_code: origin_calling_code ?? this.origin_calling_code,
      bank_verification_status: bank_verification_status ?? this.bank_verification_status,
      user_status: user_status ?? this.user_status,
      kyc_level: kyc_level ?? this.kyc_level,
      data: data ?? this.data);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _email = json['email'],
      _phone_number = json['phone_number'],
      _newsletter_subscription = json['newsletter_subscription'],
      _address_books = json['address_books'] is List
        ? (json['address_books'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => AddressBook.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _global_transactions = json['global_transactions'] is List
        ? (json['global_transactions'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => GlobalTransaction.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _profile = json['profile']?['serializedData'] != null
        ? Profile.fromJson(new Map<String, dynamic>.from(json['profile']['serializedData']))
        : null,
      _profileID = json['profileID'],
      _occupation = json['occupation'],
      _origin_country_iso = json['origin_country_iso'],
      _origin_calling_code = json['origin_calling_code'],
      _bank_verification_status = enumFromString<UserBankVerificaitonStatus>(json['bank_verification_status'], UserBankVerificaitonStatus.values),
      _user_status = enumFromString<GenericStatus>(json['user_status'], GenericStatus.values),
      _kyc_level = (json['kyc_level'] as num?)?.toInt(),
      _data = json['data'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'email': _email, 'phone_number': _phone_number, 'newsletter_subscription': _newsletter_subscription, 'address_books': _address_books?.map((AddressBook? e) => e?.toJson()).toList(), 'global_transactions': _global_transactions?.map((GlobalTransaction? e) => e?.toJson()).toList(), 'profile': _profile?.toJson(), 'profileID': _profileID, 'occupation': _occupation, 'origin_country_iso': _origin_country_iso, 'origin_calling_code': _origin_calling_code, 'bank_verification_status': enumToString(_bank_verification_status), 'user_status': enumToString(_user_status), 'kyc_level': _kyc_level, 'data': _data, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField PHONE_NUMBER = QueryField(fieldName: "phone_number");
  static final QueryField NEWSLETTER_SUBSCRIPTION = QueryField(fieldName: "newsletter_subscription");
  static final QueryField ADDRESS_BOOKS = QueryField(
    fieldName: "address_books",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (AddressBook).toString()));
  static final QueryField GLOBAL_TRANSACTIONS = QueryField(
    fieldName: "global_transactions",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (GlobalTransaction).toString()));
  static final QueryField PROFILE = QueryField(
    fieldName: "profile",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Profile).toString()));
  static final QueryField PROFILEID = QueryField(fieldName: "profileID");
  static final QueryField OCCUPATION = QueryField(fieldName: "occupation");
  static final QueryField ORIGIN_COUNTRY_ISO = QueryField(fieldName: "origin_country_iso");
  static final QueryField ORIGIN_CALLING_CODE = QueryField(fieldName: "origin_calling_code");
  static final QueryField BANK_VERIFICATION_STATUS = QueryField(fieldName: "bank_verification_status");
  static final QueryField USER_STATUS = QueryField(fieldName: "user_status");
  static final QueryField KYC_LEVEL = QueryField(fieldName: "kyc_level");
  static final QueryField DATA = QueryField(fieldName: "data");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "sub",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ]),
      AuthRule(
        authStrategy: AuthStrategy.PRIVATE,
        provider: AuthRuleProvider.IAM,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["id"], name: null)
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PHONE_NUMBER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.NEWSLETTER_SUBSCRIPTION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.ADDRESS_BOOKS,
      isRequired: false,
      ofModelName: (AddressBook).toString(),
      associatedKey: AddressBook.USER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: User.GLOBAL_TRANSACTIONS,
      isRequired: false,
      ofModelName: (GlobalTransaction).toString(),
      associatedKey: GlobalTransaction.USER
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: User.PROFILE,
      isRequired: false,
      ofModelName: (Profile).toString(),
      associatedKey: Profile.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PROFILEID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.OCCUPATION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ORIGIN_COUNTRY_ISO,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.ORIGIN_CALLING_CODE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.BANK_VERIFICATION_STATUS,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.USER_STATUS,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.KYC_LEVEL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.DATA,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}