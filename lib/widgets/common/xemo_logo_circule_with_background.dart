import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XemoLogoCirculeWhiteBackground extends StatelessWidget {
  const XemoLogoCirculeWhiteBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21.0),
      height: 117.h,
      width: 117.w,
      decoration:
          BoxDecoration(boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 5)], shape: BoxShape.circle, color: Colors.white),
      child: SvgPicture.asset(
        "assets/xemo/logo-yallaxash_small_3x.svg",
        height: 70.h,
        width: 70.w,
      ),
    );
  }
}
