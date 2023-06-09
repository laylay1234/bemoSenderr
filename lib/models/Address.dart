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


/** This is an auto generated class representing the Address type in your schema. */
@immutable
class Address extends Model {
  static const classType = const _AddressModelType();
  final String id;
  final String? _city;
  final String? _postal_code;
  final String? _state;
  final Country? _country;
  final String? _address_line_1;
  final String? _address_line_2;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get city {
    try {
      return _city!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get postal_code {
    try {
      return _postal_code!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get state {
    return _state;
  }
  
  Country? get country {
    return _country;
  }
  
  String? get address_line_1 {
    return _address_line_1;
  }
  
  String? get address_line_2 {
    return _address_line_2;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Address._internal({required this.id, required city, required postal_code, state, country, address_line_1, address_line_2, createdAt, updatedAt}): _city = city, _postal_code = postal_code, _state = state, _country = country, _address_line_1 = address_line_1, _address_line_2 = address_line_2, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Address({String? id, required String city, required String postal_code, String? state, Country? country, String? address_line_1, String? address_line_2}) {
    return Address._internal(
      id: id == null ? UUID.getUUID() : id,
      city: city,
      postal_code: postal_code,
      state: state,
      country: country,
      address_line_1: address_line_1,
      address_line_2: address_line_2);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Address &&
      id == other.id &&
      _city == other._city &&
      _postal_code == other._postal_code &&
      _state == other._state &&
      _country == other._country &&
      _address_line_1 == other._address_line_1 &&
      _address_line_2 == other._address_line_2;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Address {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("city=" + "$_city" + ", ");
    buffer.write("postal_code=" + "$_postal_code" + ", ");
    buffer.write("state=" + "$_state" + ", ");
    buffer.write("country=" + (_country != null ? _country!.toString() : "null") + ", ");
    buffer.write("address_line_1=" + "$_address_line_1" + ", ");
    buffer.write("address_line_2=" + "$_address_line_2" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Address copyWith({String? id, String? city, String? postal_code, String? state, Country? country, String? address_line_1, String? address_line_2}) {
    return Address._internal(
      id: id ?? this.id,
      city: city ?? this.city,
      postal_code: postal_code ?? this.postal_code,
      state: state ?? this.state,
      country: country ?? this.country,
      address_line_1: address_line_1 ?? this.address_line_1,
      address_line_2: address_line_2 ?? this.address_line_2);
  }
  
  Address.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _city = json['city'],
      _postal_code = json['postal_code'],
      _state = json['state'],
      _country = json['country']?['serializedData'] != null
        ? Country.fromJson(new Map<String, dynamic>.from(json['country']['serializedData']))
        : null,
      _address_line_1 = json['address_line_1'],
      _address_line_2 = json['address_line_2'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'city': _city, 'postal_code': _postal_code, 'state': _state, 'country': _country?.toJson(), 'address_line_1': _address_line_1, 'address_line_2': _address_line_2, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField CITY = QueryField(fieldName: "city");
  static final QueryField POSTAL_CODE = QueryField(fieldName: "postal_code");
  static final QueryField STATE = QueryField(fieldName: "state");
  static final QueryField COUNTRY = QueryField(
    fieldName: "country",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Country).toString()));
  static final QueryField ADDRESS_LINE_1 = QueryField(fieldName: "address_line_1");
  static final QueryField ADDRESS_LINE_2 = QueryField(fieldName: "address_line_2");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Address";
    modelSchemaDefinition.pluralName = "Addresses";
    
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
      ModelIndex(fields: const ["countryID", "id"], name: "AddressesByCountry")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.CITY,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.POSTAL_CODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.STATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Address.COUNTRY,
      isRequired: false,
      targetName: "countryID",
      ofModelName: (Country).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.ADDRESS_LINE_1,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Address.ADDRESS_LINE_2,
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

class _AddressModelType extends ModelType<Address> {
  const _AddressModelType();
  
  @override
  Address fromJson(Map<String, dynamic> jsonData) {
    return Address.fromJson(jsonData);
  }
}