import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/input_borders.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/widgets/common/xemo_clear_textFormField_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class XemoTextFormWithTitleAndNote extends StatefulWidget {
  double? width;
  EdgeInsetsGeometry? margin = EdgeInsets.only(top: 25.h);
  Rx<GlobalKey<FormFieldState<dynamic>>>? textFieldKey;
  GlobalKey<FormState>? formKey;
  Rx<TextEditingController>? controller;
  String? title;
  String? note;
  Rx<bool>? enableNext;
  String? Function(String?)? validator;
  bool obscure = false;
  bool isConfirmPasswordField = false;
  bool enableRightMargin = true;
  bool enableNote = true;
  bool optional = false;
  List<TextInputFormatter>? inputFormatters;
  TextInputType textInputType = TextInputType.text;
  TextInputType? keyboardType;
  XemoTextFormWithTitleAndNote(
      {Key? key,
      @required this.textFieldKey,
      @required this.controller,
      @required this.formKey,
      this.margin = const EdgeInsets.only(top: 25),
      this.enableNext,
      this.title,
      this.note,
      this.validator,
      this.obscure = false,
      showOrHide = false,
      this.isConfirmPasswordField = false,
      this.enableRightMargin = true,
      this.width = 325,
      this.inputFormatters,
      this.enableNote = true,
      this.textInputType = TextInputType.text,
      this.optional = false,
      this.keyboardType})
      : super(key: key);

  @override
  State<XemoTextFormWithTitleAndNote> createState() => _XemoTextFormWithTitleAndNoteState();
}

class _XemoTextFormWithTitleAndNoteState extends State<XemoTextFormWithTitleAndNote> {
  bool showOrHide = false;

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    FormState? form = Form.of(context);
    //  textFieldKey!.update((val) {});

    return Obx(() {
      return Container(
        margin: widget.margin,
        //  width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                widget.title!.toUpperCase(),
                style: XemoTypography.bodyAllCapsBlack(context)!.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            widget.enableNote
                ? Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Text(widget.note!,
                        style: widget.textFieldKey!.value.currentState == null
                            ? widget.validator == null
                                ? XemoTypography.captionItalic(context)!.copyWith(fontWeight: FontWeight.w200)
                                : widget.validator!(widget.controller!.value.text) == null
                                    ? XemoTypography.captionItalic(context)!.copyWith(
                                        fontWeight: FontWeight.w200,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 14,
                                        color: kLightDisplaySecondaryTextColor,
                                      )
                                    : XemoTypography.captionItalic(context)!.copyWith(fontWeight: FontWeight.w200)
                            : !((widget.textFieldKey!.value.currentState!.validate()))
                                ? widget.optional
                                    ? widget.controller!.value.text.isNotEmpty
                                        ? widget.textFieldKey!.value.currentState != null
                                            ? widget.textFieldKey!.value.currentState!.validate()
                                                ? XemoTypography.captionItalic(context)!.copyWith(
                                                    fontWeight: FontWeight.w200,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 14,
                                                    color: kLightDisplaySecondaryTextColor,
                                                  )
                                                : XemoTypography.captionItalic(context)!.copyWith(fontWeight: FontWeight.w200)
                                            : XemoTypography.captionItalic(context)!.copyWith(fontWeight: FontWeight.w200)
                                        : XemoTypography.captionItalic(context)!.copyWith(
                                            fontWeight: FontWeight.w200,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            color: kLightDisplaySecondaryTextColor,
                                          )
                                    : XemoTypography.captionItalic(context)!.copyWith(fontWeight: FontWeight.w200)
                                : widget.optional
                                    ? widget.controller!.value.text.isNotEmpty
                                        ? widget.textFieldKey!.value.currentState!.validate()
                                            ? XemoTypography.captionItalic(context)!.copyWith(
                                                fontWeight: FontWeight.w200,
                                                fontStyle: FontStyle.italic,
                                                fontSize: 14,
                                                color: kLightDisplaySecondaryTextColor,
                                              )
                                            : XemoTypography.captionItalic(context)
                                        : XemoTypography.captionItalic(context)!.copyWith(
                                            fontWeight: FontWeight.w200,
                                            fontStyle: FontStyle.italic,
                                            fontSize: 14,
                                            color: kLightDisplaySecondaryTextColor,
                                          )
                                    : XemoTypography.captionItalic(context)!.copyWith(
                                        fontWeight: FontWeight.w200,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 14,
                                        color: kLightDisplaySecondaryTextColor,
                                      )),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.only(right: widget.enableRightMargin ? 8.w : 0),
              padding: const EdgeInsets.only(left: 2),
              height: 75.h,
              width: widget.width,
              child: TextFormField(
                inputFormatters: widget.inputFormatters,
                key: widget.textFieldKey!.value,
                keyboardType: widget.keyboardType,
                controller: widget.controller!.value,
                validator: widget.controller!.value.text.isEmpty
                    ? widget.optional
                        ? null
                        : widget.validator
                    : widget.validator,
                obscureText: (widget.obscure ? !(showOrHide) : false),
                style: XemoTypography.bodyBold(context)!
                    .copyWith(decoration: TextDecoration.none, decorationThickness: 0, color: kLightDisplayPrimaryAction),
                onChanged: (val) {
                  //log(widget.controller!.value.text);
                  if (widget.optional && val.isNotEmpty) {
                    if (form!.validate()) {
                      widget.enableNext!.value = true;
                    } else {
                      widget.enableNext!.value = false;
                    }

                    widget.textFieldKey!.update((val) {});
                    widget.controller!.update((val) {});
                  } else if (widget.optional && val.isEmpty) {
//do nothing
                    widget.enableNext!.value = true;
                    widget.controller!.update((val) {});
                    widget.textFieldKey!.update((val) {});
                  } else {
                    if (form!.validate()) {
                      widget.enableNext!.value = true;
                    } else {
                      widget.enableNext!.value = false;
                    }

                    widget.textFieldKey!.update((val) {});
                    widget.enableNext!.update((val) {});
                    widget.controller!.update((val) {});
                  }
                },
                decoration: InputDecoration(
                  suffix: widget.obscure
                      ? GestureDetector(
                          onTap: () {
                            //  showOrHide.value = !showOrHide.value;
                            setState(() {
                              showOrHide = !showOrHide;
                            });

                            // showOrHide.update((val) {});
                          },
                          child: !showOrHide
                              ? Text(
                                  "common.hint.show".tr.toUpperCase(),
                                  style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent),
                                )
                              : Text(
                                  "common.hint.hide".tr.toUpperCase(),
                                  style: TextStyle(color: Colors.grey, backgroundColor: Colors.transparent),
                                ),
                        )
                      : ClearTextFormFieldWidget(
                          controller: widget.controller,
                          enabelNext: widget.enableNext!,
                          textFieldKey: widget.textFieldKey!,
                        ),

                  //instead of icon country for which the app is targeting
                  prefixStyle: Get.textTheme.headline2!.copyWith(color: Get.theme.primaryColorLight, fontSize: 16, fontWeight: FontWeight.w500),
                  contentPadding: EdgeInsets.only(left: 3.w, top: 8.0),

                  fillColor: Colors.transparent,
                  filled: true,

                  focusedErrorBorder: errorBorderDecoration,
                  errorBorder: errorBorderDecoration,
                  enabledBorder: borderDecoration,
                  border: borderDecoration,
                  disabledBorder: borderDecoration,
                  focusedBorder: primayColorborderDecoration,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
