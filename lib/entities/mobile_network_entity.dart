import 'dart:developer';

import 'package:get/get.dart';

class MobileNetworksEntity {
  List<MobileNetworkEntity>? networks;
  MobileNetworksEntity({this.networks});

  Map<String, dynamic> toJson() => {'networks': networks};

  factory MobileNetworksEntity.fromJson(Map<String, dynamic> json) =>
      MobileNetworksEntity(networks: List.from(json['networks']).map((e) => MobileNetworkEntity.fromJson(e)).toList());
}

class MobileNetworkEntity {
  List<MobileNetworkValuesEntity>? names;
  String? active;
  MobileNetworkEntity({this.active, this.names});

  Map<String, dynamic> toJson() => {'names': names, 'active': active.toString()};

  factory MobileNetworkEntity.fromJson(Map<String, dynamic> json) => MobileNetworkEntity(
      names: List.from(json['names']).map((e) => MobileNetworkValuesEntity.fromJson(e)).toList(), active: json['active'].toString());

  String getCurrentName() {
    String currentLang = Get.locale!.languageCode.toLowerCase();
    try {
      String value = names!.where((e) => e.lang!.toLowerCase().contains(currentLang)).first.name ?? '';
      return value;
    } catch (e) {
      log('from getCurrentName: ' + e.toString());
      return (names!.first.name ?? '');
    }
  }
}

class MobileNetworkValuesEntity {
  String? lang;
  String? name;

  MobileNetworkValuesEntity({this.lang, this.name});

  Map<String, dynamic> toJson() => {'lang': lang, 'name': name};

  factory MobileNetworkValuesEntity.fromJson(Map<String, dynamic> json) => MobileNetworkValuesEntity(lang: json['lang'], name: json['name']);
}
