import 'package:flutter/material.dart';

class XemoTransferLinearProgress extends StatelessWidget {
  const XemoTransferLinearProgress({Key? key, this.width}) : super(key: key);

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 180,
      child: LinearProgressIndicator(
        color: Theme.of(context).appBarTheme.iconTheme!.color,
        backgroundColor: Color(0xFFB4DED6),
      ),
    );
  }
}
