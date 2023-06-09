import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/profile_controller.dart';

// ignore: must_be_immutable
class SearchContactSuffixWidget extends StatelessWidget {
  Rx<TextEditingController>? controller;
  SearchContactSuffixWidget({Key? key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find<ProfileController>();

    return Obx(() {
      return Container(
        width: 30,
        padding: EdgeInsets.only(bottom: 6.h),
        alignment: Alignment.center,
        child: profileController.searchController.value.text.isEmpty
            ? Align(
                alignment: Alignment.bottomCenter,
                //padding: EdgeInsets.only(top: 5),
                child: GestureDetector(
                    onTap: () {
                      profileController.enableSearch.value = false;
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 25,
                    )),
              )
            : Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                    onTap: () {
                      profileController.enableSearch.value = false;
                    },
                    child: Container(
                        alignment: Alignment.bottomCenter,
                        child: const Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 25,
                        ))),
              ),
      );
    });
  }
}
