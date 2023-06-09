import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

enum SpinnerColor {
  GREEN,
  WHITE,
  BLACK,
}

class RotatedSpinner extends StatefulWidget {
  SpinnerColor? spinnerColor;
  double height = 25;
  double width = 25;
  RotatedSpinner({Key? key, this.spinnerColor, this.height = 25, this.width = 25}) : super(key: key);

  @override
  State<RotatedSpinner> createState() => _RotatedSpinnerState();
}

class _RotatedSpinnerState extends State<RotatedSpinner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.repeat(min: 0, max: 1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: SvgPicture.asset(
            svgUrl(widget.spinnerColor!),
            height: widget.height,
            width: widget.width,
          ),
        );
      },
      animation: _controller,
    );
  }

  String svgUrl(SpinnerColor spinnerColor) {
    switch (spinnerColor) {
      case SpinnerColor.BLACK:
        return 'assets/xemo/BlackSpinner.svg';
      case SpinnerColor.WHITE:
        return 'assets/xemo/WhiteSpinner.svg';
      case SpinnerColor.GREEN:
        return 'assets/xemo/GreenSpinner.svg';
    }
  }
}
