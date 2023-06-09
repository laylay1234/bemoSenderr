import 'package:flutter_amplifysdk/errors.dart';
import 'package:flutter_amplifysdk/exception.dart';
import 'package:flutter_amplifysdk/utils.dart';

import 'utils/utils.dart';

enum ErrorType {
  AuthRegister,
  AuthRegisterConfirmation,
  AuthLoginCustom,
  AuthLoginGoogle,
  AuthLogout,
  AuthResetPassword,
  AuthResetPasswordConfirmation,
}

final Map<ErrorType, String> messages = {
  ErrorType.AuthRegister: 'Could not register',
  ErrorType.AuthRegisterConfirmation: 'Wrong validation code',
  ErrorType.AuthLoginCustom: 'Wrong credentials',
  ErrorType.AuthLoginGoogle: 'Could not connect with Google',
  ErrorType.AuthLogout: 'Error while disconnecting',
  ErrorType.AuthResetPassword: 'Could not reset password',
  ErrorType.AuthResetPasswordConfirmation: 'Wrong validation code',
};

class XemoTransferError implements Exception {
  XemoTransferError({required this.type, required this.stack}) : message = messages[type];

  final ErrorType? type;

  // Message displayed in production
  final String? message;

  // Message displayed in debug
  final Exception? stack;
}

class XemoErrorType extends SDKErrorType {
  /****** FOR ALL ERROR CODE ******/

  //
  String saveUserFailed = '';
}

/// Use this inside views with try catch and showing a loader/progress widget and to show this error in a snackbar.
class XemoException extends SDKException {
  XemoException({required errorCode, category, exception, stackTrace})
      : super(errorCode: errorCode, category: category, exception: exception, stackTrace: stackTrace) {
    String _strException = '';
    if (this.exception is XemoGenericException || this.exception is UnknownErrorAmplifyException) {
      _strException = this.exception.toString();
    } else {
      _strException = this.exception.toString();
      try {
        if (this.exception.exception != null) {
          _strException = this.exception.exception.message;
        }
      } catch (error) {}
    }
    // Utils.sendEmail(message: '${this.message}\n${_strException}\n${this.stackTrace.toString()}');
  }
}

/// Use this for throwing a simple exception.
class XemoGenericException extends BaseAmplifyException {
  final String errorStr;

  XemoGenericException(this.errorStr) {
    dbg(this.errorStr);
  }

  String errMsg() => this.errorStr;
  @override
  String toString() {
    return this.errorStr;
  }
}
