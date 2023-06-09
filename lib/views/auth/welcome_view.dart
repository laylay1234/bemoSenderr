import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/controllers/auth_controller.dart';
import 'package:mobileapp/helpers/analytics_service.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/widgets/common/sb_linear_progress.dart';
import 'package:mobileapp/widgets/xemo_app_bar_widget.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();
    AnalyticsService().analytics.setCurrentScreen(screenName: id);
    AnalyticsService().analytics.logScreenView(screenClass: id, screenName: id);

    return Scaffold(
      appBar: XemoAppBar(leading: false),
      body: Container(
        margin: EdgeInsets.only(top: XemoTransferTheme.heightScalingPercent(107.67), left: XemoTransferTheme.widthScalingPercent(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Text(
                authController.userFirstName.value.isNotEmpty
                    ? 'auth.welcome'.trParams({
                        'firstName': authController.userFirstName.value,
                      })
                    : 'auth.welcome'.trParams({
                        'firstName': '',
                      }).substring(
                        0,
                        'auth.welcome'.trParams({
                              'firstName': '',
                            }).length -
                            1),
                style: XemoTypography.titleH6BoldBlack(context)!.copyWith(fontSize: 48.sp, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: XemoTransferTheme.heightScalingPercent(42),
            ),
            const XemoTransferLinearProgress(),
          ],
        ),
      ),
    );
  }
}
