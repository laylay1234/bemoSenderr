import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/utils/env.dart';

import '../app_models/app_user.dart';
import '../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';

class Utils {
  RxList? recipients = [].obs;
  static final Utils _instance = Utils._internal();
  Utils._internal();
  factory Utils() => _instance;

  static Json systemDefaultValues = {};

  DateTime _startTime = DateTime.now();
  // ignore: non_constant_identifier_names
  void StartTimer({required String title}) {
    _startTime = DateTime.now();
    dbg('START TIME: $_startTime', cat: 'START $title');
  }

  Future<void> loadRecipientsFromBackend() async {
    //TODO get recipients from backends
  }

  void StopTimer({required String title, bool? showTime = true, int limit = 50}) {
    var _endTime = DateTime.now();
    int _timeSpent = _endTime.millisecondsSinceEpoch - _startTime.millisecondsSinceEpoch;
    if (_timeSpent >= limit) dbg('END TIME(ms), _timeSpent: $_timeSpent', cat: 'END $title');
    if (showTime == true) dbg('END TIME: $_endTime', cat: 'END $title');
  }

  static String getPlatform() {
    var platformName = '';
    if (kIsWeb) {
      platformName = "Web";
    } else {
      if (GetPlatform.isAndroid) {
        platformName = "Android";
      } else if (GetPlatform.isIOS) {
        platformName = "iOS";
      } else if (GetPlatform.isFuchsia) {
        platformName = "Fuchsia";
      } else if (GetPlatform.isLinux) {
        platformName = "Linux";
      } else if (GetPlatform.isMacOS) {
        platformName = "MacOS";
      } else if (GetPlatform.isWindows) {
        platformName = "Windows";
      }
    }
    return platformName;
  }

  Future<bool> sendEmail({required String message}) async {
    bool _statusCode = false;

    try {
      AppUser _loggedInUser = AppUser();
      final AuthController _authController = Get.find<AuthController>();
      String _from = _authController.userPhone.value.isNotEmpty
          ? _authController.userPhone.value
          : _loggedInUser.username != null
              ? _loggedInUser.username!
              : '';

      final OriginController _originController = Get.find<OriginController>();

      if (_from.isEmpty) return _statusCode;

      // AWS SES SMTP
      final username = dotenv.env['SMTP_USERNAME'];
      final password = dotenv.env['SMTP_PASSWORD'];
      final host = dotenv.env['SMTP_HOST'];
      final String smtp_sender = dotenv.env['SMTP_SENDER']!;

      SmtpServer _smtpServer = SmtpServer(host!, port: 465, username: username, password: password, ssl: true);
      List<String> _recipients = ['alertdev@yallaxash.com'];

      Message _message = Message()
        ..from = Address(smtp_sender, 'Yallaxash')
        ..recipients = _recipients
        ..subject = 'Yallaxash app error from $_from'
        ..text =
            'FROM ENV: ${EnvironmentVar.buildEnv?.name}\n\nAPP VERSION: ${_originController.version.value}\n\nPlatform: ${getPlatform()}\n\nUser: $_from\n\nERRORS: $message';

//
      final sendReport = await send(_message, _smtpServer);
      dbg(sendReport.toString());
      log(sendReport.toString());
      _statusCode = true;
    } on MailerException catch (e) {
      log(e.toString());
      dbg('Message not sent:\nProblems: ${e.problems}\nMessage: ${e.message}');
    }
    return _statusCode;
  }

  static bool? toNullBool(String? input) {
    bool? _ret;
    if (input != null) {
      String _val = input.toLowerCase();
      if (_val == 'true')
        _ret = true;
      else if (_val == 'false') _ret = false;
    }
    return _ret;
  }

  static bool toBool(String input) {
    bool _ret = false;
    if (input.isNotEmpty) {
      String _val = input.toLowerCase();
      if (_val == 'true')
        _ret = true;
      else if (_val == 'false') _ret = false;
    }
    return _ret;
  }

  static Json getCreateInput({required Json model}) {
    Json _createInput = {...model};
    // _createInput.remove('createdAt');
    _createInput.remove('updatedAt');
    return _createInput;
  }

  static Json getUpdateInput({required Json model, required Json input}) {
    Json _updateInput = {};
    if (model.keys.isNotEmpty) {
      for (var _item in input.entries) {
        // Ignore these fields
        if (_item.key != 'createdAt' && _item.key != 'updatedAt') model[_item.key] = _item.value;
      }
      input = model;
    }
    _updateInput = {...input};
    // _updateInput.remove('createdAt');
    _updateInput.remove('updatedAt');
    return _updateInput;
  }
}
