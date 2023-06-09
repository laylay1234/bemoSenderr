import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/views/connect_flinks_web_view.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

// ignore: must_be_immutable
class ReviewInProgressFlinksHomeButton extends StatelessWidget {
  ReviewInProgressFlinksHomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: GestureDetector(
        onTap: () {},
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
                  'assets/xemo/loading_kyc.svg',
                  height: 30.h,
                  width: 30.w,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 18.w, right: 0.w, bottom: 3.0),
                  child: Text(
                    'userTier.widget.review.in.progress'.tr,
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
