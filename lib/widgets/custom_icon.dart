import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../color_constatnt.dart';
import '../helper_function/my_text_style.dart';


class CustomIcon extends StatelessWidget {
  final String? svgPath;
  final String text;
  final Widget? svg;
  const CustomIcon({
    super.key,
    this.svgPath,
    required this.text,
    this.svg,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          child: svgPath != null
              ? SvgPicture.asset(
                  svgPath!,
                  width: 22,
                  height: 22,
                  colorFilter: const ColorFilter.mode(
                    appPrimary,
                    BlendMode.srcIn,
                  ),
                )
              : svg ?? const SizedBox.shrink(),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: MyTextStyle.medium.copyWith(
              color: black,
              fontSize: 15,
            ),
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
