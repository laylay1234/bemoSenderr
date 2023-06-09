import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:mobileapp/models/ModelProvider.dart';

mixin Status {
  GenericStatus? castGenericStatus(str) {
    if (str is! String) return str;
    return enumFromString<GenericStatus>(str, GenericStatus.values);
  }

}
