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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Profile type in your schema. */
@immutable
class Profile extends Model {
  static const classType = const _ProfileModelType();
  final String id;
  final String? _first_name;
  final String? _last_name;
  final Gender? _gender;
  final String? _country;
  final Address? _address;
  final String? _addressID;
  final IdentityDocument? _identity_document;
  final String? _identity_documentID;
  final BirthDate? _birth_date;
  final String? _birth_dateID;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
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
  
  String get country {
    try {
      return _country!;
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
  
  IdentityDocument? get identity_document {
    return _identity_document;
  }
  
  String get identity_documentID {
    try {
      return _identity_documentID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  BirthDate? get birth_date {
    return _birth_date;
  }
  
  String get birth_dateID {
    try {
      return _birth_dateID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Profile._internal({required this.id, required first_name, required last_name, required gender, required country, address, required addressID, identity_document, required identity_documentID, birth_date, required birth_dateID, createdAt, updatedAt}): _first_name = first_name, _last_name = last_name, _gender = gender, _country = country, _address = address, _addressID = addressID, _identity_document = identity_document, _identity_documentID = identity_documentID, _birth_date = birth_date, _birth_dateID = birth_dateID, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Profile({String? id, required String first_name, required String last_name, required Gender gender, required String country, Address? address, required String addressID, IdentityDocument? identity_document, required String identity_documentID, BirthDate? birth_date, required String birth_dateID}) {
    return Profile._internal(
      id: id == null ? UUID.getUUID() : id,
      first_name: first_name,
      last_name: last_name,
      gender: gender,
      country: country,
      address: address,
      addressID: addressID,
      identity_document: identity_document,
      identity_documentID: identity_documentID,
      birth_date: birth_date,
      birth_dateID: birth_dateID);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Profile &&
      id == other.id &&
      _first_name == other._first_name &&
      _last_name == other._last_name &&
      _gender == other._gender &&
      _country == other._country &&
      _address == other._address &&
      _addressID == other._addressID &&
      _identity_document == other._identity_document &&
      _identity_documentID == other._identity_documentID &&
      _birth_date == other._birth_date &&
      _birth_dateID == other._birth_dateID;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Profile {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("first_name=" + "$_first_name" + ", ");
    buffer.write("last_name=" + "$_last_name" + ", ");
    buffer.write("gender=" + (_gender != null ? enumToString(_gender)! : "null") + ", ");
    buffer.write("country=" + "$_country" + ", ");
    buffer.write("addressID=" + "$_addressID" + ", ");
    buffer.write("identity_documentID=" + "$_identity_documentID" + ", ");
    buffer.write("birth_dateID=" + "$_birth_dateID" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Profile copyWith({String? id, String? first_name, String? last_name, Gender? gender, String? country, Address? address, String? addressID, IdentityDocument? identity_document, String? identity_documentID, BirthDate? birth_date, String? birth_dateID}) {
    return Profile._internal(
      id: id ?? this.id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      gender: gender ?? this.gender,
      country: country ?? this.country,
      address: address ?? this.address,
      addressID: addressID ?? this.addressID,
      identity_document: identity_document ?? this.identity_document,
      identity_documentID: identity_documentID ?? this.identity_documentID,
      birth_date: birth_date ?? this.birth_date,
      birth_dateID: birth_dateID ?? this.birth_dateID);
  }
  
  Profile.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _first_name = json['first_name'],
      _last_name = json['last_name'],
      _gender = enumFromString<Gender>(json['gender'], Gender.values),
      _country = json['country'],
      _address = json['address']?['serializedData'] != null
        ? Address.fromJson(new Map<String, dynamic>.from(json['address']['serializedData']))
        : null,
      _addressID = json['addressID'],
      _identity_document = json['identity_document']?['serializedData'] != null
        ? IdentityDocument.fromJson(new Map<String, dynamic>.from(json['identity_document']['serializedData']))
        : null,
      _identity_documentID = json['identity_documentID'],
      _birth_date = json['birth_date']?['serializedData'] != null
        ? BirthDate.fromJson(new Map<String, dynamic>.from(json['birth_date']['serializedData']))
        : null,
      _birth_dateID = json['birth_dateID'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'first_name': _first_name, 'last_name': _last_name, 'gender': enumToString(_gender), 'country': _country, 'address': _address?.toJson(), 'addressID': _addressID, 'identity_document': _identity_document?.toJson(), 'identity_documentID': _identity_documentID, 'birth_date': _birth_date?.toJson(), 'birth_dateID': _birth_dateID, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField FIRST_NAME = QueryField(fieldName: "first_name");
  static final QueryField LAST_NAME = QueryField(fieldName: "last_name");
  static final QueryField GENDER = QueryField(fieldName: "gender");
  static final QueryField COUNTRY = QueryField(fieldName: "country");
  static final QueryField ADDRESS = QueryField(
    fieldName: "address",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Address).toString()));
  static final QueryField ADDRESSID = QueryField(fieldName: "addressID");
  static final QueryField IDENTITY_DOCUMENT = QueryField(
    fieldName: "identity_document",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (IdentityDocument).toString()));
  static final QueryField IDENTITY_DOCUMENTID = QueryField(fieldName: "identity_documentID");
  static final QueryField BIRTH_DATE = QueryField(
    fieldName: "birth_date",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (BirthDate).toString()));
  static final QueryField BIRTH_DATEID = QueryField(fieldName: "birth_dateID");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Profile";
    modelSchemaDefinition.pluralName = "Profiles";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "sub",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.READ,
          ModelOperation.UPDATE
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
      key: Profile.FIRST_NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.LAST_NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.GENDER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.COUNTRY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Profile.ADDRESS,
      isRequired: false,
      ofModelName: (Address).toString(),
      associatedKey: Address.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.ADDRESSID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Profile.IDENTITY_DOCUMENT,
      isRequired: false,
      ofModelName: (IdentityDocument).toString(),
      associatedKey: IdentityDocument.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.IDENTITY_DOCUMENTID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Profile.BIRTH_DATE,
      isRequired: false,
      ofModelName: (BirthDate).toString(),
      associatedKey: BirthDate.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.BIRTH_DATEID,
      isRequired: true,
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

class _ProfileModelType extends ModelType<Profile> {
  const _ProfileModelType();
  
  @override
  Profile fromJson(Map<String, dynamic> jsonData) {
    return Profile.fromJson(jsonData);
  }
}