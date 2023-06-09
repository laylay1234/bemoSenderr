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


/** This is an auto generated class representing the Country type in your schema. */
@immutable
class Country extends Model {
  static const classType = const _CountryModelType();
  final String id;
  final String? _name;
  final String? _iso_code;
  final bool? _enabled_as_origin;
  final bool? _enabled_as_destination;
  final bool? _active;
  final String? _calling_code;
  final List<Address>? _addresses;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get iso_code {
    try {
      return _iso_code!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get enabled_as_origin {
    try {
      return _enabled_as_origin!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get enabled_as_destination {
    try {
      return _enabled_as_destination!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  bool get active {
    try {
      return _active!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get calling_code {
    return _calling_code;
  }
  
  List<Address>? get addresses {
    return _addresses;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Country._internal({required this.id, required name, required iso_code, required enabled_as_origin, required enabled_as_destination, required active, calling_code, addresses, createdAt, updatedAt}): _name = name, _iso_code = iso_code, _enabled_as_origin = enabled_as_origin, _enabled_as_destination = enabled_as_destination, _active = active, _calling_code = calling_code, _addresses = addresses, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Country({String? id, required String name, required String iso_code, required bool enabled_as_origin, required bool enabled_as_destination, required bool active, String? calling_code, List<Address>? addresses}) {
    return Country._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      iso_code: iso_code,
      enabled_as_origin: enabled_as_origin,
      enabled_as_destination: enabled_as_destination,
      active: active,
      calling_code: calling_code,
      addresses: addresses != null ? List<Address>.unmodifiable(addresses) : addresses);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Country &&
      id == other.id &&
      _name == other._name &&
      _iso_code == other._iso_code &&
      _enabled_as_origin == other._enabled_as_origin &&
      _enabled_as_destination == other._enabled_as_destination &&
      _active == other._active &&
      _calling_code == other._calling_code &&
      DeepCollectionEquality().equals(_addresses, other._addresses);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Country {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("iso_code=" + "$_iso_code" + ", ");
    buffer.write("enabled_as_origin=" + (_enabled_as_origin != null ? _enabled_as_origin!.toString() : "null") + ", ");
    buffer.write("enabled_as_destination=" + (_enabled_as_destination != null ? _enabled_as_destination!.toString() : "null") + ", ");
    buffer.write("active=" + (_active != null ? _active!.toString() : "null") + ", ");
    buffer.write("calling_code=" + "$_calling_code" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Country copyWith({String? id, String? name, String? iso_code, bool? enabled_as_origin, bool? enabled_as_destination, bool? active, String? calling_code, List<Address>? addresses}) {
    return Country._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      iso_code: iso_code ?? this.iso_code,
      enabled_as_origin: enabled_as_origin ?? this.enabled_as_origin,
      enabled_as_destination: enabled_as_destination ?? this.enabled_as_destination,
      active: active ?? this.active,
      calling_code: calling_code ?? this.calling_code,
      addresses: addresses ?? this.addresses);
  }
  
  Country.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _iso_code = json['iso_code'],
      _enabled_as_origin = json['enabled_as_origin'],
      _enabled_as_destination = json['enabled_as_destination'],
      _active = json['active'],
      _calling_code = json['calling_code'],
      _addresses = json['addresses'] is List
        ? (json['addresses'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Address.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'iso_code': _iso_code, 'enabled_as_origin': _enabled_as_origin, 'enabled_as_destination': _enabled_as_destination, 'active': _active, 'calling_code': _calling_code, 'addresses': _addresses?.map((Address? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ISO_CODE = QueryField(fieldName: "iso_code");
  static final QueryField ENABLED_AS_ORIGIN = QueryField(fieldName: "enabled_as_origin");
  static final QueryField ENABLED_AS_DESTINATION = QueryField(fieldName: "enabled_as_destination");
  static final QueryField ACTIVE = QueryField(fieldName: "active");
  static final QueryField CALLING_CODE = QueryField(fieldName: "calling_code");
  static final QueryField ADDRESSES = QueryField(
    fieldName: "addresses",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Address).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Country";
    modelSchemaDefinition.pluralName = "Countries";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PRIVATE,
        operations: [
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
      key: Country.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Country.ISO_CODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Country.ENABLED_AS_ORIGIN,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Country.ENABLED_AS_DESTINATION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Country.ACTIVE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Country.CALLING_CODE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Country.ADDRESSES,
      isRequired: false,
      ofModelName: (Address).toString(),
      associatedKey: Address.COUNTRY
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

class _CountryModelType extends ModelType<Country> {
  const _CountryModelType();
  
  @override
  Country fromJson(Map<String, dynamic> jsonData) {
    return Country.fromJson(jsonData);
  }
}