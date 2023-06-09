import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amplifysdk/flutter_amplifysdk.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:mobileapp/amplifyconfiguration.dart';
import 'package:mobileapp/app_models/app_user.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/controllers/send_money_controller.dart';
import 'package:mobileapp/controllers/transaction_controller.dart';
import 'package:mobileapp/firebase_options.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/helpers/notifications_manager.dart';
import 'package:mobileapp/localization.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/routes.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/utils/app_utils.dart';
import 'package:mobileapp/utils/env.dart';
import 'package:mobileapp/views/splash_screen.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/providers/country_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'utils/error_alerts_utils.dart';
// import 'package:camera/camera.dart';

Future<void> main() async {
  // List<CameraDescription>? cameras;
  // CameraDescription? firstCam;
  // Load environment

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  const String _buildEnv = String.fromEnvironment('BUILD_ENV', defaultValue: 'DEV');
  EnvironmentVar.init(env: _buildEnv);
  if (EnvironmentVar.buildEnv == BuildEnv.PROD) {
    await dotenv.load(fileName: "assets/prod.env");
  } else {
    await dotenv.load(fileName: "assets/dev.env");
  }
  String apiUrl = dotenv.env['API_URL']!;
  await RestService.instance.init(apiUrl: apiUrl);

  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    //this line prints the default flutter gesture caught exception in console
    //FlutterError.dumpErrorToConsole(details);
    Utils()
        .sendEmail(message: '${details.exception.toString()}\n${details.stack.toString()}\n${details.context.toString()}\n${details.stackFilter.toString()}');
  };

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // cameras = await availableCameras();
  // firstCam = cameras!.first;
  // initialize the new SDK.
  await Get.putAsync<AmplifyService>(
      () => AmplifyService().init<ModelProvider, AppUser>(amplifyConfig: amplifyconfig, modelProvider: ModelProvider.instance, appUserModel: AppUser()));

  // Setup controllers.  Since we have a lot of interdependencies, we keep them loaded all the time.

  OriginController appSettingsController = Get.put<OriginController>(OriginController(), permanent: true);
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  appSettingsController.buildNumber.value = packageInfo.buildNumber;
  appSettingsController.version.value = packageInfo.version;

  AuthController _authController = Get.put<AuthController>(AuthController<User>(), permanent: true);
  // Get pickles
  await _authController.getAppVersionsDataFromApi();

  Get.put<SendMoneyController>(SendMoneyController(), permanent: true);
  Get.put<ProfileController>(ProfileController(), permanent: true);
  Get.put<ContactsController>(ContactsController(), permanent: true);
  Get.put<TransactionController>(TransactionController(), permanent: true);
  CountryProvider().init();

  Translations local = await LocaleStrings().init();
  dbg("Ready To Run App", cat: 'INIT', isError: false);

  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // runApp(MyApp(settingsController: settingsController));

  if (await NotificationsManger().requestPermission()) {
    await NotificationsManger().init();
  }
  AnalyticsService().analytics.logAppOpen();

  runApp(XemoTransferApp(local: local));
}

class XemoTransferApp extends StatelessWidget {
  const XemoTransferApp({
    Key? key,
    required this.local,
  }) : super(key: key);

  final Translations local;

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    Duration _timeOutValueInSeconds = Duration(minutes: AppUtils.appSessionTimeout);
    final sessionConfig = SessionConfig(invalidateSessionForAppLostFocus: _timeOutValueInSeconds, invalidateSessionForUserInactiviity: _timeOutValueInSeconds);

    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      // Stop the session timeout manager after login
      authController.stopSessionTimer();
      authController.disconnect();
      // TODO: remove this later
      // if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
      //   // handle user  inactive timeout
      //   // Navigator.of(context).pushNamed("/auth");
      //   if (authController.isLoggedIn) {
      //     authController.disconnect();
      //   }
      // } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
      //   // handle user  app lost focus timeout
      //   // Navigator.of(context).pushNamed("/auth");
      //   if (authController.isLoggedIn) {
      //     authController.disconnect();
      //   }
      // }
    });
    
    return SessionTimeoutManager(
      sessionConfig: sessionConfig,
      sessionStateStream: authController.sessionTimeoutManagerStateStream.stream,
      userActivityDebounceDuration: const Duration(seconds: 10),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          translations: local,
          navigatorObservers: [AnalyticsService().getAnalyticsObserver()],
          onGenerateRoute: (v) => log(v.name ?? ''),
          locale: ProfileController.defaultLocale,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          fallbackLocale: ProfileController.fallbackLocale,
          initialRoute: SplashScreen.id,
          getPages: AppRoutes.routes,
          themeMode: ThemeMode.light,
          theme: XemoTransferTheme.theme,
          darkTheme: XemoTransferTheme.darkTheme,
        ),
      ),
    );
  }
}
