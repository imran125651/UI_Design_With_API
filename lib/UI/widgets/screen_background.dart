import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';
import '../utils/AssetsPath.dart';

class ScreenBackground extends StatelessWidget {
  const ScreenBackground({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(
          AssetsPath.backgroundSvg,
          width: screenSize.width,
          height: screenSize.height,
          fit: BoxFit.cover,
        ),

        SafeArea(child: child),
      ],
    );
  }
}
