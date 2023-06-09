import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:get/get.dart';

import '../utils/error_alerts_utils.dart';

class AnalyticsService {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: analytics);

  static final AnalyticsService _instance = AnalyticsService._internal();
  AnalyticsService._internal();
  factory AnalyticsService() => _instance;

  Future<void> setUserId({required String userId}) async {
    try {
      await analytics.setUserId(id: userId);
      // getAnalyticsObserver();
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      dbg('AnalyticsService: setUserId ' + error.toString(), isError: true);
      //
    }
  }
}
