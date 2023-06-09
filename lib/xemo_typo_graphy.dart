import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';

class XemoTypography {
  static TextStyle? headLine1Black(BuildContext context) {
    return Get.theme.textTheme.headline1!
        .copyWith(decoration: TextDecoration.none, fontWeight: FontWeight.w700, fontSize: 32.sp, color: kLightDisplayPrimaryTextColor);
  }

  static TextStyle? headLine5Black(BuildContext context) {
    return Get.theme.textTheme.headline5!.copyWith(fontWeight: FontWeight.w400, fontSize: 20.sp, color: kLightDisplayPrimaryTextColor);
  }

  static TextStyle? headLine6Black(BuildContext context) {
    return Get.theme.textTheme.headline5!.copyWith(fontWeight: FontWeight.w700, fontSize: 16.sp, color: kLightDisplayComplementryTextColor);
  }

  static TextStyle? headLine6Light(BuildContext context) {
    return Get.theme.textTheme.headline5!.copyWith(fontWeight: FontWeight.w300, fontSize: 14.sp, color: kLightDisplayComplementryTextColor);
  }

  static TextStyle? headLine4FullName(BuildContext context) {
    return Get.theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.w500, fontSize: 24.sp, color: kLightDisplayPrimaryTextColor);
  }

  static TextStyle? headLine5Total(BuildContext context) {
    return Get.theme.textTheme.headline5!.copyWith(fontWeight: FontWeight.w400, fontSize: 20.sp, color: kLightDisplaySecondaryTextColor);
  }

  static TextStyle? headLine5Bold(BuildContext context) {
    return Get.theme.textTheme.headline5!.copyWith(fontWeight: FontWeight.w700, fontSize: 20.sp, color: kLightDisplayHighlightText);
  }

  static TextStyle? headLine5BoldWhite(BuildContext context) {
    return Get.theme.textTheme.headline5!.copyWith(fontWeight: FontWeight.w700, fontSize: 20.sp, color: kLightDisplayOnPrimaryAction);
  }

  static TextStyle? titleH6BoldBlack(BuildContext context) {
    return Get.theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.w700, fontSize: 18.sp, color: kLightDisplayComplementryTextColor);
  }

  static TextStyle? bodyAllCapsBlack(BuildContext context) {
    return Get.theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp, color: kLightDisplayPrimaryTextColor);
  }

 static TextStyle? bodyAllCapsLight(BuildContext context) {
    return Get.theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w300, fontSize: 16.sp, color: kLightDisplayPrimaryTextColor);
  }
  static TextStyle? bodyAllCapsSecondary(BuildContext context) {
    return Get.theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp, color: kLightDisplaySecondaryTextColor);
  }

  static TextStyle? bodySmallSemiBald(BuildContext context) {
    return Get.theme.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp, color: kLightDisplayOnPrimaryAction);
  }

  static TextStyle? bodyBold(BuildContext context) {
    return Get.theme.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w700, fontSize: 16.sp, color: kLightDisplaySecondaryTextColor);
  }

  static TextStyle? bodyBoldSelected(BuildContext context) {
    return Get.theme.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp, color: kLightDisplayPrimaryAction);
  }

  static TextStyle? bodySemiBold(BuildContext context) {
    return Get.theme.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp, color: kLightDisplayComplementryTextColor);
  }

  static TextStyle? bodySemiBoldHighlight(BuildContext context) {
    return Get.theme.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp, color: kLightDisplayHighlightText);
  }

  static TextStyle? bodySemiBoldComplementry(BuildContext context) {
    return Get.theme.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp, color: kLightDisplayComplementryTextColor);
  }

  static TextStyle? bodySemiBoldSelected(BuildContext context) {
    return Get.theme.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp, color: kLightDisplaySecondaryAction);
  }

  static TextStyle? bodyDefault(BuildContext context) {
    return Get.theme.textTheme.bodyText1!
        .copyWith(decoration: TextDecoration.none, fontWeight: FontWeight.w400, fontSize: 16.sp, color: kLightDisplayPrimaryTextColor);
  }

  static TextStyle? buttonWhiteDefault(BuildContext context) {
    return Get.theme.textTheme.bodyText1!
        .copyWith(decoration: TextDecoration.none, fontWeight: FontWeight.w700, fontSize: 15.sp, color: kLightDisplayOnPrimaryAction);
  }

  static TextStyle? buttonAllCapsWhite(BuildContext context) {
    return Get.theme.textTheme.button!.copyWith(fontWeight: FontWeight.w700, fontSize: 16.sp, color: kLightDisplayOnPrimaryAction);
  }

  static TextStyle? captionItalic(BuildContext context) {
    return Get.theme.textTheme.caption!
        .copyWith(fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, fontSize: 14.sp, color: kLightDisplayErrorText);
  }

  static TextStyle? captionLight(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(fontWeight: FontWeight.w300, fontSize: 12.sp, color: kLightDisplayPrimaryTextColor);
  }

  static TextStyle? captionLightSelected(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(fontWeight: FontWeight.w300, fontSize: 12.sp, color: kLightDisplaySecondaryAction);
  }

  static TextStyle? captionDefault(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(fontWeight: FontWeight.w400, fontSize: 12.sp, color: kLightDisplayComplementryTextColor);
  }

  static TextStyle? captionLightAllCaps(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(fontWeight: FontWeight.w300, fontSize: 10.sp, color: kLightDisplayComplementryTextColor);
  }

  static TextStyle? captionBold(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(fontWeight: FontWeight.w700, fontSize: 12.sp, color: kLightDisplayPrimaryTextColor);
  }

  static TextStyle? captionSemiBold(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp, color: kLightDisplayOnSecondaryActionAlt);
  }

  static TextStyle? captionSemiBoldSecondary(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp, color: kLightDisplaySecondaryTextColor);
  }

  static TextStyle? captionSemiBoldPrimary(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(fontWeight: FontWeight.w500, fontSize: 12.sp, color: kLightDisplayPrimaryAction);
  }

  static TextStyle? captionDefaultSelected(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(fontWeight: FontWeight.w400, fontSize: 12.sp, color: kLightDisplayOnPrimaryAction);
  }

  static TextStyle? captionDefaultHighlightSelected(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(fontWeight: FontWeight.w400, fontSize: 12.sp, color: kLightDisplayHighlightText);
  }

  static TextStyle? bodySmall(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(
        fontWeight: FontWeight.w400, fontSize: 14.sp, color: Get.isDarkMode ? kLightDisplayPrimaryTextColor : kLightDisplayPrimaryTextColor);
  }

  static TextStyle? bodySmallSemiBold(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(
        fontWeight: FontWeight.w500, fontSize: 14.sp, color: Get.isDarkMode ? kLightDisplayPrimaryTextColor : kLightDisplayPrimaryTextColor);
  }

  static TextStyle? bodySmallSecondary(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(
        fontWeight: FontWeight.w400, fontSize: 14.sp, color: Get.isDarkMode ? kLightDisplaySecondaryTextColor : kLightDisplaySecondaryTextColor);
  }

  static TextStyle? buttonUnderlined(BuildContext context) {
    return Get.theme.textTheme.caption!.copyWith(
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w700,
        fontSize: 16.sp,
        color: Get.isDarkMode ? kLightDisplaySecondaryTextColor : kLightDisplaySecondaryTextColor);
  }
}
