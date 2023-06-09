import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/views/connect_flinks_web_view.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

// ignore: must_be_immutable
class JustConnectWithFlinksHomeButton extends StatelessWidget {
  bool? enable;
  bool? fromRegister;
  JustConnectWithFlinksHomeButton({@required this.enable, @required this.fromRegister, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enable! ? 1 : 0.5,
      child: GestureDetector(
        onTap: () {
          if (enable!) {
            //
            Get.toNamed(ConnectWithFlinksWebView.id, arguments: {'fromRegister': fromRegister});
          } else {
            //
          }
        },
        child: Container(
          width: 255.w,
          constraints: BoxConstraints(minHeight: 35.h, maxHeight: 60.h),
          padding: EdgeInsets.only(left: 8.0, top: 5.0, right: 3.w),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black.withOpacity(0.5), offset: const Offset(0, 3))]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: SvgPicture.asset(
                  'assets/xemo/flinks_icon.svg',
                  height: 30.h,
                  width: 30.w,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 0.w, bottom: 3.0),
                  child: Text(
                    'auth.connect.with.flinks'.tr,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: XemoTypography.captionSemiBold(context),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
