import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/profile_controller.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class KycBankVerificationStatusDescWidget extends StatelessWidget {
  const KycBankVerificationStatusDescWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final ProfileController profileController = Get.find<ProfileController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "userTier.widget.connect.with.get.more.1".tr,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.start,
          style: XemoTypography.headLine6Black(context),
        ),
        Text(
          profileController.userInstance!.value.kyc_level == 0
              ? "userTier.widget.connect.transfer.up.to.1".tr
              : profileController.userInstance!.value.kyc_level == 1
                  ? "userTier.widget.connect.transfer.up.to.2".tr
                  : "userTier.widget.connect.transfer.up.to.2".tr,
          textAlign: TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: XemoTypography.headLine6Light(context),
        ),
      ],
    );
  }
}
