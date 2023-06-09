import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_pinpoint_api/pinpoint-2016-12-01.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_amplifysdk/flutter_amplifysdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/views/home_view.dart';
import 'package:mobileapp/widgets/dialogs/transaction_details_dialog_widget.dart';
import 'package:mobileapp/widgets/snackbars/on_user_tier_error_upgrade_snackbar.dart';
import 'package:mobileapp/widgets/snackbars/on_user_tier_upgrade_snackbar.dart';
import 'package:mobileapp/widgets/snackbars/transaction_snackbars/any_to_error_snackbar.dart';
import 'package:mobileapp/widgets/snackbars/transaction_snackbars/funded_to_ready_snackbar.dart';
import 'package:mobileapp/widgets/snackbars/transaction_snackbars/ready_to_paid_snackbar.dart';
import 'package:mobileapp/widgets/snackbars/transaction_snackbars/waiting_fund_snackbar.dart';

import '../entities/endpoint_data_entity.dart';
import '../models/ModelProvider.dart';
import '../utils/error_alerts_utils.dart';

//local notification plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//local channel for android
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  importance: Importance.high,
);
////new way to show notifcation when app is in foreground/backdgroun
const IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails(
  presentAlert: true, // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
  presentBadge:
      true, // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
  presentSound: false, // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
  // sound: String?,  // Specifics the file path to play (only from iOS 10 onwards)
  badgeNumber: 1, // The application's icon badge number
  //attachments: List<IOSNotificationAttachment>?, (only from iOS 10 onwards)
  //subtitle: String?, //Secondary description  (only from iOS 10 onwards)
  //threadIdentifier: String? (only from iOS 10 onwards)
);

const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');

const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
  requestSoundPermission: false,
  requestBadgePermission: false,
  requestAlertPermission: false,
  // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
);

const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: null);

///class notification manager
class NotificationsManger {
  static final NotificationsManger _instance = NotificationsManger._internal();
  NotificationsManger._internal();
  factory NotificationsManger() => _instance;

  ProfileController get profileController {
    return Get.find<ProfileController>();
  }

  //for forgreound/background cases
  Rx<bool> isBackground = false.obs;
  RxMap<String, dynamic> data = <String, dynamic>{}.obs;
  Rx<String> type = ''.obs;
  //
  final String applicationId = dotenv.env['APP_ID']!;
  //for dev 94858d1d9550499cbd3ef0175c0961bc
  //for prod 327cf682de214b22830cca1513c1d574
  Rx<Pinpoint> service = Pinpoint(region: '').obs;
  Rx<String> userId = ''.obs;
  Rx<String> token = ''.obs;

  Future<void> init() async {
    await initLocalNotifSettings();
    await enableAutoInit();
    //handle the background message
    FirebaseMessaging.onBackgroundMessage(_firebaseMessaginOnBackground);
    //TODO handle when on message
    FirebaseMessaging.onMessage.listen((event) {
      log("heeree :" + event.data.toString());
      log('here' + event.notification!.body!.toString());
      log("heeree :" + event.data.length.toString());

      String type = event.data['type'] ?? '';
      if (type == 'transaction') {
        handleTransactionNotificationEvent(event.data);
      } else if (type == 'user_tier') {
        handleUserTierNotificationEvent(event.data);
      }
      // log(event.toString());
    });
    //TODO handle when its notifcation is clicked
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //log(event.toString());
      if (event.data['type'] == 'transaction') {
        type.value = 'transaction';
        String globalTransactionId = data['transaction'] ?? '';
        String status = data['status'] ?? '';
        GlobalTransactionStatus globalTransactionStatus =
            GlobalTransactionStatus.values.where((e) => e.name.toString().toLowerCase().contains(status.toString().toLowerCase())).first;
        //
        //
        log("handleTransactionNotificationEvent " + globalTransactionId);
        //
        //
        GlobalTransaction globalTransaction =
            (profileController.globalTransactions!.where((e) => e.id == globalTransactionId).first).copyWith(status: globalTransactionStatus);

        if (Get.currentRoute == HomeView.id) {
          profileController.currentIndex.value = 1;
          profileController.currentPage.value = profileController.views[1];
          openTransactionDetailsDialog(transaction: globalTransaction);
        } else {
          Get.offAllNamed(HomeView.id);
          profileController.currentIndex.value = 1;
          profileController.currentPage.value = profileController.views[1];
          openTransactionDetailsDialog(transaction: globalTransaction);
        }
      } else if (event.data['type'] == 'user_tier') {
        if (Get.currentRoute == HomeView.id) {
          profileController.currentIndex.value = 3;
          profileController.currentPage.value = profileController.views[3];
        } else {
          Get.offAllNamed(HomeView.id);
          profileController.currentIndex.value = 3;
          profileController.currentPage.value = profileController.views[3];
        }
      }
    });
  }

  Future<void> initLocalNotifSettings() async {
    try {
      // ignore: prefer_const_declarations
      final InitializationSettings initializationSettings =
          const InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS, macOS: null);

      await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (val) {
        //when notif is tapped here
        //TODO implement this
      });
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("from initLocalNotifSettings" + error.toString());
    }
  }

  Future<void> enableAutoInit() async {
    try {
      await FirebaseMessaging.instance.setAutoInitEnabled(true);
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log('from enableAutoInit' + error.toString());
    }
  }

  Future<bool> requestPermission() async {
    try {
      NotificationSettings notificationSettings =
          await FirebaseMessaging.instance.requestPermission(alert: true, sound: true, badge: true, provisional: false);
      if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
        return true;
      } else if (notificationSettings.authorizationStatus == AuthorizationStatus.provisional) {
        return true;
      } else {
        return false;
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("from requestPermission " + error.toString());
      return false;
    }
  }

  Future<bool> isNotificationEnabled() async {
    try {
      NotificationSettings notificationSettings = await FirebaseMessaging.instance.getNotificationSettings();
      if (notificationSettings.authorizationStatus == AuthorizationStatus.authorized) {
        return true;
      } else {
        return false;
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("from isNotificationEnabled " + error.toString());
      return false;
    }
  }

  Future<String?> getCurrentToken() async {
    token.value = (await FirebaseMessaging.instance.getToken()) ?? '';
    return (token.value);
  }

  String getDeviceType() {
    if (TargetPlatform.android == defaultTargetPlatform) {
      return 'android';
    } else if (TargetPlatform.iOS == defaultTargetPlatform) {
      return 'ios';
    }
    return 'not_phone';
  }

  Future<void> handleUserTierNotificationEvent(Map<String, dynamic> data) async {
    try {
      String bank_status = data['bank_verification_status'] ?? '';
      String oldUserTierLevel = data['old_user_tier_level'];
      String newOldUserTierLevel = data['new_user_tier_level'];
      //
      if (bank_status == 'error') {
        onUserTierUpgradeErrorSnackBar(profileController.userInstance!.value.copyWith(kyc_level: int.parse(newOldUserTierLevel)));
        return;
      }
      if (double.parse(oldUserTierLevel) < double.parse(newOldUserTierLevel)) {
        onUserTierUpgradeSnackBar(profileController.userInstance!.value.copyWith(kyc_level: int.parse(newOldUserTierLevel)));
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log("from handleUserTierNotificationEvent" + error.toString());
    }
  }

  Future<void> handleTransactionNotificationEvent(Map<String, dynamic> data) async {
    try {
      String globalTransactionId = data['transaction'] ?? '';
      String status = data['status'] ?? '';
      GlobalTransactionStatus globalTransactionStatus =
          GlobalTransactionStatus.values.where((e) => e.name.toString().toLowerCase().contains(status.toString().toLowerCase())).first;
      //
      //
      log("handleTransactionNotificationEvent " + globalTransactionId);
      //
      //
      GlobalTransaction globalTransaction =
          (profileController.globalTransactions!.where((e) => e.id == globalTransactionId).first).copyWith(status: globalTransactionStatus);

      switch (globalTransaction.status) {
        case GlobalTransactionStatus.NEW:
          //
          startWaitingToBeFundedSnackBar(globalTransaction);
          break;
        case GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS:
          //
          startWaitingToBeFundedSnackBar(globalTransaction);
          break;
        case GlobalTransactionStatus.COLLECTTRANSACTION_IN_PROGRESS:
          //
          startFundedToReadySnackbar(globalTransaction);
          break;
        case GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS:
          //
          startAnyToErrorSnackbar(globalTransaction);
          break;
        case GlobalTransactionStatus.SUCCESS:
          //
          startReadyToPaidSnackbar(globalTransaction);
          break;
        case GlobalTransactionStatus.CANCELLED:
          //
          startAnyToErrorSnackbar(globalTransaction);
          break;
        case GlobalTransactionStatus.MANUAL_INTERVENTION_NEEDED:
          //
          startAnyToErrorSnackbar(globalTransaction);
          break;
        case GlobalTransactionStatus.REFUNDED:
          //
          startFundedToReadySnackbar(globalTransaction);
          break;
        case GlobalTransactionStatus.BLOCKED:
          //
          startAnyToErrorSnackbar(globalTransaction);
          break;
        case GlobalTransactionStatus.COLLECT_ERROR:
          //
          startAnyToErrorSnackbar(globalTransaction);
          break;
        case GlobalTransactionStatus.COLLECT_ON_HOLD:
          //
          startFundedToReadySnackbar(globalTransaction);
          break;
        case GlobalTransactionStatus.FUNDING_ERROR:
          //
          startAnyToErrorSnackbar(globalTransaction);
          break;
        case GlobalTransactionStatus.NOT_FOUND:
          //
          startAnyToErrorSnackbar(globalTransaction);
          break;
        case GlobalTransactionStatus.REFUNDED_ERROR:
          //
          startAnyToErrorSnackbar(globalTransaction);
          break;
      }
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      log(error.toString());
    }
  }

  Future<void> initPinpoint({AwsClientCredentials? credentials, String? id}) async {
    service.value = Pinpoint(
      region: 'us-west-2',
      credentials: credentials,
    );
    userId.value = id!;
  }

  Future<List<String?>> getUserEndpoints() async {
    List<String> ids = [];
    try {
      // log((service.value != null).toString());
      // log((userId != null).toString());
      final response = await service.value.getUserEndpoints(applicationId: applicationId, userId: userId.value);
      // log('response' + response.toString());
      for (var e in response.endpointsResponse.item) {
        if (e.id != null) {
          ids.add(e.id!);
        }
      }
      return ids;
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      //TODO handle error
      log('from getUserEndpoints ' + error.toString());
    }
    return ids;
  }

  Future<void> updateEndPoint({String? endpointId}) async {
    // final response = await service.value.updateEndpoint(
    //     applicationId: applicationId, endpointId: endpointId!, endpointRequest: EndpointRequest(address: token.value, optOut: 'NONE'));
    // log("from updateEndPoint : " + response.messageBody.toString());
  }

  Future<void> updateEndpoints({User? user}) async {
    try {
      /*
      List<String?> ids = await getUserEndpoints();
      if (ids.isEmpty) {
        //TODO handle when ids is empty

      } else {
        for (var id in ids) {
          await updateEndPoint(endpointId: id);
        }
      }
      */

      /*
      EndpointDataEntity endpointDataEntity = EndpointDataEntity(endpointId: '', device_token: token.value, cognito_user_id: userId.value);
      String endpointId = UUID.getUUID();
=      if (TargetPlatform.android == defaultTargetPlatform) {
        UpdateEndpointResponse response = await service.value.updateEndpoint(
            applicationId: applicationId,
            endpointId: endpointId,
            endpointRequest:
                EndpointRequest(address: token.value, optOut: 'NONE', channelType: ChannelType.gcm, user: EndpointUser(userId: userId.value)));
        log("from updateEndPoint : " + response.messageBody.message.toString());
        endpointDataEntity.platform = 'android';
      } else if (TargetPlatform.iOS == defaultTargetPlatform) {
        UpdateEndpointResponse response = await service.value.updateEndpoint(
            applicationId: applicationId,
            endpointId: endpointId,
            endpointRequest:
                EndpointRequest(address: token.value, optOut: 'NONE', channelType: ChannelType.apns, user: EndpointUser(userId: userId.value)));
        log("from updateEndPoint : " + response.messageBody.message.toString());
        endpointDataEntity.platform = 'ios';
      }
      
      if (user!.data == null) {
        Map<String, dynamic> data = {};

        data['endpoints'] = [endpointDataEntity.toJson()];
        String encodedData = json.encode(data);
        User updatedUser = user.copyWith(data: encodedData);
        await Amplify.DataStore.save(updatedUser);
        profileController.userInstance!.value = updatedUser;
      } else {
        Map<String, dynamic> decodedData = json.decode(user.data ?? '{}');
        List<EndpointDataEntity> endpointData = List.from(decodedData['endpoints'] ?? []).map((e) => EndpointDataEntity.fromJson(e)).toList();
        endpointData.add(EndpointDataEntity(endpointId: '', device_token: token.value, cognito_user_id: userId.value));
        decodedData['endpoints'] = endpointData.map((e) => e.toJson()).toList();
        String encodedData = json.encode(decodedData);
        User updatedUser = user.copyWith(data: encodedData);
        await Amplify.DataStore.save(updatedUser);
        profileController.userInstance!.value = updatedUser;
      }
*/
      // log("from updateEndPoint : " + response.messageBody.message!.toString());
    } catch (error, stackTrace) {
      Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
      //TODO handle error
      log("updateEndpoints " + error.toString());
    }
  }
}

Future<void> _firebaseMessaginOnBackground(RemoteMessage message) async {
  //

  //

  //
  //ProfileController profileController = Get.find<ProfileController>();
  log(message.toString());
  try {
    await Firebase.initializeApp();
    log(' a bg message just showed up' + (message.messageId ?? ''));
    //display notification for android when in the background

    //
    NotificationsManger().isBackground.value = true;
    NotificationsManger().isBackground.value = true;
    NotificationsManger().data.value = message.data;

    if (message.data['type'] == 'transaction') {
      NotificationsManger().type.value = 'transaction';
    } else if (message.data['type'] == 'user_tier') {
      NotificationsManger().type.value = 'user_tier';
    }
    //

    //
  } catch (error, stackTrace) {
    //Get.put(AuthController());
    //Utils().sendEmail(message: '${error.toString()}\n${stackTrace.toString()}');
    log(error.toString());
  }
}
