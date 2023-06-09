//account.settings.help.support

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/widgets/dialogs/help_support_dialog_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class HelpSupportItemWidget extends StatelessWidget {
  const HelpSupportItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openHelpAndSupportDialog();
      },
      child: Container(
        margin: EdgeInsets.only(top: 15.h, right: 10.w),
        height: 82.h,
        width: 0.95.sw,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5, offset: const Offset(3, 3))]),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 10.w),
              child: SvgPicture.asset(
                'assets/xemo/icon-contact_support-active.svg',
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
                  'settings.item.helpSupport'.tr,
                  textAlign: TextAlign.center,
                  style: XemoTypography.bodySemiBold(context),
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
