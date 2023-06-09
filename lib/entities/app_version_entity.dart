class AppStoreVersion {
  AppStore? appStore;
  AppVersionEntity? appVersionEntity;

  AppStoreVersion({this.appStore, this.appVersionEntity});

  factory AppStoreVersion.fromJson(Map<String, dynamic> json) => AppStoreVersion(
        appStore: AppStore.fromJson(json['forceUpdate']['appstore']),
        appVersionEntity: AppVersionEntity.fromJson(json['forceUpdate']),
      );
}

class AppVersionEntity {
  String? ios_version;
  String? android_version;

  AppVersionEntity({this.android_version, this.ios_version});

  factory AppVersionEntity.fromJson(Map<String, dynamic> json) => AppVersionEntity(
        ios_version: json['ios_version'],
        android_version: json['android_version'],
      );
}

class AppStore {
  String? ios_app_id;
  String? android_app_id;

  AppStore({this.ios_app_id, this.android_app_id});

  factory AppStore.fromJson(Map<String, dynamic> json) => AppStore(
        ios_app_id: json['ios_app_id'],
        android_app_id: json['android_app_id'],
      );
}
