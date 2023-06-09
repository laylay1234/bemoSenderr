import 'package:get/get.dart';
import 'package:mobileapp/views/auth/auth.dart';
import 'package:mobileapp/views/auth/auth_register_phone_view.dart';
import 'package:mobileapp/views/flinks_views/flinks_failed_view.dart';
import 'package:mobileapp/views/flinks_views/flinks_pending_view.dart';
// import 'package:mobileapp/views/debug/layout_test_view.dart';
import 'package:mobileapp/views/home/contacts_views/add_contact_view.dart';
import 'package:mobileapp/views/home/send_money_views/deposit_view.dart';
import 'package:mobileapp/views/home/send_money_views/send_view.dart';
import 'package:mobileapp/views/home/send_money_views/send_money_view.dart';
import 'package:mobileapp/views/home/settings_views/change_password_view.dart';
import 'package:mobileapp/views/home_view.dart';
import 'package:mobileapp/views/splash_screen.dart';

import 'views/auth/auth_choose_lang_view.dart';
import 'views/auth/auth_connect_flinks_view.dart';
import 'views/auth/auth_register_address_view.dart';
import 'views/auth/auth_register_identity_infos_view.dart';
import 'views/auth/auth_register_email_view.dart';
import 'views/auth/auth_register_user_infos_view.dart';
import 'views/auth/password_confirm_reset_form_view.dart';
import 'views/connect_flinks_web_view.dart';
import 'views/flinks_views/flinks_success_view.dart';
import 'views/home/contacts_views/edit_contact_view.dart';
import 'views/home/contacts_views/send_to_contact_view.dart';
import 'views/home/send_money_views/checkout_view.dart';
import 'views/home/send_money_views/congrats_view.dart';
import 'views/home/send_money_views/select_receiver_views/select_receiver_view.dart';
import 'views/home/send_money_views/transfer_reason_view.dart';
import 'views/home/settings_views/edit_profile_view.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(
      name: LandingView.id,
      page: () => const LandingView(),
    ),
    GetPage(
      name: SplashScreen.id,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: WelcomeScreen.id,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: LoginView.id,
      page: () => const LoginView(),
    ),

    GetPage(
      name: RegisterConfirmView.id,
      page: () => const RegisterConfirmView(),
    ),
    GetPage(
      name: PasswordResetView.id,
      page: () => PasswordResetView(),
    ),
    GetPage(
      name: FlinksSuccessView.id,
      page: () => FlinksSuccessView(),
    ),
    GetPage(
      name: FlinksPendingView.id,
      page: () => FlinksPendingView(),
    ),
    GetPage(
      name: FlinksFailedView.id,
      page: () => FlinksFailedView(),
    ),
    GetPage(name: PasswordConfirmResetFormView.id, page: () => const PasswordConfirmResetFormView()),
    GetPage(name: AuthChooseLangView.id, page: () => const AuthChooseLangView()),
    GetPage(name: AuthRegisterPhoneView.id, page: () => const AuthRegisterPhoneView()),
    GetPage(name: AuthConnectWithFlinksView.id, page: () => const AuthConnectWithFlinksView()),
    GetPage(name: AuthRegisterUserInfosView.id, page: () => const AuthRegisterUserInfosView()),
    GetPage(name: AuthRegisterIdentityInfosView.id, page: () => const AuthRegisterIdentityInfosView()),
    GetPage(name: AuthRegisterUserCredentialView.id, page: () => const AuthRegisterUserCredentialView()),
    GetPage(name: AuthRegisterAddressView.id, page: () => const AuthRegisterAddressView()),

    // Let's use a hardcoded `home` route to easily change the associated views
    // without searching for all implementations

    // GetPage(
    //   name: RoomView.id,
    //   page: () => RoomView(),
    // ),
    // GetPage(name: '/shipping-select', page: () => SelectShippingView()),
    GetPage(name: ConnectWithFlinksWebView.id, page: () => const ConnectWithFlinksWebView()),
    GetPage(name: ChangePasswordView.id, page: () => const ChangePasswordView()),
    GetPage(name: HomeView.id, page: () => const HomeView()),
    GetPage(name: EditContactView.id, page: () => const EditContactView()),
    GetPage(name: EditProfileView.id, page: () => const EditProfileView()),
    GetPage(name: SendToContactView.id, page: () => const SendToContactView()),
    GetPage(name: AddContactView.id, page: () => const AddContactView()),
    GetPage(name: SendView.id, page: () => const SendView()),
    GetPage(name: CongratsView.id, page: () => const CongratsView()),
    GetPage(name: CheckOutView.id, page: () => const CheckOutView()),
    GetPage(name: DepositView.id, page: () => const DepositView()),

    GetPage(name: SendMoneyView.id, page: () => const SendMoneyView()),
    GetPage(name: TransferReasonView.id, page: () => const TransferReasonView()),
    GetPage(name: SelectReceiverView.id, page: () => const SelectReceiverView()),
    // GetPage(name: MeasurementSetting.id, page: () => MeasurementSetting()),
    // GetPage(name: LayoutTestView.id, page: () => LayoutTestView()),
    // GetPage(name: LayoutTestView.id, page: () => LayoutTestView()),
    // GetPage(name: BuildingPage.id, page: () => BuildingPage()),
  ];
}
