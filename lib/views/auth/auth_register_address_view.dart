import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/origin_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/widgets/common/same_information_like_id_widget.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/widgets/forms/address_form_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'package:screen_size_test/screen_size_test.dart';

class AuthRegisterAddressView extends StatelessWidget {
  static const String id = '/register-address';

  const AuthRegisterAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OriginController originController = Get.find<OriginController>();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    //Get.updateLocale(Locale('fr', 'CA'));
    //log(originController.origin_country_iso.value);
    return Scaffold(
      appBar: XemoAppBar(leading: true),
      body: Container(
        child: SingleChildScrollView(
          child: Obx(() {
            return Container(
              margin: EdgeInsets.only(right: 0.06.sw, left: 0.05.sw, top: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SameInformationIDWidget(),
                  Container(
                    margin: EdgeInsets.only(top: 20.h),
                    child: Text(
                      "common.auth.register.title".tr,
                      style: XemoTypography.headLine1Black(context),
                    ),
                  ),
                  Container(
                    height: 20.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 2.0),
                    child: Row(
                      children: [
                        //country svg
                        ClipOval(
                          child: SvgPicture.asset(
                            "assets/flags/${originController.origin_country_iso.value.toLowerCase()}.svg",
                            height: 25.h,
                            width: 25.w,
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        Text(
                          "auth.signup.address.title".tr +
                              (originController.origin_country_name.value.contains('united') ? 'USA' : originController.origin_country_name.value),
                          style: XemoTypography.bodySemiBold(context),
                        )
                      ],
                    ),
                  ),
                  const AddressFormWidget()
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
