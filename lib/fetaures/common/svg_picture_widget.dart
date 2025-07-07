import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgPictureWidget extends StatelessWidget {
  const SvgPictureWidget({
    super.key,
    required this.svg,
    this.width = 19,
    this.height = 20,
    required this.callback,
    this.color = Colors.black,
  });

  final String svg;
  final double width, height;
  final VoidCallback callback;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: SvgPicture.asset(
        svg,
        fit: BoxFit.cover,
        width: width.w,
        height: height.h,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
