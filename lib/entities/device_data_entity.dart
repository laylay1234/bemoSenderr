class DeviceDataEntity {
  String? device_type;
  String? device_token;
  String? app_version;
  String? time_zone;
  DeviceInfo? deviceInfo;
  String? gcm_senderid;
  String? app_identifier;
  String? installation_id;

  DeviceDataEntity(
      {this.app_identifier,
      this.app_version,
      this.deviceInfo,
      this.device_token,
      this.device_type,
      this.gcm_senderid,
      this.installation_id,
      this.time_zone});

  Map<String, dynamic> toJson() => {
        'device_type': device_type ?? '',
        'device_token': device_token ?? '',
        'app_version': app_version ?? '',
        'time_zone': time_zone ?? '',
        'device_data': deviceInfo!.toJson(),
        'gcm_senderid': gcm_senderid ?? '',
        'app_identifier': app_identifier ?? '',
        'installation_id': installation_id ?? ''
      };
}

class DeviceInfo {
  String? model_name;
  String? platform_name;
  String? uuid;
  String? version;
  String? manufacturer;
  String? is_physical;
  String? serial;
  DeviceInfo({this.is_physical, this.manufacturer, this.model_name, this.platform_name, this.serial, this.uuid, this.version});

  Map<String, String> toJson() => {
        'model_name': model_name ?? '',
        'platform_name': platform_name ?? '',
        'uuid': uuid ?? '',
        'version': version ?? '',
        'manufacturer': manufacturer ?? '',
        'is_physical': is_physical ?? '',
        'serial': serial ?? ''
      };
}
