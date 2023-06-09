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
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the CollectTransaction type in your schema. */
@immutable
class CollectTransaction extends Model {
  static const classType = const _CollectTransactionModelType();
  final String id;
  final String? _globalTransactionID;
  final List<String>? _img_urls;
  final String? _collect_code;
  final String? _partner_name;
  final String? _status;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get globalTransactionID {
    try {
      return _globalTransactionID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<String> get img_urls {
    try {
      return _img_urls!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get collect_code {
    try {
      return _collect_code!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get partner_name {
    try {
      return _partner_name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get status {
    try {
      return _status!;
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
  
  const CollectTransaction._internal({required this.id, required globalTransactionID, required img_urls, required collect_code, required partner_name, required status, createdAt, updatedAt}): _globalTransactionID = globalTransactionID, _img_urls = img_urls, _collect_code = collect_code, _partner_name = partner_name, _status = status, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory CollectTransaction({String? id, required String globalTransactionID, required List<String> img_urls, required String collect_code, required String partner_name, required String status}) {
    return CollectTransaction._internal(
      id: id == null ? UUID.getUUID() : id,
      globalTransactionID: globalTransactionID,
      img_urls: img_urls != null ? List<String>.unmodifiable(img_urls) : img_urls,
      collect_code: collect_code,
      partner_name: partner_name,
      status: status);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CollectTransaction &&
      id == other.id &&
      _globalTransactionID == other._globalTransactionID &&
      DeepCollectionEquality().equals(_img_urls, other._img_urls) &&
      _collect_code == other._collect_code &&
      _partner_name == other._partner_name &&
      _status == other._status;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CollectTransaction {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("globalTransactionID=" + "$_globalTransactionID" + ", ");
    buffer.write("img_urls=" + (_img_urls != null ? _img_urls!.toString() : "null") + ", ");
    buffer.write("collect_code=" + "$_collect_code" + ", ");
    buffer.write("partner_name=" + "$_partner_name" + ", ");
    buffer.write("status=" + "$_status" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CollectTransaction copyWith({String? id, String? globalTransactionID, List<String>? img_urls, String? collect_code, String? partner_name, String? status}) {
    return CollectTransaction._internal(
      id: id ?? this.id,
      globalTransactionID: globalTransactionID ?? this.globalTransactionID,
      img_urls: img_urls ?? this.img_urls,
      collect_code: collect_code ?? this.collect_code,
      partner_name: partner_name ?? this.partner_name,
      status: status ?? this.status);
  }
  
  CollectTransaction.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _globalTransactionID = json['globalTransactionID'],
      _img_urls = json['img_urls']?.cast<String>(),
      _collect_code = json['collect_code'],
      _partner_name = json['partner_name'],
      _status = json['status'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'globalTransactionID': _globalTransactionID, 'img_urls': _img_urls, 'collect_code': _collect_code, 'partner_name': _partner_name, 'status': _status, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField GLOBALTRANSACTIONID = QueryField(fieldName: "globalTransactionID");
  static final QueryField IMG_URLS = QueryField(fieldName: "img_urls");
  static final QueryField COLLECT_CODE = QueryField(fieldName: "collect_code");
  static final QueryField PARTNER_NAME = QueryField(fieldName: "partner_name");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CollectTransaction";
    modelSchemaDefinition.pluralName = "CollectTransactions";
    
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
      ModelIndex(fields: const ["id"], name: null),
      ModelIndex(fields: const ["globalTransactionID"], name: "CollectTransactionsByGlobalTransaction")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CollectTransaction.GLOBALTRANSACTIONID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CollectTransaction.IMG_URLS,
      isRequired: true,
      isArray: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.collection, ofModelName: describeEnum(ModelFieldTypeEnum.string))
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CollectTransaction.COLLECT_CODE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CollectTransaction.PARTNER_NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: CollectTransaction.STATUS,
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

class _CollectTransactionModelType extends ModelType<CollectTransaction> {
  const _CollectTransactionModelType();
  
  @override
  CollectTransaction fromJson(Map<String, dynamic> jsonData) {
    return CollectTransaction.fromJson(jsonData);
  }
}