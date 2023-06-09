import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:get/get.dart';
import 'package:mobileapp/models/ModelProvider.dart';

import '../utils/error_alerts_utils.dart';
import '../widgets/common/common.dart';

//this helper class is to manage the nested data problem (amplify flutter limitations)
//
class DatastoreHelper {
  static final DatastoreHelper _instance = DatastoreHelper._internal();
  DatastoreHelper._internal();
  factory DatastoreHelper() => _instance;
}
