import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp/theme.dart';
import 'package:mobileapp/widgets/common/all_widgets.dart';
import 'package:mobileapp/xemo_typo_graphy.dart';

class XemoTransferOutlinedButtonWidget extends StatelessWidget {
  const XemoTransferOutlinedButtonWidget({
    Key? key,
    this.color,
    this.borderColor,
    required this.title,
    this.isChip = false,
    this.icon,
    this.isDisabled = false,
    this.width,
    this.height,
    this.isSelected,
    this.foregroundColor,
    this.isHighLight = false,
    this.textAlign = TextAlign.center,
    required this.onPressed,
  }) : super(key: key);

  final Color? color;
  final MaterialStateProperty<Color?>? foregroundColor;
  final bool isChip;

  /// border color will be same as color if the borderColor is not specified
  final Color? borderColor;
  final String? title;
  final dynamic icon; // icon should be either string or FaIcon
  final bool isDisabled;
  final double? height;
  final double? width;
  final bool? isSelected;
  final VoidCallback onPressed;
  final bool isHighLight;
  final TextAlign textAlign;

  Color getBorderColor(BuildContext context) {
    IconThemeData? _iconThemeData = Theme.of(context).appBarTheme.iconTheme;
    Color _borderColor = Theme.of(context).primaryColor;
    if (borderColor != null) {
      _borderColor = this.borderColor as Color;
    } else if (color != null) {
      _borderColor = this.color as Color;
    } else if (_iconThemeData != null) {
      if (_iconThemeData.color != null) {
        _borderColor = _iconThemeData.color as Color;
      }
    }
    return _borderColor;
  }

  @override
  Widget build(BuildContext context) {
    final double textHorizontalPadding = XemoTransferTheme.widthScalingPercent(25);
    final double textVerticalPadding = XemoTransferTheme.heightScalingPercent(13);
    final double chipButtonHeight = XemoTransferTheme.heightScalingPercent(30);
    return SizedBox(
      height: isChip ? chipButtonHeight : height,
      width: width,
      child: Opacity(
          opacity: this.isDisabled ? 0.3 : 1.0,
          child: OutlinedButton(
            onPressed: this.isDisabled ? null : this.onPressed,
            child: Container(
              child: icon != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon is IconData
                            ? SetIconWidget(
                                icon: icon,
                                size: 18,
                              )
                            : SetIconWidget(
                                iconUrl: icon,
                                size: 16,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Text(
                            title!,
                            style: XemoTypography.buttonAllCapsWhite(context),
                            maxLines: 5,
                          ),
                        ),
                      ],
                    )
                  : isChip
                      ? Text(
                          title!,
                          style: isHighLight ? XemoTypography.buttonAllCapsWhite(context) : XemoTypography.buttonAllCapsWhite(context),
                        )
                      : Container(
                          width: double.infinity,
                          child: Text(
                            title!,
                            textAlign: this.textAlign,
                            //Ali: im not sure about this part because this isSelected needs to be implemented seperetly like isChip or be as it is
                            style: isSelected == true ? XemoTypography.bodySemiBoldHighlight(context) : XemoTypography.buttonAllCapsWhite(context),
                          ),
                        ),
            ),
            style: Theme.of(context).outlinedButtonTheme.style!.copyWith(
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                      color: this.getBorderColor(context),
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
          )),
    );
  }
}

class SetIconWidget extends StatelessWidget {
  const SetIconWidget({Key? key, this.icon, required this.size, this.iconUrl}) : super(key: key);

  final double? size;

  final IconData? icon;
  final String? iconUrl;

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? FaIcon(
            icon,
            size: size,
          )
        : SvgPicture.asset(
            iconUrl!,
            width: size,
            height: size,
          );
  }
}
