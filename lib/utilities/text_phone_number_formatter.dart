import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

String formatPhoneNumber(String phone_number, List<String> iso_codes) {
  String isoCodeOfPhoneNumber = '';
  String formatedPhonenNumber = '';

  if (phone_number.startsWith('+')) {
    formatedPhonenNumber = phone_number.substring(1).replaceAll(' ', '');
  } else {
    formatedPhonenNumber = phone_number.trim().replaceAll(' ', '');
  }
  for (var e in iso_codes) {
    //log(formatedPhonenNumber);
    String tmp = int.parse(e).toString().trim().replaceAll(' ', '');
    //  log(tmp);
    // log('________________');
    if (formatedPhonenNumber.startsWith(tmp)) {
      if (tmp.length > isoCodeOfPhoneNumber.length) {
        isoCodeOfPhoneNumber = tmp;
      }
    }
  }
  //removes the leading zeros from the calling code string
  //log("=>" + isoCodeOfPhoneNumber);
  // isoCodeOfPhoneNumber = int.parse(isoCodeOfPhoneNumber).toString();
  String phone_without_iso_code = formatedPhonenNumber.substring(isoCodeOfPhoneNumber.length);
  phone_without_iso_code =
      phone_without_iso_code.toString().replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)} ").replaceAll(RegExp(r'^0+(?=.)'), '');
  formatedPhonenNumber = isoCodeOfPhoneNumber + ' ' + phone_without_iso_code;
  return formatedPhonenNumber;
}

class FormatPlainTextPhoneNumberByNumber {
  String format(String phoneNumber) {
    String result = '';
    phoneNumber = phoneNumber.replaceAll(' ', '');
    if (phoneNumber.startsWith("+1")) {
      return ("+1 " + PhoneNumberInputFormatter(countryIso: 'CA').formatByPattern("### ### ####", phoneNumber.substring(2)));
    }
    if (phoneNumber.startsWith("+213")) {
      //log('here?');
      if (phoneNumber.substring(4).length == 9) {
        result = ("+213 " + PhoneNumberInputFormatter(countryIso: 'DZ').formatByPattern("# ## ## ## ##", phoneNumber.substring(4)));
        // break;
      } else {
        result = ("+213 " + PhoneNumberInputFormatter(countryIso: 'DZ').formatByPattern("## ## ## ## ##", phoneNumber.substring(4)));
      }
      return result;
    }
    if (phoneNumber.startsWith("+212")) {
      if (phoneNumber.substring(4).length == 9) {
        result = ("+212 " + PhoneNumberInputFormatter(countryIso: 'MA').formatByPattern("# ## ## ## ##", phoneNumber.substring(4)));
        // break;
      } else {
        result = ("+212 " + PhoneNumberInputFormatter(countryIso: 'MA').formatByPattern("## ## ## ## ##", phoneNumber.substring(4)));
      }
      return result;
      // return ("+212 " + PhoneNumberInputFormatter(countryIso: 'MA').formatByPattern("### ## ## ##", phoneNumber.substring(4)));
    }

    if (phoneNumber.startsWith("+221")) {
      if (phoneNumber.substring(4).length == 9) {
        result = ("+221 " + PhoneNumberInputFormatter(countryIso: 'SN').formatByPattern("# ## ## ## ##", phoneNumber.substring(4)));
        // break;
      } else {
        result = ("+221 " + PhoneNumberInputFormatter(countryIso: 'SN').formatByPattern("## ## ## ## ##", phoneNumber.substring(4)));
      }
      return result;
    }
    if (phoneNumber.startsWith("+223")) {
      if (phoneNumber.substring(4).length == 9) {
        result = ("+223 " + PhoneNumberInputFormatter(countryIso: 'ML').formatByPattern("# ## ## ## ##", phoneNumber.substring(4)));
        // break;
      } else {
        result = ("+223 " + PhoneNumberInputFormatter(countryIso: 'ML').formatByPattern("## ## ## ## ##", phoneNumber.substring(4)));
      }
      return result;
    }
    if (phoneNumber.startsWith("+225")) {
      if (phoneNumber.substring(4).length == 9) {
        result = ("+225 " + PhoneNumberInputFormatter(countryIso: 'CI').formatByPattern("# ## ## ## ##", phoneNumber.substring(4)));
        // break;
      } else {
        result = ("+225 " + PhoneNumberInputFormatter(countryIso: 'CI').formatByPattern("## ## ## ## ##", phoneNumber.substring(4)));
      }
      return result;
    }
    if (phoneNumber.startsWith("+227")) {
      result = ("+227 " + PhoneNumberInputFormatter(countryIso: 'NE').formatByPattern("### ### ####", phoneNumber.substring(4)));
      // break;

      return result;
    }
    if (phoneNumber.startsWith("+20")) {
      return ("+20 " + PhoneNumberInputFormatter(countryIso: 'EG').formatByPattern("## #### ####", phoneNumber.substring(4)));
    }

    return phoneNumber;
  }
}

class PhoneNumberInputFormatter extends TextInputFormatter {
  String? countryIso;
  PhoneNumberInputFormatter({this.countryIso});
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      //print(true);
      return newValue;
    }
    RegExp _regExp = RegExp(r'^[0-9]+$');
    if (!_regExp.hasMatch(newValue.text.replaceAll(' ', ''))) {
      return newValue.copyWith(text: oldValue.text, selection: TextSelection.collapsed(offset: oldValue.text.length));
    }

    // double value = double.parse(newValue.text);
    //1234
    String newText = '';
    switch (countryIso) {
      case 'CA':
        newText = formatByPattern('### ### ####', newValue.text);
        break;
      case 'US':
        newText = formatByPattern('### ### ####', newValue.text);
        break;
      case 'MA':
        if (newValue.text.replaceAll(' ', '').length == 9) {
          newText = formatByPattern('### ## ## ##', newValue.text);
          break;
        } else {
          newText = formatByPattern('## ## ## ## ##', newValue.text);
          break;
        }
      case 'DZ':
        //log('here?');
        if (newValue.text.replaceAll(' ', '').length == 9) {
          newText = formatByPattern('# ## ## ## ##', newValue.text);
          break;
        } else {
          newText = formatByPattern('## ## ## ## ##', newValue.text);
          break;
        }
      case 'SN':
        if (newValue.text.replaceAll(' ', '').length == 9) {
          newText = formatByPattern('# ## ## ## ##', newValue.text);
          break;
        } else {
          newText = formatByPattern('## ## ## ## ##', newValue.text);
          break;
        }
      case 'ML':
        if (newValue.text.replaceAll(' ', '').length == 9) {
          newText = formatByPattern('# ## ## ## ##', newValue.text);
          break;
        } else {
          newText = formatByPattern('## ## ## ## ##', newValue.text);
          break;
        }
      case 'CI':
        if (newValue.text.replaceAll(' ', '').length == 9) {
          newText = formatByPattern('# ## ## ## ##', newValue.text);
          break;
        } else {
          newText = formatByPattern('## ## ## ## ##', newValue.text);
          break;
        }
      case 'JM':
        newText = formatByPattern('### ### ####', newValue.text);
        break;
      case 'NE':
        newText = formatByPattern('### ### ####', newValue.text);
        break;
      case 'EG':
        newText = formatByPattern('## #### ####', newValue.text);
        break;
      default:
        newText = formatByPattern('### ## ## ##', newValue.text);
    }

    return newValue.copyWith(text: newText, selection: TextSelection.collapsed(offset: newText.length));
  }

  String formatByPattern(String pattern, String value) {
    String updatedValue = '';
    int index = 0; //for iterating over the pattern
    int j = 0; //for iterating over the value
    int patternLengthWithouSpaces = pattern.replaceAll(' ', '').length;
    if (patternLengthWithouSpaces < value.replaceAll(' ', '').length) {
      return (value.replaceAll(' ', ''));
    }
    value = value.replaceAll(' ', '');
    while ((index < pattern.length) && (j < value.length)) {
      if (pattern[index] == '#') {
        //
        updatedValue = updatedValue + value[j];
        j++;
      } else if (pattern[index] == ' ') {
        //
        updatedValue = updatedValue + " ";
      }

      index++;
    }

    return updatedValue;
  }
}
