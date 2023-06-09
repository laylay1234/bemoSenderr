import 'package:flutter/material.dart';

class XemoTransferAuthButtonWidget extends StatelessWidget {
  const XemoTransferAuthButtonWidget({
    Key? key,
    required this.textBoxHeight,
    required this.textBoxWidth,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final double textBoxHeight;
  final double textBoxWidth;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      // color: kMainColor,
      child: InkWell(
        onTap: () => onTap(),
        child: Container(
          height: textBoxHeight,
          width: textBoxWidth,
          color: Colors.transparent,
          child: Center(
              child: Text(
            text,
          )),
        ),
      ),
    );
  }
}
