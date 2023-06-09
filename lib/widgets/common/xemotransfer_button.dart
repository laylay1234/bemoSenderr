import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class XemoTransferButtonWidget extends StatelessWidget {
  const XemoTransferButtonWidget({
    Key? key,
    this.color,
    this.height,
    this.width,
    this.icon,
    this.isDisabled = false,
    this.radius = 71,
    required this.title,
    required this.onPressed,
  }) : super(key: key);
  final Color? color;
  final double? width;
  final double? height;
  final IconData? icon;
  final String title;
  final bool isDisabled;
  final double radius;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          onPressed: isDisabled ? null : onPressed,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            icon != null
                ? FaIcon(
                    icon,
                    size: 16,
                  )
                : Container(),
            icon != null
                ? const SizedBox(
                    width: 10,
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                title.toUpperCase(),
              ),
            ),
              ],
            ),
          ),
          style: color != null
              ? Theme.of(context).elevatedButtonTheme.style!.copyWith(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      return color!;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                  )))
              : Theme.of(context).elevatedButtonTheme.style!.copyWith(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius),
                  )))),
    );
  }
}
