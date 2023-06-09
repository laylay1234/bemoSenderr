import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/constants/images.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class CarousselWidget extends StatelessWidget {
  const CarousselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return Swiper(
      itemCount: authController.carousselLength,
      indicatorLayout: PageIndicatorLayout.COLOR,
      pagination: SwiperPagination(builder: SwiperCustomPagination(builder: (context, config) {
        return ConstrainedBox(
          child: Align(
            alignment: Alignment.bottomCenter,
            child:
                const DotSwiperPaginationBuilder(color: Colors.black12, space: 8, activeColor: kBulletPaginationColor, size: 10.0, activeSize: 20.0)
                    .build(context, config),
          ),
          constraints: BoxConstraints.expand(height: 14.h),
        );
      })),
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              child: Center(
                child: SvgPicture.asset(
                  caroussel_images[index],
                  width: 133.w,
                  height: 140.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Text(
              titleByIndex(index),
              textAlign: TextAlign.center,
              style: Get.textTheme.headline2!.copyWith(color: kLightDisplayPrimaryTextColor, fontSize: 25.sp),
            ),
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 300.w,
              child: Column(
                children: [
                  Text(
                    descriptionByIndex(index),
                    textAlign: TextAlign.center,
                    style: XemoTypography.bodyDefault(context)!.copyWith(fontSize: 20.sp),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  String titleByIndex(int index) {
    switch (index) {
      case 0:
        return "on.board.first.title".tr;
      case 1:
        return "on.board.second.title".tr;
      case 2:
        return "on.board.forth.title".tr;
      default:
        return "on.board.first.title".tr;
    }
  }

  String descriptionByIndex(int index) {
    switch (index) {
      case 0:
        return "on.board.first.desc".tr;
      case 1:
        return "on.board.second.desc".tr;
      case 2:
        return "on.board.forth.desc".tr;
      default:
        return "on.board.first.desc".tr;
    }
  }
}
