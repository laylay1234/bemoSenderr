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


/** This is an auto generated class representing the AddressBook type in your schema. */
@immutable
class AddressBook extends Model {
  static const classType = const _AddressBookModelType();
  final String id;
  final User? _user;
  final bool? _removed;
  final String? _language;
  final String? _first_name;
  final String? _last_name;
  final String? _phone_number;
  final Address? _address;
  final String? _addressID;
  final Gender? _gender;
  final String? _mobile_network;
  final String? _bank_swift_code;
  final String? _account_number;
  final List<GlobalTransaction>? _transactions;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  User? get user {
    return _user;
  }
  
  bool? get removed {
    return _removed;
  }
  
  String? get language {
    return _language;
  }
  
  String get first_name {
    try {
      return _first_name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get last_name {
    try {
      return _last_name!;
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
  
  Address? get address {
    return _address;
  }
  
  String get addressID {
    try {
      return _addressID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Gender get gender {
    try {
      return _gender!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get mobile_network {
    return _mobile_network;
  }
  
  String? get bank_swift_code {
    return _bank_swift_code;
  }
  
  String? get account_number {
    return _account_number;
  }
  
  List<GlobalTransaction>? get transactions {
    return _transactions;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const AddressBook._internal({required this.id, user, removed, language, required first_name, required last_name, required phone_number, address, required addressID, required gender, mobile_network, bank_swift_code, account_number, transactions, createdAt, updatedAt}): _user = user, _removed = removed, _language = language, _first_name = first_name, _last_name = last_name, _phone_number = phone_number, _address = address, _addressID = addressID, _gender = gender, _mobile_network = mobile_network, _bank_swift_code = bank_swift_code, _account_number = account_number, _transactions = transactions, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory AddressBook({String? id, User? user, bool? removed, String? language, required String first_name, required String last_name, required String phone_number, Address? address, required String addressID, required Gender gender, String? mobile_network, String? bank_swift_code, String? account_number, List<GlobalTransaction>? transactions}) {
    return AddressBook._internal(
      id: id == null ? UUID.getUUID() : id,
      user: user,
      removed: removed,
      language: language,
      first_name: first_name,
      last_name: last_name,
      phone_number: phone_number,
      address: address,
      addressID: addressID,
      gender: gender,
      mobile_network: mobile_network,
      bank_swift_code: bank_swift_code,
      account_number: account_number,
      transactions: transactions != null ? List<GlobalTransaction>.unmodifiable(transactions) : transactions);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddressBook &&
      id == other.id &&
      _user == other._user &&
      _removed == other._removed &&
      _language == other._language &&
      _first_name == other._first_name &&
      _last_name == other._last_name &&
      _phone_number == other._phone_number &&
      _address == other._address &&
      _addressID == other._addressID &&
      _gender == other._gender &&
      _mobile_network == other._mobile_network &&
      _bank_swift_code == other._bank_swift_code &&
      _account_number == other._account_number &&
      DeepCollectionEquality().equals(_transactions, other._transactions);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("AddressBook {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("removed=" + (_removed != null ? _removed!.toString() : "null") + ", ");
    buffer.write("language=" + "$_language" + ", ");
    buffer.write("first_name=" + "$_first_name" + ", ");
    buffer.write("last_name=" + "$_last_name" + ", ");
    buffer.write("phone_number=" + "$_phone_number" + ", ");
    buffer.write("addressID=" + "$_addressID" + ", ");
    buffer.write("gender=" + (_gender != null ? enumToString(_gender)! : "null") + ", ");
    buffer.write("mobile_network=" + "$_mobile_network" + ", ");
    buffer.write("bank_swift_code=" + "$_bank_swift_code" + ", ");
    buffer.write("account_number=" + "$_account_number" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  AddressBook copyWith({String? id, User? user, bool? removed, String? language, String? first_name, String? last_name, String? phone_number, Address? address, String? addressID, Gender? gender, String? mobile_network, String? bank_swift_code, String? account_number, List<GlobalTransaction>? transactions}) {
    return AddressBook._internal(
      id: id ?? this.id,
      user: user ?? this.user,
      removed: removed ?? this.removed,
      language: language ?? this.language,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      phone_number: phone_number ?? this.phone_number,
      address: address ?? this.address,
      addressID: addressID ?? this.addressID,
      gender: gender ?? this.gender,
      mobile_network: mobile_network ?? this.mobile_network,
      bank_swift_code: bank_swift_code ?? this.bank_swift_code,
      account_number: account_number ?? this.account_number,
      transactions: transactions ?? this.transactions);
  }
  
  AddressBook.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _removed = json['removed'],
      _language = json['language'],
      _first_name = json['first_name'],
      _last_name = json['last_name'],
      _phone_number = json['phone_number'],
      _address = json['address']?['serializedData'] != null
        ? Address.fromJson(new Map<String, dynamic>.from(json['address']['serializedData']))
        : null,
      _addressID = json['addressID'],
      _gender = enumFromString<Gender>(json['gender'], Gender.values),
      _mobile_network = json['mobile_network'],
      _bank_swift_code = json['bank_swift_code'],
      _account_number = json['account_number'],
      _transactions = json['transactions'] is List
        ? (json['transactions'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => GlobalTransaction.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'user': _user?.toJson(), 'removed': _removed, 'language': _language, 'first_name': _first_name, 'last_name': _last_name, 'phone_number': _phone_number, 'address': _address?.toJson(), 'addressID': _addressID, 'gender': enumToString(_gender), 'mobile_network': _mobile_network, 'bank_swift_code': _bank_swift_code, 'account_number': _account_number, 'transactions': _transactions?.map((GlobalTransaction? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField REMOVED = QueryField(fieldName: "removed");
  static final QueryField LANGUAGE = QueryField(fieldName: "language");
  static final QueryField FIRST_NAME = QueryField(fieldName: "first_name");
  static final QueryField LAST_NAME = QueryField(fieldName: "last_name");
  static final QueryField PHONE_NUMBER = QueryField(fieldName: "phone_number");
  static final QueryField ADDRESS = QueryField(
    fieldName: "address",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Address).toString()));
  static final QueryField ADDRESSID = QueryField(fieldName: "addressID");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField MOBILE_NETWORK = QueryField(fieldName: "mobile_network");
  static final QueryField BANK_SWIFT_CODE = QueryField(fieldName: "bank_swift_code");
  static final QueryField ACCOUNT_NUMBER = QueryField(fieldName: "account_number");
  static final QueryField TRANSACTIONS = QueryField(
    fieldName: "transactions",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (GlobalTransaction).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "AddressBook";
    modelSchemaDefinition.pluralName = "AddressBooks";
    
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
      ModelIndex(fields: const ["id"], name: null),
      ModelIndex(fields: const ["userID", "first_name"], name: "AddressBooksByUser")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: AddressBook.USER,
      isRequired: false,
      targetName: "userID",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AddressBook.REMOVED,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AddressBook.LANGUAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AddressBook.FIRST_NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AddressBook.LAST_NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AddressBook.PHONE_NUMBER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: AddressBook.ADDRESS,
      isRequired: false,
      ofModelName: (Address).toString(),
      associatedKey: Address.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AddressBook.ADDRESSID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AddressBook.GENDER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AddressBook.MOBILE_NETWORK,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AddressBook.BANK_SWIFT_CODE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: AddressBook.ACCOUNT_NUMBER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: AddressBook.TRANSACTIONS,
      isRequired: false,
      ofModelName: (GlobalTransaction).toString(),
      associatedKey: GlobalTransaction.RECEIVER
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

class _AddressBookModelType extends ModelType<AddressBook> {
  const _AddressBookModelType();
  
  @override
  AddressBook fromJson(Map<String, dynamic> jsonData) {
    return AddressBook.fromJson(jsonData);
  }
}