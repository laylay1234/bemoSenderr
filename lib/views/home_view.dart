import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_models/app_addressBook.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/utils/error_alerts_utils.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';

import '../controllers/send_money_controller.dart';
import '../widgets/dialogs/user_consent_dialog_widget.dart';
import '../widgets/dialogs/version_validation_dialog_widget.dart';
import 'home/contacts_views/contacts_view.dart';
import 'home/history_views/history_view.dart';
import 'home/send_money_views/send_view.dart';
import 'home/settings_views/settings_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const String id = '/home-view';

  @override
  Widget build(BuildContext context) {
    late final ProfileController profileController = Get.find<ProfileController>();
    final SendMoneyController sendMoneyController = Get.find<SendMoneyController>();
    final OriginController originController = Get.find<OriginController>();
    //sendMoneyController.loadAndSetCurrencies();
    //log(profileController.userInstance!.value.bank_verification_status);
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);
    log(originController.version.value.toString());
    // Utils().sendEmail(message: 'test');
    //AppAddressBook().listAddressBooks(userId: '');

    return Obx(() {
      return Scaffold(
          appBar: XemoAppBar(leading: false),
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: const Color(0xFF393939),
              selectedItemColor: Get.theme.primaryColorLight,
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.white,
              onTap: (val) {
                //
                profileController.currentIndex.value = val;
                //
                // log(val);
                switch (val) {
                  case 0:
                    //openUserConsentDialog();
                    // profileController.currentPage.value = profileController.views[0];
                    AnalyticsService().analytics.setCurrentScreen(screenName: SendView.id);
                    AnalyticsService().analytics.logScreenView(screenClass: SendView.id, screenName: SendView.id);
                    break;
                  case 2:
                    //
                    //  profileController.currentPage.value = profileController.views[2];
                    AnalyticsService().analytics.setCurrentScreen(screenName: HistoryView.id);
                    AnalyticsService().analytics.logScreenView(screenClass: HistoryView.id, screenName: HistoryView.id);
                    break;
                  case 1:
                    //
                    //   profileController.currentPage.value = profileController.views[1];
                    AnalyticsService().analytics.setCurrentScreen(screenName: ContactsView.id);
                    AnalyticsService().analytics.logScreenView(screenClass: ContactsView.id, screenName: ContactsView.id);
                    break;
                  case 3:
                    //  profileController.currentPage.value = profileController.views[3];
                    AnalyticsService().analytics.setCurrentScreen(screenName: SettingsView.id);
                    AnalyticsService().analytics.logScreenView(screenClass: SettingsView.id, screenName: SettingsView.id);
                    break;
                }
                //
              },
              currentIndex: profileController.currentIndex.value,
              items: [
                BottomNavigationBarItem(
                    backgroundColor: const Color(0x39393939),
                    label: 'common.send'.tr,
                    icon: profileController.currentIndex.value == 0
                        ? SvgPicture.asset(
                            'assets/xemo/icon-menu-home-active.svg',
                            height: 30.h,
                            width: 30.h,
                          )
                        : SvgPicture.asset(
                            'assets/xemo/icon-menu-home.svg',
                            height: 30.h,
                            width: 30.h,
                          )),
                BottomNavigationBarItem(
                    backgroundColor: const Color(0x39393939),
                    label: 'common.history'.tr,
                    icon: profileController.currentIndex.value == 1
                        ? SvgPicture.asset(
                            'assets/xemo/icon-menu-history.svg',
                            height: 30.h,
                            width: 30.h,
                            color: Get.theme.primaryColorLight,
                          )
                        : SvgPicture.asset(
                            'assets/xemo/icon-menu-history.svg',
                            height: 30.h,
                            width: 30.h,
                          )),
                BottomNavigationBarItem(
                    backgroundColor: const Color(0x39393939),
                    label: 'common.contacts'.tr,
                    icon: profileController.currentIndex.value == 2
                        ? SvgPicture.asset(
                            'assets/xemo/icon-menu-contacts.svg',
                            height: 30.h,
                            width: 30.h,
                            color: Get.theme.primaryColorLight,
                          )
                        : SvgPicture.asset(
                            'assets/xemo/icon-menu-contacts.svg',
                            height: 30.h,
                            width: 30.h,
                          )),
                BottomNavigationBarItem(
                    backgroundColor: const Color(0x39393939),
                    label: 'common.settings'.tr,
                    icon: profileController.currentIndex.value == 3
                        ? SvgPicture.asset(
                            'assets/xemo/icon-menu-settings.svg',
                            height: 30.h,
                            width: 30.h,
                            color: Get.theme.primaryColorLight,
                          )
                        : SvgPicture.asset(
                            'assets/xemo/icon-menu-settings.svg',
                            height: 30.h,
                            width: 30.h,
                          )),
              ]),
          body: profileController.views[profileController.currentIndex.value]);
    });
  }
}
