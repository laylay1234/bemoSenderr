import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/widgets/common/all_widgets.dart';

// FIXME: this should be able to just extend sdktheme and change what needs changing

class XemoTransferTheme {
  static const double _mockUpWidth = 375;
  static const double _mockUpHeight = 812;

  //TODO: maybe theme is not the best place for getImageHolder
  static String getImageHolder() {
    return Get.isDarkMode ? "assets/images/dark_mode_image_holder.svg" : "assets/images/light_mode_image_holder.svg";
  }

  static Color getBorderColor() {
    return Get.isDarkMode ? kDarkSolidGreyColor : kLightSolidGreyColor;
  }

  static Color getRedButtonColor() {
    return Get.isDarkMode ? kDarkDisplayRedAction : kLightDisplayRedAction;
  }

  static Color getCircularBorder() {
    return Get.isDarkMode ? kLightDisplayOnPrimaryAction : kDarkDisplayOnPrimaryAction;
  }

  static Color getDisableTextColor() {
    return Get.isDarkMode ? kDarkDisableTextGreyColor : kLightDisableTextGreyColor;
  }

  static Color getkBackgroundGreyColor() {
    return Get.isDarkMode ? kDarkBackgroundGreyColor : kLightBackgroundGreyColor;
  }

  static Color getBackgroundAccent() {
    return Get.isDarkMode ? kDarkDisplaySecondaryBackgroundAccentColor : kLightDisplaySecondaryBackgroundAccentColor;
  }

  static Color getCircleAvatarForeground() {
    return Get.isDarkMode ? kDarkDisplayPrimaryAction : kLightDisplayPrimaryAction;
  }

  static Color getCircleAvatarBackground() {
    return Get.isDarkMode ? kDarkDisplayPrimaryBackgroundColor : kLightDisplayPrimaryBackgroundColor;
  }

  static Color getCircleAvatarNotBuildingBackground() {
    return Get.isDarkMode ? kDarkDisplayPrimaryAction : kLightDisplayPrimaryAction;
  }

  static Color getCircleAvatarNotBuildingForeground() {
    return Get.isDarkMode ? kDarkDisplayOnPrimaryAction : kLightDisplayOnPrimaryAction;
  }

  static Color getWhiteTextColor() {
    return Get.isDarkMode ? kDarkWhiteDisplayTextColor : kLightWhiteDisplayTextColor;
  }

  static Color getMainColor() {
    return Get.isDarkMode ? kDarkMainColor : kLightMainColor;
  }

  static Color getTransparent() {
    return Colors.transparent;
  }

  static double textScaleFactor() {
    return Get.width / _mockUpWidth;
  }

  // static double viewScaleHeight(double height) {
  //   return height * (_mockUpHeight / Get.height);
  // }

  // static double viewScaleWidth(double width) {
  //   return width * (_mockUpWidth / Get.width);
  // }

  static double widthScalingPercent(double width) {
    return Get.width * (width / _mockUpWidth);
  }

  static double heightScalingPercent(double height) {
    return Get.height * (height / _mockUpHeight);
  }

  static Color getSecondaryActionColor() {
    return Get.isDarkMode ? kDarkDisplaySecondaryAction : kLightDisplaySecondaryAction;
  }

//   static double heightForResponsiveLayout(double height){
//     //it gives you percentage of how much space it uses on every view
//     return Get.height * (height/Get.height);
//   }

//   static double widthForResponsiveLayout(double width){
//     //it gives you percentage of how much space it uses on every view
//     return Get.width * (width/Get.width);
//   }

  static get theme {
    final originalTextTheme = SDKTheme.lightTheme.textTheme;
    return SDKTheme.lightTheme.copyWith(
      primaryColorLight: const Color(0xFF66DAC0),
      primaryColorDark: const Color(0xFF66DAC0),
      backgroundColor: kLightDisplayPrimaryBackgroundColor,
      tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
            borderSide: BorderSide(
          color: kLightDisplayPrimaryAction,
        )),
        labelColor: kLightDisplayPrimaryAction,
        unselectedLabelColor: kLightDisplayPrimaryAction,
      ),
      canvasColor: kLightDisplaySecondaryBackgroundColor,
      textTheme: TextTheme(
        headline1: TextStyle(fontFamily: 'Ubuntu', fontSize: 44.sp, fontWeight: FontWeight.w600, color: kLightDisplayTextColor),
        //JUMBOTRON
        headline2: TextStyle(fontFamily: 'Ubuntu', fontSize: 22.sp, fontWeight: FontWeight.w600, color: kLightDisplayTextColor),
        //PageHeader
        headline3: TextStyle(fontFamily: 'Ubuntu', fontSize: 20.sp, fontWeight: FontWeight.w600, color: kLightDisplayTextColor),
        headline4: TextStyle(fontFamily: 'Ubuntu', fontSize: 18.sp, fontWeight: FontWeight.w400, color: kLightDisplayTextColor),
        //SectionHeader
        headline5: TextStyle(fontFamily: 'Ubuntu', fontSize: 30.sp, fontWeight: FontWeight.w800, color: kLightDisplayTextColor),
        //Jumbotext
        subtitle1: TextStyle(fontFamily: 'Ubuntu', fontSize: 16.sp, fontWeight: FontWeight.w700, color: kLightDisplayTextColor),
        // Title bold
        subtitle2: TextStyle(fontFamily: 'Ubuntu', fontSize: 14.sp, fontWeight: FontWeight.w600, color: kLightDisplayTextColor),
        // Subhead
        bodyText1: TextStyle(
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          color: kLightDisplaySecondaryTextColor,
        ),
        button: TextStyle(fontFamily: 'Ubuntu', fontWeight: FontWeight.w700, fontSize: 16.sp, color: kLightDisplayOnSecondaryActionAlt),
        //body Medium == body/default in figma

        bodyText2: TextStyle(fontFamily: 'Ubuntu', fontSize: 16.sp, fontWeight: FontWeight.w400, color: kLightDisplayTextColor),
        overline: TextStyle(
            fontFamily: 'Ubuntu', decoration: TextDecoration.underline, fontSize: 12.sp, fontWeight: FontWeight.w700, color: kLightDisplayTextColor),
        //Caption title
        caption: TextStyle(fontFamily: 'Ubuntu', fontSize: 12.sp, fontWeight: FontWeight.w400, color: kLightDisplayTextColor), //caption
      ),
      appBarTheme: AppBarTheme(
        color: const Color(0xFF66DAC0),
        iconTheme: IconThemeData(color: kLightDisplayPrimaryAction),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        suffixStyle: TextStyle(
          fontFamily: 'Ubuntu',
          color: kSolidRedColor,
          backgroundColor: kGreenColor,
        ),
      ),
      primaryColor: kLightDisplayPrimaryBackgroundColor,
      scaffoldBackgroundColor: kLightDisplayPrimaryBackgroundColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              Color _bgColor = kLightDisplayPrimaryAction;
              if (states.contains(MaterialState.disabled)) {
                return _bgColor.withOpacity(0.5);
              }
              return _bgColor.withOpacity(1);
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              return kLightDisplayOnPrimaryAction;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(71),
            ))),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(kLightDisplayOnSecondaryAction),
            backgroundColor: MaterialStateProperty.all<Color>(kLightDisplayPrimaryBackgroundColor),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                color: kLightDisplaySecondaryBackgroundColor,
                style: BorderStyle.solid,
              ),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ))),
      ),
      dividerColor: kLightDisplayTextColor,
      iconTheme: IconThemeData(color: kLightDisplayTextColor),
      primaryTextTheme: originalTextTheme.apply(
        displayColor: kLightDisplayTextColor,
        bodyColor: kLightDisplayTextColor,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kLightDisplaySecondaryBackgroundColor),
    );
  }

  static get darkTheme {
    final originalTextTheme = SDKTheme.darkTheme.textTheme;
    return SDKTheme.darkTheme.copyWith(
      tabBarTheme: TabBarTheme(
        indicator: UnderlineTabIndicator(borderSide: BorderSide(color: kDarkDisplayPrimaryAction)),
        labelColor: kDarkDisplayPrimaryAction,
        unselectedLabelColor: kDarkDisplayPrimaryAction,
      ),
      //canvasColor: Colors.transparent,
      canvasColor: kDarkDisplaySecondaryBackgroundColor,
      textTheme: TextTheme(
        headline1: TextStyle(fontFamily: 'Ubuntu', fontSize: 44.sp, fontWeight: FontWeight.w600, color: kDarkDisplayTextColor),
        //JUMBOTRON
        headline2: TextStyle(fontFamily: 'Ubuntu', fontSize: 22.sp, fontWeight: FontWeight.w600, color: kDarkDisplayTextColor),
        //PageHeader
        headline3: TextStyle(fontFamily: 'Ubuntu', fontSize: 20.sp, fontWeight: FontWeight.w600, color: kDarkDisplayTextColor),
        //SectionHeader,
        headline4: TextStyle(fontFamily: 'Ubuntu', fontSize: 18.sp, fontWeight: FontWeight.w400, color: kDarkDisplayTextColor),
        //Header
        headline5: TextStyle(fontFamily: 'Ubuntu', fontSize: 30.sp, fontWeight: FontWeight.w800, color: kLightDisplayTextColor),
        //Jumbotext
        subtitle1: TextStyle(fontFamily: 'Ubuntu', fontSize: 16.sp, fontWeight: FontWeight.w700, color: kDarkDisplayTextColor),
        // Title bold
        subtitle2: TextStyle(fontFamily: 'Ubuntu', fontSize: 14.sp, fontWeight: FontWeight.w600, color: kDarkDisplayTextColor),
        // Subhead
        bodyText1: TextStyle(
          fontFamily: 'Ubuntu',
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          color: kDarkDisplaySecondaryTextColor,
          decoration: TextDecoration.underline,
        ),
        bodyText2: TextStyle(fontFamily: 'Ubuntu', fontSize: 14.sp, fontWeight: FontWeight.w400, color: kDarkDisplayTextColor),
        overline: TextStyle(
            fontFamily: 'Ubuntu', decoration: TextDecoration.underline, fontSize: 12.sp, fontWeight: FontWeight.w700, color: kDarkDisplayTextColor),
        //Caption title
        caption: TextStyle(fontFamily: 'Ubuntu', fontSize: 12.sp, fontWeight: FontWeight.w700, color: kDarkDisplayTextColor), // Caption bold
      ),

      primaryColor: kDarkDisplayPrimaryBackgroundColor,
      scaffoldBackgroundColor: kDarkDisplayPrimaryBackgroundColor,

      appBarTheme: AppBarTheme(iconTheme: IconThemeData(color: kDarkDisplayPrimaryAction), backgroundColor: kDarkDisplayPrimaryBackgroundColor),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              Color _bgColor = kDarkDisplayPrimaryAction;
              if (states.contains(MaterialState.disabled)) {
                return _bgColor.withOpacity(0.5);
              }
              return _bgColor.withOpacity(1);
            }),
            foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              return kDarkDisplayOnPrimaryAction;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(71),
            ))),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(kDarkDisplayOnSecondaryAction),
            backgroundColor: MaterialStateProperty.all<Color>(kDarkDisplayPrimaryBackgroundColor),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                color: kDarkDisplaySecondaryBackgroundColor,
                style: BorderStyle.solid,
              ),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ))),
      ),

      //TODO:Ali|Greg -> check this divider color in dark theme if its ok or not
      dividerColor: kDarkDisplayTextColor,

      iconTheme: IconThemeData(
        color: kDarkDisplayTextColor,
      ),
      primaryTextTheme: originalTextTheme.apply(
        displayColor: kDarkDisplayTextColor,
        bodyColor: kDarkDisplayTextColor,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kDarkDisplaySecondaryBackgroundColor),
    );
  }
}
