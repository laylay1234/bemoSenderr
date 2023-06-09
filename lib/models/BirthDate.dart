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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the BirthDate type in your schema. */
@immutable
class BirthDate extends Model {
  static const classType = const _BirthDateModelType();
  final String id;
  final TemporalDateTime? _date_of_birth;
  final String? _birth_country;
  final String? _birth_city;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  TemporalDateTime get date_of_birth {
    try {
      return _date_of_birth!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get birth_country {
    try {
      return _birth_country!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get birth_city {
    try {
      return _birth_city!;
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
  
  const BirthDate._internal({required this.id, required date_of_birth, required birth_country, required birth_city, createdAt, updatedAt}): _date_of_birth = date_of_birth, _birth_country = birth_country, _birth_city = birth_city, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory BirthDate({String? id, required TemporalDateTime date_of_birth, required String birth_country, required String birth_city}) {
    return BirthDate._internal(
      id: id == null ? UUID.getUUID() : id,
      date_of_birth: date_of_birth,
      birth_country: birth_country,
      birth_city: birth_city);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BirthDate &&
      id == other.id &&
      _date_of_birth == other._date_of_birth &&
      _birth_country == other._birth_country &&
      _birth_city == other._birth_city;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("BirthDate {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("date_of_birth=" + (_date_of_birth != null ? _date_of_birth!.format() : "null") + ", ");
    buffer.write("birth_country=" + "$_birth_country" + ", ");
    buffer.write("birth_city=" + "$_birth_city" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  BirthDate copyWith({String? id, TemporalDateTime? date_of_birth, String? birth_country, String? birth_city}) {
    return BirthDate._internal(
      id: id ?? this.id,
      date_of_birth: date_of_birth ?? this.date_of_birth,
      birth_country: birth_country ?? this.birth_country,
      birth_city: birth_city ?? this.birth_city);
  }
  
  BirthDate.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _date_of_birth = json['date_of_birth'] != null ? TemporalDateTime.fromString(json['date_of_birth']) : null,
      _birth_country = json['birth_country'],
      _birth_city = json['birth_city'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'date_of_birth': _date_of_birth?.format(), 'birth_country': _birth_country, 'birth_city': _birth_city, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField DATE_OF_BIRTH = QueryField(fieldName: "date_of_birth");
  static final QueryField BIRTH_COUNTRY = QueryField(fieldName: "birth_country");
  static final QueryField BIRTH_CITY = QueryField(fieldName: "birth_city");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "BirthDate";
    modelSchemaDefinition.pluralName = "BirthDates";
    
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
      key: BirthDate.DATE_OF_BIRTH,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BirthDate.BIRTH_COUNTRY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: BirthDate.BIRTH_CITY,
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

class _BirthDateModelType extends ModelType<BirthDate> {
  const _BirthDateModelType();
  
  @override
  BirthDate fromJson(Map<String, dynamic> jsonData) {
    return BirthDate.fromJson(jsonData);
  }
}