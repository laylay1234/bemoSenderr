import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/errors.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class CommonWidgets {
  static PreferredSizeWidget appbar({
    required BuildContext context,
    String text = "",
    double fontSize = 20,
    double height = 100.0,
    Widget? child,
    bool centerTile = false,
    Function? afterNavigatingBack,
  }) {
    /*
    The layout design has been changed where I have to add more functionality.
    If I refactor text with a normal widget, I have to make a lot of changes.
    So what I did here is add child widget param. If the param is null,
    then it will use text.
     */
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        elevation: 0,
        centerTitle: centerTile,
        title: Padding(padding: const EdgeInsets.only(top: 20), child: child ?? Container()),
        leading: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              // color: Colors.white,
            ),
            onPressed: () {
              Get.back(closeOverlays: Get.isOverlaysOpen);
              if (afterNavigatingBack != null) {
                afterNavigatingBack();
              }
            },
          ),
        ),
      ),
    );
  }

  static Widget blindDivider(BuildContext context) {
    return Divider(
      color: Theme.of(context).dividerColor,
      thickness: 1,
      height: 1,
    );
  }

  static Widget blindVerticalDivider(BuildContext context) {
    return VerticalDivider(
      color: Theme.of(context).dividerColor,
      thickness: 1,
      width: 1,
    );
  }

  //never used
  static TextStyle drawerTextStyle() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
  }

  //never used
  static Widget? _buildDialogueWithErrorCode({String? code, required String message, BuildContext? context}) {
    Widget? _messageText = code != null
        ? RichText(
            text: TextSpan(
              text: message,
              style: XemoTypography.bodyBold(context!),
              children: [
                TextSpan(
                  text: '($code)',
                  style: XemoTypography.bodyAllCapsBlack(context),
                ),
              ],
            ),
          )
        : null;
    return _messageText;
  }

  static void buildErrorDialogue(
      {String? code, required String message, SnackPosition snackPosition = SnackPosition.TOP, String? title, BuildContext? context}) {
    showErrorSnackbar(
      messageText: _buildDialogueWithErrorCode(code: code, message: message,context: context),
      message: message,
      snackPosition: snackPosition,
      title: title ?? "common.error.title".tr,
      
    );
  }

  static void buildErrorSnackBar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: kRedColor,
        content: Text(error),
      ),
    );
  }

  static void showErrorSnackbar({
    Widget? messageText,
    String? message,
    SnackPosition? snackPosition,
    String? title,
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(
      '',
      '',
      snackPosition: snackPosition!,
      titleText: Text(
        title!,
        style: XemoTypography.bodySmallSemiBald(Get.context!)!.copyWith(color: kLightDisplayErrorText),
      ),
      padding: EdgeInsets.only(left: 40.w, right: 10.w, top: 20.h, bottom: 20.h),
      messageText: Text(
        message!,
        style: XemoTypography.captionSemiBold(Get.context!)!.copyWith(color: kLightDisplaySecondaryTextColor),
      ),
      icon: Container(
        decoration:
            BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 5)], shape: BoxShape.circle, color: Colors.white),
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          'assets/xemo/yxLogo-small.svg',
          height: 30,
          width: 30,
        ),
      ),
      backgroundColor: kLightDisplayToolTipBackgroundColor,
    );
  }
}
