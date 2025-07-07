import 'package:flutter/material.dart';
import 'package:navbat_ai_app/fetaures/common/text_widget.dart';

import '../../core/utils/app_colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.text, required this.callback, this.height = 50, this.width = 220,
  });

  final String text;
  final VoidCallback callback;
  final double height, width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        width: 220,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.chiziq, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: TextWidget(text: text, color: AppColors.white),
        ),
      ),
    );
  }
}
