import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/contacts_controller.dart';

// ignore: must_be_immutable
class ClearTextFormFieldWidget extends StatelessWidget {
  Rx<TextEditingController>? controller;
  Rx<GlobalKey<FormFieldState<dynamic>>>? textFieldKey;
  Rx<bool>? enabelNext;
  ClearTextFormFieldWidget({Key? key, this.controller, @required this.textFieldKey, @required this.enabelNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContactsController contactsController = Get.find<ContactsController>();

    return Obx(() => controller!.value.text.isNotEmpty
        ? Container(
            alignment: Alignment.center,
            height: 25,
            width: 25,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFC4C4C4)),
            child: GestureDetector(
              onTap: () {
                controller!.value.clear();
                if (textFieldKey != null) {
                  if (textFieldKey!.value.currentState != null) {
                    if (enabelNext != null) {
                      if (textFieldKey!.value.currentState!.validate()) {
                        enabelNext!.value = true;
                      } else {
                        enabelNext!.value = false;
                      }
                    }
                  }
                }
              },
              child: const Center(
                child: Icon(
                  Icons.close,
                  color: Color(0xFF9B9B9B),
                ),
              ),
            ),
          )
        : Container(
            alignment: Alignment.center,
            height: 25,
            width: 25,
          ));
  }
}

Widget ClearTextWidget(TextEditingController controller) {
  return controller.text.isNotEmpty
      ? Container(
          alignment: Alignment.center,
          height: 25,
          width: 25,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFFC4C4C4)),
          child: GestureDetector(
            onTap: () {
              controller.clear();
            },
            child: const Center(
              child: Icon(
                Icons.close,
                color: Color(0xFF9B9B9B),
              ),
            ),
          ),
        )
      : Container();
}
