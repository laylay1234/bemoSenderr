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


/** This is an auto generated class representing the GlobalTransaction type in your schema. */
@immutable
class GlobalTransaction extends Model {
  static const classType = const _GlobalTransactionModelType();
  final String id;
  final GlobalTransactionStatus? _status;
  final User? _user;
  final AddressBook? _receiver;
  final Parameters? _parameters;
  final String? _parametersID;
  final List<CollectTransaction>? _collect_transactions;
  final TemporalDateTime? _funding_date;
  final TemporalDateTime? _collect_date;
  final TemporalDateTime? _created_at;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  GlobalTransactionStatus get status {
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
  
  User? get user {
    return _user;
  }
  
  AddressBook? get receiver {
    return _receiver;
  }
  
  Parameters? get parameters {
    return _parameters;
  }
  
  String get parametersID {
    try {
      return _parametersID!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<CollectTransaction>? get collect_transactions {
    return _collect_transactions;
  }
  
  TemporalDateTime get funding_date {
    try {
      return _funding_date!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime get collect_date {
    try {
      return _collect_date!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime get created_at {
    try {
      return _created_at!;
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
  
  const GlobalTransaction._internal({required this.id, required status, user, receiver, parameters, required parametersID, collect_transactions, required funding_date, required collect_date, required created_at, createdAt, updatedAt}): _status = status, _user = user, _receiver = receiver, _parameters = parameters, _parametersID = parametersID, _collect_transactions = collect_transactions, _funding_date = funding_date, _collect_date = collect_date, _created_at = created_at, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory GlobalTransaction({String? id, required GlobalTransactionStatus status, User? user, AddressBook? receiver, Parameters? parameters, required String parametersID, List<CollectTransaction>? collect_transactions, required TemporalDateTime funding_date, required TemporalDateTime collect_date, required TemporalDateTime created_at}) {
    return GlobalTransaction._internal(
      id: id == null ? UUID.getUUID() : id,
      status: status,
      user: user,
      receiver: receiver,
      parameters: parameters,
      parametersID: parametersID,
      collect_transactions: collect_transactions != null ? List<CollectTransaction>.unmodifiable(collect_transactions) : collect_transactions,
      funding_date: funding_date,
      collect_date: collect_date,
      created_at: created_at);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GlobalTransaction &&
      id == other.id &&
      _status == other._status &&
      _user == other._user &&
      _receiver == other._receiver &&
      _parameters == other._parameters &&
      _parametersID == other._parametersID &&
      DeepCollectionEquality().equals(_collect_transactions, other._collect_transactions) &&
      _funding_date == other._funding_date &&
      _collect_date == other._collect_date &&
      _created_at == other._created_at;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("GlobalTransaction {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("status=" + (_status != null ? enumToString(_status)! : "null") + ", ");
    buffer.write("user=" + (_user != null ? _user!.toString() : "null") + ", ");
    buffer.write("receiver=" + (_receiver != null ? _receiver!.toString() : "null") + ", ");
    buffer.write("parametersID=" + "$_parametersID" + ", ");
    buffer.write("funding_date=" + (_funding_date != null ? _funding_date!.format() : "null") + ", ");
    buffer.write("collect_date=" + (_collect_date != null ? _collect_date!.format() : "null") + ", ");
    buffer.write("created_at=" + (_created_at != null ? _created_at!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  GlobalTransaction copyWith({String? id, GlobalTransactionStatus? status, User? user, AddressBook? receiver, Parameters? parameters, String? parametersID, List<CollectTransaction>? collect_transactions, TemporalDateTime? funding_date, TemporalDateTime? collect_date, TemporalDateTime? created_at}) {
    return GlobalTransaction._internal(
      id: id ?? this.id,
      status: status ?? this.status,
      user: user ?? this.user,
      receiver: receiver ?? this.receiver,
      parameters: parameters ?? this.parameters,
      parametersID: parametersID ?? this.parametersID,
      collect_transactions: collect_transactions ?? this.collect_transactions,
      funding_date: funding_date ?? this.funding_date,
      collect_date: collect_date ?? this.collect_date,
      created_at: created_at ?? this.created_at);
  }
  
  GlobalTransaction.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _status = enumFromString<GlobalTransactionStatus>(json['status'], GlobalTransactionStatus.values),
      _user = json['user']?['serializedData'] != null
        ? User.fromJson(new Map<String, dynamic>.from(json['user']['serializedData']))
        : null,
      _receiver = json['receiver']?['serializedData'] != null
        ? AddressBook.fromJson(new Map<String, dynamic>.from(json['receiver']['serializedData']))
        : null,
      _parameters = json['parameters']?['serializedData'] != null
        ? Parameters.fromJson(new Map<String, dynamic>.from(json['parameters']['serializedData']))
        : null,
      _parametersID = json['parametersID'],
      _collect_transactions = json['collect_transactions'] is List
        ? (json['collect_transactions'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => CollectTransaction.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _funding_date = json['funding_date'] != null ? TemporalDateTime.fromString(json['funding_date']) : null,
      _collect_date = json['collect_date'] != null ? TemporalDateTime.fromString(json['collect_date']) : null,
      _created_at = json['created_at'] != null ? TemporalDateTime.fromString(json['created_at']) : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'status': enumToString(_status), 'user': _user?.toJson(), 'receiver': _receiver?.toJson(), 'parameters': _parameters?.toJson(), 'parametersID': _parametersID, 'collect_transactions': _collect_transactions?.map((CollectTransaction? e) => e?.toJson()).toList(), 'funding_date': _funding_date?.format(), 'collect_date': _collect_date?.format(), 'created_at': _created_at?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField STATUS = QueryField(fieldName: "status");
  static final QueryField USER = QueryField(
    fieldName: "user",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (User).toString()));
  static final QueryField RECEIVER = QueryField(
    fieldName: "receiver",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (AddressBook).toString()));
  static final QueryField PARAMETERS = QueryField(
    fieldName: "parameters",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Parameters).toString()));
  static final QueryField PARAMETERSID = QueryField(fieldName: "parametersID");
  static final QueryField COLLECT_TRANSACTIONS = QueryField(
    fieldName: "collect_transactions",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (CollectTransaction).toString()));
  static final QueryField FUNDING_DATE = QueryField(fieldName: "funding_date");
  static final QueryField COLLECT_DATE = QueryField(fieldName: "collect_date");
  static final QueryField CREATED_AT = QueryField(fieldName: "created_at");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "GlobalTransaction";
    modelSchemaDefinition.pluralName = "GlobalTransactions";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "sub",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
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
      ModelIndex(fields: const ["userID", "created_at"], name: "GlobalTransactionsByUser"),
      ModelIndex(fields: const ["receiverID", "created_at"], name: "GlobalTransactionsByAddressBook")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: GlobalTransaction.STATUS,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: GlobalTransaction.USER,
      isRequired: false,
      targetName: "userID",
      ofModelName: (User).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: GlobalTransaction.RECEIVER,
      isRequired: false,
      targetName: "receiverID",
      ofModelName: (AddressBook).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: GlobalTransaction.PARAMETERS,
      isRequired: false,
      ofModelName: (Parameters).toString(),
      associatedKey: Parameters.ID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: GlobalTransaction.PARAMETERSID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: GlobalTransaction.COLLECT_TRANSACTIONS,
      isRequired: false,
      ofModelName: (CollectTransaction).toString(),
      associatedKey: CollectTransaction.GLOBALTRANSACTIONID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: GlobalTransaction.FUNDING_DATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: GlobalTransaction.COLLECT_DATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: GlobalTransaction.CREATED_AT,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
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

class _GlobalTransactionModelType extends ModelType<GlobalTransaction> {
  const _GlobalTransactionModelType();
  
  @override
  GlobalTransaction fromJson(Map<String, dynamic> jsonData) {
    return GlobalTransaction.fromJson(jsonData);
  }
}