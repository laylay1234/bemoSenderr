import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashedLinesWidget extends StatelessWidget {
  const DashedLinesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 0.h, left: 18.w),
      child: Row(
        children: List.generate(
            13,
            (index) => Container(
                  margin: const EdgeInsets.only(left: 10.0),
                  width: (index == 0 || index == 15) ? 0.01.sw : 0.038.sw,
                  height: 2,
                  color: const Color(0xFF9B9B9B).withOpacity(0.5),
                )),
      ),
    );
  }
}
