import 'package:flutter/material.dart';
import 'package:flutter_amplifysdk/utils/log.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controllers/origin_controller.dart';
import '../../../utils/app_utils.dart';

class AboutXemoItemWidget extends StatelessWidget {
  const AboutXemoItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OriginController originController = Get.find<OriginController>();
    ProfileController profileController = Get.find<ProfileController>();
    return GestureDetector(
      onTap: () {
        try {
          Locale? currentLocal = Get.locale;

          String url = AppUtils.getWebsiteUrl(originController.origin_country_iso.toUpperCase(), currentLocal!.languageCode.toLowerCase());
          launch(url);
        } catch (e) {
          dbg(e.toString());
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 5.h, right: 10.w),
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
                'assets/xemo/icon-menu-home-active.svg',
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
                  'settings.item.aboutWebsite'.tr,
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
