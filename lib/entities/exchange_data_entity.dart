import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/format.dart';

class ExchangeRate {
  List<DeliveryMethod>? delivery_methods;
  String? rate;
  String? min;
  String? max;
  String? country_origin;
  String? country_destination;
  String? distribution_percentage;
  String? profit_margin_percentage;
  String? destination_currency_uuid;
  ExchangeRate(
      {this.delivery_methods,
      this.rate,
      this.min,
      this.max,
      this.country_destination,
      this.country_origin,
      this.distribution_percentage,
      this.profit_margin_percentage,
      this.destination_currency_uuid});

  Map<String, dynamic> toJson() => {
        'delivery_methods': delivery_methods != null ? delivery_methods!.map((e) => e.toJson()).toList() : [],
        'rate': rate,
        'min': min,
        'max': max,
        'country_origin': country_origin,
        'country_destination': country_destination,
        'distribution_percentage': distribution_percentage,
        'profit_margin_percentage': profit_margin_percentage,
        'destination_currency_uuid': destination_currency_uuid,
      };
  factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
      // min: json['min'],
      delivery_methods: List.from(json['delivery_methods'] ?? []).map((e) => DeliveryMethod.fromJson(e!)).toList(),
      rate: double.parse(json['rate'].toString()).toStringAsFixed(EXCHANGE_RATE_FORMAT_DECIMALS),
      min: double.parse(json['min'].toString()).toStringAsFixed(AMOUNT_FORMAT_DECIMALS),
      max: double.parse(json['max'].toString()).toStringAsFixed(AMOUNT_FORMAT_DECIMALS),
      country_origin: json['country_origin'],
      country_destination: json['country_destination'],
      distribution_percentage: json['distribution_percentage'].toString(),
      profit_margin_percentage: json['profit_margin_percentage'].toString(),
      destination_currency_uuid: json['destination_currency_uuid'].toString());

  bool isValid() {
    return ((delivery_methods != null) && (rate != null));
  }
}

// TODO: DeliveryMethod should be moved to a separate class file (later)
class DeliveryMethod {
  String? fee;
  // String? name; // TODO: REMOVE - DeliveryMethod.name is deprecated, use DeliveryMethod.code
  //       DeliveryMethod.name.replace('-', '').replace(' ', '_') == DeliveryMethod.code
  String? code;
  String? active;
  List<DeliveryMethodName>? names;
  // String? img_url; // TODO: REMOVE - img_url is deprecated
  String? img_active;
  String? img_disabled;
  String? img_transactionDetails;
  DeliveryMethod(
      {this.fee,
      // this.name, // TODO: REMOVE - DeliveryMethod.name is deprecated, use DeliveryMethod.code
      this.code,
      this.active,
      this.names,
      // this.img_url, // TODO: REMOVE - img_url is deprecated
      this.img_active,
      this.img_disabled,
      this.img_transactionDetails});

  Map<String, dynamic> toJson() => {
        'fee': fee,
        //    'name': name, // TODO: REMOVE - DeliveryMethod.name is deprecated, use DeliveryMethod.code
        'code_name': code,
        'active': active,
        // 'img_url': img_url // TODO: REMOVE - img_url is deprecated
      };

  factory DeliveryMethod.fromJson(Map<String, dynamic> json) => DeliveryMethod(
      fee: json['fee'],
      // code: ((json['code_name'] ?? '')), // TODO: REFACTOR - name is deprecated, use code_name
      code: json['code_name'] ?? '',
      active: json['active'],
      // img_url: json['img_url'] ?? '', // TODO: REMOVE - img_url is deprecated
      img_active: json['img_active'] ?? '',
      img_disabled: json['img_disabled'] ?? '',
      img_transactionDetails: json['img_transaction_details'] ?? '',
      names: List.from(json['names'] ?? []).map((e) => DeliveryMethodName.fromJson(e)).toList());
  //TODO uncomment it later
  // names: List.from(json['names'] ?? []).map((e) => DeliveryMethodName.fromJson(e)).toList());

  bool isEqual(DeliveryMethod obj) {
    return ((fee == obj.fee) && (code == obj.code) && (active == obj.active));
  }

  bool isValid() {
    return ((fee != null) && (code != null) && (active != null));
  }

  String getCurrentName() {
    String currentLang = Get.locale!.languageCode.toLowerCase();
    try {
      String value = names!.where((e) => e.lang!.toLowerCase().contains(currentLang)).first.name ?? '';
      return value;
    } catch (e) {
      // log('from getCurrentName: ' + e.toString());
      // TODO: Send alert to DEVs
      return names!.where((e) => e.lang!.toLowerCase().contains('en')).first.name ?? '';
    }
  }

 

  Widget getImageWidget({DeliveryMethodImageType? type, double? width, double? height}) {
    try {
      String? imgUrl;
      switch (type) {
        case DeliveryMethodImageType.active:
          imgUrl = img_active;
          break;
        case DeliveryMethodImageType.disabled:
          imgUrl = img_disabled;
          break;
        case DeliveryMethodImageType.txDetails:
          imgUrl = img_transactionDetails;
          break;
        default:
          imgUrl = 'assets/images/placeholder.svg';
      }

      // Use ImageWidget.network
      if (imgUrl!.startsWith('http')) {
        if (imgUrl.endsWith('.svg')) {
          return SvgPicture.network(
            imgUrl,
            width: width,
            height: width,
            // clipBehavior: Clip.none,
            // fit: BoxFit.fill,
          );
        }
        return Image.network(imgUrl, width: width, height: height);
      }

      // Use local assets
      if (!imgUrl.endsWith('.svg')) {
        // NOTE: Using negative bool (!<*>.endsWidth) because I had to return
        //       something and only SVGs are supported using different widgets
        // TODO: Handle scenario where we want to load a non-SVG local image (later)
      }
      return SvgPicture.network(
        imgUrl,
        height: height,
        width: width,
      );
    } catch (e) {
      // TODO: Send alert to DEVs
      return SvgPicture.asset(
        'assets/images/placeholder.svg',
        height: height,
        width: width,
      );
    }
  }
}

class DeliveryMethodName {
  String? lang;
  String? name;
  DeliveryMethodName({this.lang, this.name});

  Map<String, dynamic> toJson() => {'lang': lang, 'name': name};

  factory DeliveryMethodName.fromJson(Map<String, dynamic> json) =>
      DeliveryMethodName(lang: json['lang'].toString().toLowerCase(), name: json['name']);
}

// TODO: DeliveryMethodImageType should be moved to a DeliveryMethod class file (later)
enum DeliveryMethodImageType { active, disabled, txDetails }

// TODO: Use DeliveryMethodCodes.<method_code>.name to evaluate DeliveryMethod.code
enum DeliveryMethodCodes {
  CASH_PICKUP,
  BANK_TRANSFER,
  MOBILE_MONEY,
}
