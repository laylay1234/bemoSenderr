import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/views/auth/auth_register_address_view.dart';
import 'package:mobileapp/widgets/buttons/next_button_widget.dart';
import 'package:mobileapp/widgets/common/xemo_form_validator.dart';
import 'package:mobileapp/widgets/common/xemo_text_form_field_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class EmailPasswordFormWidget extends StatelessWidget {
  const EmailPasswordFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return Obx(() {
      return Form(
        key: authController.formKeys[3],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //email
            XemoTextFormWithTitleAndNote(
              width: 1.sw,
              enableRightMargin: false,
              controller: authController.emailRxController,
              formKey: authController.formKeys[3],
              textFieldKey: authController.emailKey,
              enableNext: authController.enableEmailPassNext,
              title: "common.email.title".tr,
              note: "common.note.required".tr,
              validator: XemoFormValidatorWidget().emailValidator,
            ),
            //CONFIRM YOUR EMAIL
            XemoTextFormWithTitleAndNote(
              width: 1.sw,
              enableRightMargin: false,
              controller: authController.confirmEmailController,
              formKey: authController.formKeys[3],
              textFieldKey: authController.confirmEmailKey,
              enableNext: authController.enableEmailPassNext,
              title: "auth.signup.email.confirm".tr,
              note: "common.note.required".tr,
              validator: XemoFormValidatorWidget().confirmEmailValidator,
            ),
            //PASSWORD
         
            Container(
              margin: EdgeInsets.only(top: 50.h),
              child: Row(
                children: [
                  Checkbox(
                      value: authController.isSubscribedToNewsLetter.value,
                      checkColor: Colors.white,
                      focusColor: Colors.white,
                      activeColor: Get.theme.primaryColorLight,
                      onChanged: (val) {
                        authController.isSubscribedToNewsLetter.value = val!;
                      }),
                  Expanded(child: Text("auth.signup.newsletter".tr, style: XemoTypography.bodyDefault(context))),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 8.h, bottom: 18.h),
              child: NextButtonWidget(
                width: 1.sw,
                nextScreenId: AuthRegisterAddressView.id,
                enabled: authController.enableEmailPassNext.value,
              ),
            )
          ],
        ),
      );
    });
  }
}
