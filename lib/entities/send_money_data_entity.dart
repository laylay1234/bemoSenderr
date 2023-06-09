import 'package:flutter/cupertino.dart';
import 'package:mobileapp/models/ModelProvider.dart';

import '../constants/format.dart';
import 'exchange_data_entity.dart';

class SendMoneyData {
  String? ip;
  ExchangeRate? exchangeRate;
  GlobalTransaction? globalTransaction;
  User? user;
  SendMoneyData({this.ip, this.globalTransaction, this.exchangeRate, @required this.user});

  //
  Map<String, dynamic> toJson() => {
        "uuid": globalTransaction!.id,
        "user_snapshot": {
          "uuid": user!.id,
          "first_name": user!.profile!.first_name,
          "last_name": user!.profile!.last_name,
          "gender": user!.profile!.gender.name,
          "birth_date": user!.profile!.birth_date!.date_of_birth.getDateTimeInUtc().toString().contains(' ')
              ? user!.profile!.birth_date!.date_of_birth.getDateTimeInUtc().toString().split(' ').first
              : user!.profile!.birth_date!.date_of_birth.getDateTimeInUtc().toString(),
          "birth_city": user!.profile!.birth_date!.birth_city,
          "birth_country": user!.profile!.birth_date!.birth_country,
          "phone_number": user!.phone_number,
          "zip_code": user!.profile!.address!.postal_code,
          "city": user!.profile!.address!.city,
          "state": user!.profile!.address!.state,
          "address_1": user!.profile!.address!.address_line_1,
          "email": user!.email,
          "data": (user!.data ?? ''),
          "country": user!.profile!.address!.country!.name,
          "document": {
            "type": user!.profile!.identity_document!.type,
            "number": user!.profile!.identity_document!.number,
            "country": user!.profile!.country,
            "expiration_date": user!.profile!.identity_document!.expiration_date.getDateTimeInUtc().toString(), //heere
          },
          "ip_address": ip ?? "",
        },
        "receiver_snapshot": {
          "city": globalTransaction!.receiver!.address!.city,
          "state": globalTransaction!.receiver!.address!.state ?? '',
          "gender": globalTransaction!.receiver!.gender.name,
          "zip_code": globalTransaction!.receiver!.address!.postal_code,
          "address_1": globalTransaction!.receiver!.address!.address_line_1,
          "last_name": globalTransaction!.receiver!.last_name,
          "first_name": globalTransaction!.receiver!.first_name,
          "phone_number": globalTransaction!.receiver!.phone_number.startsWith('+')
              ? globalTransaction!.receiver!.phone_number.replaceAll(' ', '')
              : ("+" + globalTransaction!.receiver!.phone_number.replaceAll(' ', '')),
          "language ": globalTransaction!.receiver!.language ?? '',
          "swift_code": globalTransaction!.receiver!.bank_swift_code ?? '',
          "account_number": globalTransaction!.receiver!.account_number ?? '',
          //TODO
          "mobile_network": globalTransaction!.receiver!.mobile_network ?? '',
        },
        "parameters": {
          "origin_country": globalTransaction!.parameters!.origin_country!.iso_code.toUpperCase(),
          "destination_country": globalTransaction!.parameters!.destination_country!.iso_code.toUpperCase(),
          "amount_origin": double.parse(globalTransaction!.parameters!.amount_origin).toStringAsFixed(AMOUNT_FORMAT_DECIMALS),
          "amount_destination": double.parse(globalTransaction!.parameters!.amount_destination).toStringAsFixed(AMOUNT_FORMAT_DECIMALS),
          "fee": double.parse(globalTransaction!.parameters!.collect_method_fee).toStringAsFixed(AMOUNT_FORMAT_DECIMALS),
          "total": double.parse(globalTransaction!.parameters!.total).toStringAsFixed(AMOUNT_FORMAT_DECIMALS),
          "currency_origin": globalTransaction!.parameters!.currency_origin!.iso_code,
          "currency_destination": globalTransaction!.parameters!.currency_destination!.iso_code,
          "reason_of_transfer": globalTransaction!.parameters!.transfer_reason.name,
          "delivery_method_fee": globalTransaction!.parameters!.collect_method_fee
        },
        "exchange_rate_tier_snapshot": exchangeRate!.toJson(),
        "funding_method": globalTransaction!.parameters!.funding_method,
        "collect_method": globalTransaction!.parameters!.collect_method,
      };
}
