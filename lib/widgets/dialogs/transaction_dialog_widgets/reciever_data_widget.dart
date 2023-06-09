import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mobileapp/models/ModelProvider.dart';
import 'package:mobileapp/utilities/text_phone_number_formatter.dart';
import 'package:mobileapp/utils/countries_tr_helper.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/models/country_model.dart' as cm;
import 'package:mobileapp/widgets/intl_phone_number_input-0.7.0+2/src/providers/country_provider.dart' as cp;

import '../../../controllers/profile_controller.dart';

// ignore: must_be_immutable
class ReceiverDateWidget extends StatelessWidget {
  GlobalTransaction? transaction;
  ReceiverDateWidget({Key? key, this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    cm.Country? tmp = CountriesTrHelper().getCountryTrDataByIsoCode(transaction!.parameters!.destination_country!.iso_code.toLowerCase());

    final ProfileController profileController = Get.find<ProfileController>();
    return transaction!.status == GlobalTransactionStatus.FUNDTRANSACTION_IN_PROGRESS
        ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/flags/${transaction!.parameters!.destination_country!.iso_code.toLowerCase()}.svg",
                  height: 35.h,
                  width: 35.w,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: Text(
                    tmp == null
                        ? transaction!.parameters!.destination_country!.name.tr.capitalizeFirst!
                        : CountriesTrHelper().getCountryName(tmp)!.capitalizeFirst!,
                    textAlign: TextAlign.center,
                    style: XemoTypography.bodySemiBold(context),
                  ),
                ),
              ],
            ),
          )
        : transaction!.status == GlobalTransactionStatus.REFUNDTRANSACTION_IN_PROGRESS
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "common.to".tr + ' ' + profileController.userInstance!.value.profile!.first_name,
                    overflow: TextOverflow.ellipsis,
                    style: XemoTypography.headLine4FullName(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.5.h),
                    child: Text(
                      "transaction.dialog.from.the.account".tr,
                      // textAlign: TextAlign.center,
                      style: XemoTypography.captionLight(context)!.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Color(0xFF9B9B9B)),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "common.to".tr + ' ' + transaction!.receiver!.first_name + ' ' + transaction!.receiver!.last_name,
                    overflow: TextOverflow.ellipsis,
                    style: XemoTypography.headLine4FullName(context),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.5.h),
                    child: Text(
                      FormatPlainTextPhoneNumberByNumber().format(transaction!.receiver!.phone_number.startsWith('+')
                          ? transaction!.receiver!.phone_number
                          : ('+' + transaction!.receiver!.phone_number)),
                      // textAlign: TextAlign.center,
                      style: XemoTypography.captionLight(context)!.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w400, color: Color(0xFF9B9B9B)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/flags/${transaction!.parameters!.destination_country!.iso_code.toLowerCase()}.svg",
                          height: 35.h,
                          width: 35.w,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text(
                            tmp == null
                                ? transaction!.parameters!.destination_country!.name.tr.capitalizeFirst!
                                : CountriesTrHelper().getCountryName(tmp)!.capitalizeFirst!,
                            textAlign: TextAlign.center,
                            style: XemoTypography.bodySemiBold(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
  }
}
