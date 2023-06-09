import 'package:flutter_amplifysdk/utils.dart';
import 'package:get/get.dart';

class AppUtils {
  /*{
   "force_update":{
      "ios":{
         "app_id":"1362762458",
         "version":"0.3.0"
      },
      "android":{
         "app_id":"com.yallaxash.app",
         "version":"0.3.0"
      }
   },
   "privacy_policy_url":{
      "CA":{
         "en":"https://yallaxash.com/privacypolicyyallaxashmay2018/",
         "fr":"https://yallaxash.com/fr/privacypolicyyallaxashmay2018/"
      },
      "default":{
         "en":"https://yallaxash.com/privacypolicyyallaxashmay2018/",
         "fr":"https://yallaxash.com/fr/privacypolicyyallaxashmay2018/"
      }
   },
   "general_conditions_url":{
      "CA":{
         "en":"https://yallaxash.com/cguyallaxashfinanceltd/",
         "fr":"https://yallaxash.com/fr/cguyallaxashfinanceltd/"
      },
      "default":{
         "en":"https://yallaxash.com/cguyallaxashfinanceltd/",
         "fr":"https://yallaxash.com/fr/cguyallaxashfinanceltd/"
      }
   },
   "website_url":{
      "default":{
         "en":"https://yallaxash.com/",
         "fr":"https://yallaxash.com/fr/"
      }
   }
}*/
  static Json forceUpdate = {};
  static Json privacyPolicyUrl = {};
  static Json generalConditionsUrl = {};
  static Json websiteUrl = {};
  static int appSessionTimeout = 5; // default 5 minutes
  static void init(Json input) {
    if (input.containsKey('force_update')) {
      forceUpdate = input['force_update'];
    }
    if (input.containsKey('privacy_policy_url')) {
      privacyPolicyUrl = input['privacy_policy_url'];
    }
    if (input.containsKey('general_conditions_url')) {
      generalConditionsUrl = input['general_conditions_url'];
    }
    if (input.containsKey('website_url')) {
      websiteUrl = input['website_url'];
    }
    if (input.containsKey('app_session_timeout')) {
      appSessionTimeout = input['app_session_timeout'];
    }
  }

  static String getGeneralConditionsUrl(String countryCode, String lang) {
    Json urlList = generalConditionsUrl['default'];
    if (generalConditionsUrl.containsKey(countryCode.toUpperCase())) {
      urlList = generalConditionsUrl[countryCode.toUpperCase()];
    }
    String url = urlList['en'];
    if (urlList.containsKey(lang.toLowerCase())) {
      url = urlList[lang.toLowerCase()];
    }
    return url;
  }

  static String getPrivacyPolicyUrl(String countryCode, String lang) {
    Json urlList = privacyPolicyUrl['default'];
    if (privacyPolicyUrl.containsKey(countryCode.toUpperCase())) {
      urlList = privacyPolicyUrl[countryCode.toUpperCase()];
    }
    String url = urlList['en'];
    if (urlList.containsKey(lang.toLowerCase())) {
      url = urlList[lang.toLowerCase()];
    }
    return url;
  }

  static String getWebsiteUrl(String countryCode, String lang) {
    Json urlList = websiteUrl['default'];
    if (websiteUrl.containsKey(countryCode.toUpperCase())) {
      urlList = websiteUrl[countryCode.toUpperCase()];
    }
    String url = urlList['en'];
    if (urlList.containsKey(lang.toLowerCase())) {
      url = urlList[lang.toLowerCase()];
    }
    return url;
  }
}
