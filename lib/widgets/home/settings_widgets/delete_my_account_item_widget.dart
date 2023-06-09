import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/constants/colors.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/views/auth/auth_landing_view.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

import '../../common/rotated_spinner.dart';
import '../../dialogs/delete_account_confirmation_dialog_widget.dart';

class DeleteMyAccountItemWidget extends StatelessWidget {
  const DeleteMyAccountItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return GestureDetector(
      onTap: () async {
        //TODO TEST IT

        try {
          openDeleteAccountConfirmationDialog();
        } catch (e) {
          if (Get.isOverlaysOpen) {
            Get.back();
          }
        }
        //
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.h, right: 10.w, bottom: 15.h),
        height: 82.h,
        width: 0.95.sw,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: kLightComplementryAction,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(3, 3))]),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 18.w),
              child: SvgPicture.asset(
                'assets/xemo/delete.svg',
                height: 36.h,
                width: 36.w,
              ),
            ),
            Container(
              width: 20.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30.h,
                ),
                Text(
                  'settings.item.delete.my.account'.tr,
                  textAlign: TextAlign.center,
                  style: XemoTypography.bodySemiBold(context)!.copyWith(color: Colors.white),
                ),
                Container(
                  height: 5.h,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
