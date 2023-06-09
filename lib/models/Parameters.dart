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


/** This is an auto generated class representing the Parameters type in your schema. */
@immutable
class Parameters extends Model {
  static const classType = const _ParametersModelType();
  final String id;
  final String? _amount_origin;
  final String? _amount_destination;
  final String? _total;
  final String? _applicable_rate;
  final TransferReason? _transfer_reason;
  final Country? _origin_country;
  final String? _origin_countryID;
  final Country? _destination_country;
  final String? _destination_countryID;
  final Currency? _currency_origin;
  final String? _currency_originID;
  final Currency? _currency_destination;
  final String? _currency_destinationID;
  final String? _collect_method_fee;
  final String? _collect_method;
  final String? _funding_method;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get amount_origin {
    try {
      return _amount_origin!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get amount_destination {
    try {
      return _amount_destination!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get total {
    try {
      return _total!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get applicable_rate {
    try {
      return _applicable_rate!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TransferReason get transfer_reason {
    try {
      return _transfer_reason!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Country? get origin_country {
    return _origin_country;
  }
  
  String get origin_countryID {
    try {
      return _origin_countryID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Country? get destination_country {
    return _destination_country;
  }
  
  String get destination_countryID {
    try {
      return _destination_countryID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Currency? get currency_origin {
    return _currency_origin;
  }
  
  String get currency_originID {
    try {
      return _currency_originID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Currency? get currency_destination {
    return _currency_destination;
  }
  
  String get currency_destinationID {
    try {
      return _currency_destinationID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get collect_method_fee {
    try {
      return _collect_method_fee!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get collect_method {
    return _collect_method;
  }
  
  String get funding_method {
    try {
      return _funding_method!;
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
  
  const Parameters._internal({required this.id, required amount_origin, required amount_destination, required total, required applicable_rate, required transfer_reason, origin_country, required origin_countryID, destination_country, required destination_countryID, currency_origin, required currency_originID, currency_destination, required currency_destinationID, required collect_method_fee, collect_method, required funding_method, createdAt, updatedAt}): _amount_origin = amount_origin, _amount_destination = amount_destination, _total = total, _applicable_rate = applicable_rate, _transfer_reason = transfer_reason, _origin_country = origin_country, _origin_countryID = origin_countryID, _destination_country = destination_country, _destination_countryID = destination_countryID, _currency_origin = currency_origin, _currency_originID = currency_originID, _currency_destination = currency_destination, _currency_destinationID = currency_destinationID, _collect_method_fee = collect_method_fee, _collect_method = collect_method, _funding_method = funding_method, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Parameters({String? id, required String amount_origin, required String amount_destination, required String total, required String applicable_rate, required TransferReason transfer_reason, Country? origin_country, required String origin_countryID, Country? destination_country, required String destination_countryID, Currency? currency_origin, required String currency_originID, Currency? currency_destination, required String currency_destinationID, required String collect_method_fee, String? collect_method, required String funding_method}) {
    return Parameters._internal(
      id: id == null ? UUID.getUUID() : id,
      amount_origin: amount_origin,
      amount_destination: amount_destination,
      total: total,
      applicable_rate: applicable_rate,
      transfer_reason: transfer_reason,
      origin_country: origin_country,
      origin_countryID: origin_countryID,
      destination_country: destination_country,
      destination_countryID: destination_countryID,
      currency_origin: currency_origin,
      currency_originID: currency_originID,
      currency_destination: currency_destination,
      currency_destinationID: currency_destinationID,
      collect_method_fee: collect_method_fee,
      collect_method: collect_method,
      funding_method: funding_method);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Parameters &&
      id == other.id &&
      _amount_origin == other._amount_origin &&
      _amount_destination == other._amount_destination &&
      _total == other._total &&
      _applicable_rate == other._applicable_rate &&
      _transfer_reason == other._transfer_reason &&
      _origin_country == other._origin_country &&
      _origin_countryID == other._origin_countryID &&
      _destination_country == other._destination_country &&
      _destination_countryID == other._destination_countryID &&
      _currency_origin == other._currency_origin &&
      _currency_originID == other._currency_originID &&
      _currency_destination == other._currency_destination &&
      _currency_destinationID == other._currency_destinationID &&
      _collect_method_fee == other._collect_method_fee &&
      _collect_method == other._collect_method &&
      _funding_method == other._funding_method;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Parameters {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("amount_origin=" + "$_amount_origin" + ", ");
    buffer.write("amount_destination=" + "$_amount_destination" + ", ");
    buffer.write("total=" + "$_total" + ", ");
    buffer.write("applicable_rate=" + "$_applicable_rate" + ", ");
    buffer.write("transfer_reason=" + (_transfer_reason != null ? enumToString(_transfer_reason)! : "null") + ", ");
    buffer.write("origin_countryID=" + "$_origin_countryID" + ", ");
    buffer.write("destination_countryID=" + "$_destination_countryID" + ", ");
    buffer.write("currency_originID=" + "$_currency_originID" + ", ");
    buffer.write("currency_destinationID=" + "$_currency_destinationID" + ", ");
    buffer.write("collect_method_fee=" + "$_collect_method_fee" + ", ");
    buffer.write("collect_method=" + "$_collect_method" + ", ");
    buffer.write("funding_method=" + "$_funding_method" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Parameters copyWith({String? id, String? amount_origin, String? amount_destination, String? total, String? applicable_rate, TransferReason? transfer_reason, Country? origin_country, String? origin_countryID, Country? destination_country, String? destination_countryID, Currency? currency_origin, String? currency_originID, Currency? currency_destination, String? currency_destinationID, String? collect_method_fee, String? collect_method, String? funding_method}) {
    return Parameters._internal(
      id: id ?? this.id,
      amount_origin: amount_origin ?? this.amount_origin,
      amount_destination: amount_destination ?? this.amount_destination,
      total: total ?? this.total,
      applicable_rate: applicable_rate ?? this.applicable_rate,
      transfer_reason: transfer_reason ?? this.transfer_reason,
      origin_country: origin_country ?? this.origin_country,
      origin_countryID: origin_countryID ?? this.origin_countryID,
      destination_country: destination_country ?? this.destination_country,
      destination_countryID: destination_countryID ?? this.destination_countryID,
      currency_origin: currency_origin ?? this.currency_origin,
      currency_originID: currency_originID ?? this.currency_originID,
      currency_destination: currency_destination ?? this.currency_destination,
      currency_destinationID: currency_destinationID ?? this.currency_destinationID,
      collect_method_fee: collect_method_fee ?? this.collect_method_fee,
      collect_method: collect_method ?? this.collect_method,
      funding_method: funding_method ?? this.funding_method);
  }
  
  Parameters.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _amount_origin = json['amount_origin'],
      _amount_destination = json['amount_destination'],
      _total = json['total'],
      _applicable_rate = json['applicable_rate'],
      _transfer_reason = enumFromString<TransferReason>(json['transfer_reason'], TransferReason.values),
      _origin_country = json['origin_country']?['serializedData'] != null
        ? Country.fromJson(new Map<String, dynamic>.from(json['origin_country']['serializedData']))
        : null,
      _origin_countryID = json['origin_countryID'],
      _destination_country = json['destination_country']?['serializedData'] != null
        ? Country.fromJson(new Map<String, dynamic>.from(json['destination_country']['serializedData']))
        : null,
      _destination_countryID = json['destination_countryID'],
      _currency_origin = json['currency_origin']?['serializedData'] != null
        ? Currency.fromJson(new Map<String, dynamic>.from(json['currency_origin']['serializedData']))
        : null,
      _currency_originID = json['currency_originID'],
      _currency_destination = json['currency_destination']?['serializedData'] != null
        ? Currency.fromJson(new Map<String, dynamic>.from(json['currency_destination']['serializedData']))
        : null,
      _currency_destinationID = json['currency_destinationID'],
      _collect_method_fee = json['collect_method_fee'],
      _collect_method = json['collect_method'],
      _funding_method = json['funding_method'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'amount_origin': _amount_origin, 'amount_destination': _amount_destination, 'total': _total, 'applicable_rate': _applicable_rate, 'transfer_reason': enumToString(_transfer_reason), 'origin_country': _origin_country?.toJson(), 'origin_countryID': _origin_countryID, 'destination_country': _destination_country?.toJson(), 'destination_countryID': _destination_countryID, 'currency_origin': _currency_origin?.toJson(), 'currency_originID': _currency_originID, 'currency_destination': _currency_destination?.toJson(), 'currency_destinationID': _currency_destinationID, 'collect_method_fee': _collect_method_fee, 'collect_method': _collect_method, 'funding_method': _funding_method, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField AMOUNT_ORIGIN = QueryField(fieldName: "amount_origin");
  static final QueryField AMOUNT_DESTINATION = QueryField(fieldName: "amount_destination");
  static final QueryField TOTAL = QueryField(fieldName: "total");
  static final QueryField APPLICABLE_RATE = QueryField(fieldName: "applicable_rate");
  static final QueryField TRANSFER_REASON = QueryField(fieldName: "transfer_reason");
  static final QueryField ORIGIN_COUNTRY = QueryField(
    fieldName: "origin_country",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Country).toString()));
  static final QueryField ORIGIN_COUNTRYID = QueryField(fieldName: "origin_countryID");
  static final QueryField DESTINATION_COUNTRY = QueryField(
    fieldName: "destination_country",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Country).toString()));
  static final QueryField DESTINATION_COUNTRYID = QueryField(fieldName: "destination_countryID");
  static final QueryField CURRENCY_ORIGIN = QueryField(
    fieldName: "currency_origin",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Currency).toString()));
  static final QueryField CURRENCY_ORIGINID = QueryField(fieldName: "currency_originID");
  static final QueryField CURRENCY_DESTINATION = QueryField(
    fieldName: "currency_destination",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Currency).toString()));
  static final QueryField CURRENCY_DESTINATIONID = QueryField(fieldName: "currency_destinationID");
  static final QueryField COLLECT_METHOD_FEE = QueryField(fieldName: "collect_method_fee");
  static final QueryField COLLECT_METHOD = QueryField(fieldName: "collect_method");
  static final QueryField FUNDING_METHOD = QueryField(fieldName: "funding_method");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Parameters";
    modelSchemaDefinition.pluralName = "Parameters";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PRIVATE,
        operations: [
          ModelOperation.READ
        ]),
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "sub",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.READ,
          ModelOperation.CREATE,
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
      key: Parameters.AMOUNT_ORIGIN,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Parameters.AMOUNT_DESTINATION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Parameters.TOTAL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Parameters.APPLICABLE_RATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Parameters.TRANSFER_REASON,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Parameters.ORIGIN_COUNTRY,
      isRequired: false,
      ofModelName: (Country).toString(),
      associatedKey: Country.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Parameters.ORIGIN_COUNTRYID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Parameters.DESTINATION_COUNTRY,
      isRequired: false,
      ofModelName: (Country).toString(),
      associatedKey: Country.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Parameters.DESTINATION_COUNTRYID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Parameters.CURRENCY_ORIGIN,
      isRequired: false,
      ofModelName: (Currency).toString(),
      associatedKey: Currency.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Parameters.CURRENCY_ORIGINID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Parameters.CURRENCY_DESTINATION,
      isRequired: false,
      ofModelName: (Currency).toString(),
      associatedKey: Currency.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Parameters.CURRENCY_DESTINATIONID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Parameters.COLLECT_METHOD_FEE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Parameters.COLLECT_METHOD,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Parameters.FUNDING_METHOD,
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

class _ParametersModelType extends ModelType<Parameters> {
  const _ParametersModelType();
  
  @override
  Parameters fromJson(Map<String, dynamic> jsonData) {
    return Parameters.fromJson(jsonData);
  }
}