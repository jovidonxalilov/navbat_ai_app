import 'package:flutter/material.dart';
import 'package:navbat_ai_app/fetaures/common/svg_picture_widget.dart';
import 'package:navbat_ai_app/fetaures/common/text_widget.dart';
import '../../core/utils/app_colors.dart';

class BottomNavigationBarContainer extends StatelessWidget {
  const BottomNavigationBarContainer({
    super.key,
    // required this.containerSvg,
    required this.svg,
    required this.text,
    required this.select,
    required this.index,
    required this.callback,
  });

  final String svg, text;
  final int select, index;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return select == index
        ? GestureDetector(
      onTap: callback,
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.onTap,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                SvgPictureWidget(
                  svg: svg,
                  callback: () {},
                  width: 22,
                  height: 22,
                  color: AppColors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                TextWidget(
                  text: text,
                  color: AppColors.white,
                  fontSize: 17,
                )
              ],
            )),
      ),
    )
        : GestureDetector(
      child: SvgPictureWidget(
        svg: svg,
        callback: callback,
        width: 22,
        height: 22,
        color: AppColors.white,
      ),
    );
  }
}
