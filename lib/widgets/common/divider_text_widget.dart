import 'package:flutter/material.dart';

class DividerTextWidget extends StatelessWidget {
  final double? height;
  final Color? color;
  final Text? text;
  final double? thickness;

  const DividerTextWidget({
    Key? key,
    this.height,
    this.color,
    this.text,
    this.thickness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Container(
          margin: text == null ? null : const EdgeInsets.only(left: 10.0, right: 15.0),
          child: Divider(
            thickness: thickness,
            color: color ?? Theme.of(context).textTheme.bodyText2?.color,
            height: height ?? 10,
          ),
        ),
      ),
      // BUG: The element type 'Widget?' can't be assigned to the list type 'Widget'.
      //      Fixed by casting as `dynamic`
      text ?? (const SizedBox.shrink()) as dynamic,
      Expanded(
        child: Container(
          margin: text == null ? null : const EdgeInsets.only(left: 15.0, right: 10.0),
          child: Divider(
            thickness: thickness,
            color: color ?? Theme.of(context).textTheme.bodyText2?.color,
            height: height ?? 10,
          ),
        ),
      ),
    ]);
  }
}
