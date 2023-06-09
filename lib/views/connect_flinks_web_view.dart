import 'dart:async';
import 'dart:developer' as d;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/utils/app_utils.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/common/rotated_spinner.dart';

import 'package:flutter/foundation.dart';

class ConnectWithFlinksWebView extends StatelessWidget {
  static const String id = '/connect-flinks-webview';
  const ConnectWithFlinksWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    OriginController originController = Get.find<OriginController>();
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    //
    // bool fromRegister = ((Get.arguments['fromRegister'] ?? false) as bool);
    bool flinksRequestSent = false;
    //
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);
    var generalCondLink =
        AppUtils.getGeneralConditionsUrl(originController.origin_country_iso.value.toUpperCase(), Get.locale!.languageCode.toLowerCase());
    final String flinksUrl = authController.flinksUrl.value;
    // var flinksStyle = GetPlatform.isIOS ? 'style="width=100%;height=100%"' : 'style="width=100%;height=100%"';
    GetPlatform.isIOS ? d.log('is ios') : d.log('is android');
    return Scaffold(
      appBar: XemoAppBar(leading: true, function: backLogoutInSignUp),
      body: WebView(
          initialUrl: flinksUrl,
          onWebViewCreated: (webViewController) {
            if (!authController.webViewController.isCompleted) {
              authController.webViewController.complete(webViewController);
            }
          },
          javascriptMode: JavascriptMode.unrestricted,
          onPageStarted: (url) {
            Get.dialog(
              Center(
                  child: RotatedSpinner(
                spinnerColor: SpinnerColor.GREEN,
                height: 35,
                width: 35,
              )),
            );
            d.log(url);
          },
          onProgress: (progress) {
            d.log(progress.toString());
          },
          onPageFinished: (url) {
            if (Get.isOverlaysOpen) {
              Get.back();
            }
            d.log(url);
          },
          navigationDelegate: (navigation) {
            String url = navigation.url;
            // NOTE: Using startWith() instead of contains()
            //       The issue with contains(), we match the full iframe url.
            if (url.toLowerCase().startsWith(generalCondLink)) {
              launch(url);
              d.log('url launching');
            } else if (url.toLowerCase().contains('loginid')) {
              if (!flinksRequestSent) {
                authController.setLoginIdFromUrl(url, authController.isSignUpFlow.value);
                flinksRequestSent = true;
                d.log('send bank api request');
              }
            }
            d.log(url);

            return NavigationDecision.navigate;
          }),
    );
  }

/*
https://yallaxash-iframe.private.fin.ag/v2/Result/FlinksCapital?thank-you=true&demo=true&loginId=c1e77837-4869-4669-786a-08d85b13343d&accountId=c1314dee-fc77-4912-9f74-91f5925ee3af&institution=FlinksCapital 
*/

//https://yallaxash-iframe.private.fin.ag/v2/?headerEnable=false&productType=banking&institutionsLocation=ca&institutionFilterEnable=true&accountSelectorEnable=true&showAllAccounts=true&accountSelectorCurrency=cad

  /*
  String getFlinksUrl(generalCondLink) {
    ProfileController profileController = Get.find<ProfileController>();
    OriginController originController = Get.find<OriginController>();
    AuthController authController = Get.find<AuthController>();
    // TODO: Refactor to prevent code duplication
    if (authController.isSignUpFlow.value) {
      String flinksUrl =
          "https://yallaxash-iframe.private.fin.ag/v2/?demo=false&headerEnable=false&redirectUrl=https://flinks.com/contact/thank-you&productType=banking&institutionsLocation=ca&institutionFilterEnable=true&accountSelectorEnable=true&showAllAccounts=true&accountSelectorCurrency=cad";
      String currentLocal = Get.locale!.languageCode.toLowerCase();
      if (currentLocal == 'fr') {
        flinksUrl = flinksUrl + "&language=$currentLocal";
      }
      flinksUrl = flinksUrl + '&termsNoCheckbox=true&customerName=YallaXash&termsUrl=$generalCondLink';
      return flinksUrl;
    } else {
      String flinksUrl =
          "https://yallaxash-iframe.private.fin.ag/v2/?demo=false&headerEnable=false&redirectUrl=https://flinks.com/contact/thank-you&productType=banking&institutionsLocation=ca&institutionFilterEnable=true&accountSelectorEnable=true&showAllAccounts=true&accountSelectorCurrency=cad";
      String currentLocal = Get.locale!.languageCode.toLowerCase();
      if (currentLocal == 'fr') {
        flinksUrl = flinksUrl + "&language=$currentLocal";
      }
      flinksUrl = flinksUrl + '&termsNoCheckbox=true&customerName=YallaXash&termsUrl=$generalCondLink';
      return flinksUrl;
    }
  }
*/
  void backLogoutInSignUp() async {
    AuthController authController = Get.find<AuthController>();
    Get.back();
    Completer<WebViewController> init = Completer<WebViewController>();
    authController.webViewController = init;
  }
}
