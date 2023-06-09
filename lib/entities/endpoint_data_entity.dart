import 'dart:io';

class EndpointDataEntity {
  String? endpointId;
  String? device_token;
  String? cognito_user_id;
  String? platform;
  DateTime? at = DateTime.now();
  EndpointDataEntity({this.device_token, this.endpointId, this.cognito_user_id, this.at, this.platform});

  Map<String, String> toJson() => {
        'endpointId': endpointId!,
        'device_token': device_token!,
        'platform': Platform.isAndroid ? 'android' : 'ios',
        'cognito_user_id': cognito_user_id!,
        'at': DateTime.now().toString()
      };

  factory EndpointDataEntity.fromJson(Map<String, dynamic> json) => EndpointDataEntity(
      endpointId: json['endpointId'],
      device_token: json['device_token'],
      cognito_user_id: json['cognito_user_id'],
      platform: json['platform'] ?? '',
      at: DateTime.parse(json['at'] ?? DateTime.now().toString()));
}
