import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LeadingBtn extends StatelessWidget {
  const LeadingBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 15,
        height: 15,
        padding: const EdgeInsets.all(17),
        constraints: const BoxConstraints(
          maxHeight: 15,
          maxWidth: 15,
        ),
        child: SvgPicture.asset(
          "assets/icons/back.svg",
          width: 15,
          height: 15,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
