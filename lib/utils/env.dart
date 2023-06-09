import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';

enum BuildEnv { DEV, PROD }

class EnvironmentVar {
  static BuildEnv? buildEnv;

  static void init({required String env}) {
    buildEnv = env.isEmpty ? BuildEnv.DEV : enumFromString<BuildEnv>(env, BuildEnv.values);
  }
}