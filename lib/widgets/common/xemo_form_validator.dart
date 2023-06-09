import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';

///A class which is used for validating different fields
class XemoFormValidatorWidget {
  /// For validating email. It cannot be empty and the email should be a valid email
  String? Function(String?) emailValidator = MultiValidator([
    RequiredValidator(errorText: "validator.auth.emptyEmail".tr),
    EmailValidator(errorText: "validator.auth.invalidEmail".tr),
  ]);
  String? Function(String?) confirmEmailValidator = MultiValidator([
    ConfirmEmailValidator(errorText: "validator.auth.confirm.email.not.valid".tr),
  ]);
  String? Function(String?) codeValidator = MultiValidator([
    RequiredValidator(errorText: "validator.auth.required".tr),
  ]);

  String? Function(String?) occupationValidator = MultiValidator([
    RequiredValidator(errorText: "validator.auth.required".tr),
    MinLengthValidator(2, errorText: "validator.auth.firstName.min".tr),
  ]);

  /// For validating password. Minimum length should be 8 and it cannot be empty
  String? Function(String?) passwordValidator = MultiValidator([
    RequiredValidator(errorText: "validator.auth.required".tr),
    MinLengthValidator(6, errorText: "validator.auth.invalidPasswordLength".tr),
  ]);
  //
  String? Function(String?) confirmPasswordValidator = MultiValidator([
    //
    ConfirmPasswordValidator(errorText: "validator.auth.confirm.password.not.valid".tr)
  ]);
  String? Function(String?) confirmNewPasswordValidator =
      MultiValidator([ConfirmNewPasswordValidator(errorText: "validator.auth.confirm.password.not.valid".tr)]);
  //
  String? Function(String?) idNumberValidator = MultiValidator([
    RequiredValidator(errorText: "validator.auth.required".tr),
    MinLengthValidator(3, errorText: "validator.auth.invalidIdNumber".tr),
  ]);

  String? Function(String?) phoneValidator = MultiValidator([
    RequiredValidator(errorText: ("validator.auth.required".tr)),
    MinLengthValidator(6, errorText: ("validator.auth.invalidPhone.min".tr)),
    // InternationlPhoneValidator()
    //PhoneValidator(6, errorText: "validator.auth.invalidPhone.min".tr),
    //IsNumberValidator(errorText: "validator.auth.invalidPhone.min".tr)
    //PatternValidator(r'^((+|00)?218|0?)?(9[0-9]{8})$', errorText: "validator.telephone.invalidFormat".tr)
  ]);
  String? Function(String?) requiredFullAddress = MultiValidator([
    RequiredValidator(errorText: "validator.auth.required".tr),
    MinLengthValidator(4, errorText: "validator.auth.fullAddress.min".tr),
  ]);
  String? Function(String?) requiredCity = MultiValidator([
    RequiredValidator(errorText: "validator.auth.required".tr),
    MinLengthValidator(2, errorText: "validator.auth.city.min".tr),
  ]);
  String? Function(String?) requiredFirstName = MultiValidator([
    RequiredValidator(errorText: "validator.auth.required".tr),
    MinLengthValidator(2, errorText: "validator.auth.firstName.min".tr),
  ]);
  String? Function(String?) requiredLastName = MultiValidator([
    RequiredValidator(errorText: "validator.auth.required".tr),
    MinLengthValidator(2, errorText: "validator.auth.lastName.min".tr),
  ]);

  String? Function(String?) requiredCode = MultiValidator([
    RequiredValidator(errorText: "validator.auth.required".tr),
  ]);
  String? Function(String?) ibanValidator = MultiValidator([
    RequiredValidator(errorText: "validator.auth.required".tr),
    AccountNumberRegexValidator(errorText: "validator.auth.account.number.not.valid".tr),
  ]);
  String? Function(String?) swiftValidator = MultiValidator(
      [RequiredValidator(errorText: "validator.auth.required".tr), SwiftRegexValidator(errorText: "validator.auth.swift.not.valid".tr)]);

  String? Function(String?) optionalIbanValidator = MultiValidator([
    RequiredAndOptionalValidator(errorText: "validator.auth.required".tr),
    AccountNumberRegexValidator(errorText: "validator.auth.account.number.not.valid".tr)
  ]);
  String? Function(String?) opationalSwiftValidator = MultiValidator([
    RequiredAndOptionalValidator(errorText: "validator.auth.required".tr),
    SwiftRegexValidator(errorText: "validator.auth.swift.not.valid".tr),
  ]);

  /// For validating postal code. It uses the regex to check valid postal code
  /// (https://stackoverflow.com/questions/578406/what-is-the-ultimate-postal-code-and-zip-regex)
  /// and the field cannot be empty
  String? Function(String?) postalCodeValidator = MultiValidator([
    // Disabled because the required fields are already checked in the controller
    //RequiredValidator(errorText: "validator.auth.emptyField".tr),
    MinLengthValidator(2, errorText: "validator.auth.required".tr),
    //PatternValidator(r'[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ ]?\d[ABCEGHJ-NPRSTV-Z]\d', errorText: "validator.address.invalidPostalCode".tr)
  ]);

  String? Function(String?) notRequiredpostalCodeValidator = MultiValidator([
    // Disabled because the required fields are already checked in the controller
    //RequiredValidator(errorText: "validator.auth.emptyField".tr),
    RequiredAndOptionalValidator(errorText: "validator.auth.required".tr),
    //PatternValidator(r'[ABCEGHJKLMNPRSTVXY]\d[ABCEGHJ-NPRSTV-Z][ ]?\d[ABCEGHJ-NPRSTV-Z]\d', errorText: "validator.address.invalidPostalCode".tr)
  ]);
}

class OptionalLengthRangeValidator extends TextFieldValidator {
  final int min;
  final int max;

  @override
  bool get ignoreEmptyValues => true;

  OptionalLengthRangeValidator({required this.min, required this.max, required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    return (value!.length >= min && value.length <= max);
  }
}

class RequiredLengthRangeValidator extends TextFieldValidator {
  final int min;
  final int max;

  @override
  bool get ignoreEmptyValues => false;

  RequiredLengthRangeValidator({required this.min, required this.max, required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    return (value!.length >= min && value.length <= max);
  }
}

class IsNumberValidator extends TextFieldValidator {
  @override
  bool get ignoreEmptyValues => true;

  IsNumberValidator({required String errorText}) : super(errorText);

  @override
  bool isValid(String? value) {
    return isNumeric(value ?? '');
  }
}

RegExp _numeric = RegExp(r'^-?[0-9]+$');

/// check if the string contains only numbers
bool isNumeric(String str) {
  return _numeric.hasMatch(str);
}

class ConfirmEmailValidator extends TextFieldValidator {
  AuthController authController = Get.find<AuthController>();
  ConfirmEmailValidator({required String errorText}) : super(errorText);
  //validator.auth.confirm.email.not.valid
  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    if (value == authController.emailRxController.value.text) {
      return true;
    } else {
      return false;
    }
  }
}

class SwiftRegexValidator extends TextFieldValidator {
  SwiftRegexValidator({required String errorText}) : super(errorText);
  //validator.auth.confirm.email.not.valid
  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    RegExp regExp = RegExp(r'^$|^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
    if (regExp.hasMatch((value ?? ''))) {
      return true;
    } else {
      return false;
    }
  }
}

class AccountNumberRegexValidator extends TextFieldValidator {
  AccountNumberRegexValidator({required String errorText}) : super(errorText);
  //validator.auth.confirm.email.not.valid
  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    RegExp ibanRegExp = RegExp(r'^$|^[0-9]{24}$');

    //RegExp regExp = RegExp(r'^$|^[0-9]{24}$');
    if (ibanRegExp.hasMatch((value ?? ''))) {
      return true;
    } else {
      return false;
    }
  }
}
//{

class ConfirmPasswordValidator extends TextFieldValidator {
  AuthController authController = Get.find<AuthController>();
  ConfirmPasswordValidator({required String errorText}) : super(errorText);
  //validator.auth.confirm.email.not.valid
  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    if (value == authController.passwordRxController.value.text) {
      return true;
    } else {
      return false;
    }
  }
}

class ConfirmNewPasswordValidator extends TextFieldValidator {
  AuthController authController = Get.find<AuthController>();
  ConfirmNewPasswordValidator({required String errorText}) : super(errorText);
  //validator.auth.confirm.email.not.valid
  @override
  bool get ignoreEmptyValues => false;

  @override
  bool isValid(String? value) {
    if (value == authController.newPasswordController.value.text) {
      return true;
    } else {
      return false;
    }
  }
}

class InternationlPhoneValidator {
  //validator.auth.confirm.email.not.valid
  static final InternationlPhoneValidator _instance = InternationlPhoneValidator._internal();
  InternationlPhoneValidator._internal();
  factory InternationlPhoneValidator() => _instance;

  Rx<String>? countryIsoCode = ''.obs;

  //InternationlPhoneValidator({this.countryIsoCode});

  void update(String value) {
    log('updated');
    countryIsoCode!.value = value;
  }

  String? validator({String? value}) {
    if (value == null) {
      return 'validator.auth.required'.tr;
    }
    if (value.isEmpty) {
      return 'validator.auth.required'.tr;
    }
    switch (countryIsoCode!.value) {
      case 'CA':
        log('here CA :/');

        if (value.replaceAll(' ', '').length == 10) {
          return null;
        } else {
          return 'validator.auth.invalidPhone.min'.tr;
        }
      case 'US':
        log('US');

        if (value.replaceAll(' ', '').length == 10) {
          return null;
        } else {
          return 'validator.auth.invalidPhone.min'.tr;
        }
      case 'MA':
        // log('MO');
        if (value.replaceAll(' ', '').length == 9 || value.replaceAll(' ', '').length == 10) {
          return null;
        } else {
          return 'validator.auth.invalidPhone.min'.tr;
        }
      case 'DZ':
        if (value.replaceAll(' ', '').length == 9 || value.replaceAll(' ', '').length == 10) {
          return null;
        } else {
          return 'validator.auth.invalidPhone.min'.tr;
        }
      case 'SN':
        if (value.replaceAll(' ', '').length == 9 || value.replaceAll(' ', '').length == 10) {
          return null;
        } else {
          return 'validator.auth.invalidPhone.min'.tr;
        }
      case 'ML':
        if (value.replaceAll(' ', '').length == 9 || value.replaceAll(' ', '').length == 10) {
          return null;
        } else {
          return 'validator.auth.invalidPhone.min'.tr;
        }
      case 'CI':
        if (value.replaceAll(' ', '').length == 9 || value.replaceAll(' ', '').length == 10) {
          return null;
        } else {
          return 'validator.auth.invalidPhone.min'.tr;
        }
      case 'JM':
        if (value.replaceAll(' ', '').length == 10) {
          return null;
        } else {
          return 'validator.auth.invalidPhone.min'.tr;
        }
      default:
        log('default');
        log(countryIsoCode!.value);

        if (value.replaceAll(' ', '').length == 10) {
          return null;
        } else {
          return 'validator.auth.invalidPhone.min'.tr;
        }
    }
  }
}

class InternationlZipCodesValidator {
  //validator.auth.confirm.email.not.valid
  static final InternationlZipCodesValidator _instance = InternationlZipCodesValidator._internal();
  InternationlZipCodesValidator._internal();
  factory InternationlZipCodesValidator() => _instance;

  Rx<String>? countryIsoCode = ''.obs;

  //InternationlPhoneValidator({this.countryIsoCode});

  void update(String value) {
    //log('updated');
    countryIsoCode!.value = value;
  }

  String? validator(String? value) {
    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return null;
    }
    switch (countryIsoCode!.value) {
      case 'CA':
        // log('here CA :/');
        RegExp regExp = RegExp(r'^[A-Za-z]{1}[0-9]{1}[A-Za-z]{1}\s?[0-9]{1}[A-Za-z]{1}[0-9]{1}$');
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return 'validator.auth.wrongZipCode'.tr;
        }

      case 'US':
        //"^\d{5}([\-]?\d{4})?$"
        RegExp regExp = RegExp(r'^[0-9]{5}$');
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return 'validator.auth.wrongZipCode'.tr;
        }

      case 'MA':
        // log('MO');
        RegExp regExp = RegExp(r'^[0-9]{5}$');
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return 'validator.auth.wrongZipCode'.tr;
        }
      case 'DZ':
        RegExp regExp = RegExp(r'^[0-9]{5}$');
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return 'validator.auth.wrongZipCode'.tr;
        }
      case 'SN':
        RegExp regExp = RegExp(r'^[0-9]{5}$');
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return 'validator.auth.wrongZipCode'.tr;
        }
      case 'ML':
        RegExp regExp = RegExp(r'^[0-9]{5}$');
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return 'validator.auth.wrongZipCode'.tr;
        }
      case 'CI':
        RegExp regExp = RegExp(r'^[0-9]{5}$');
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return 'validator.auth.wrongZipCode'.tr;
        }
      case 'JM':
        RegExp regExp = RegExp(r'^[0-9]{2}$');
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return 'validator.auth.wrongZipCode'.tr;
        }
      case 'NE':
        RegExp regExp = RegExp(r'^[0-9]{4}$');
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return 'validator.auth.wrongZipCode'.tr;
        }
      default:
        // log('here CA :/');
        RegExp regExp = RegExp(r'^[A-Z]{1}[0-9]{1}[A-Z]{1}$');
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return 'validator.auth.wrongZipCode'.tr;
        }
    }
  }
}

class RequiredAndOptionalValidator extends TextFieldValidator {
  RequiredAndOptionalValidator({required String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => true;

  @override
  bool isValid(String? value) {
    if (value == null) {
      return true;
    }
    return value.isNotEmpty;
  }
}
