import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_colors.dart';

class LoginEmailTextForm extends StatelessWidget {
  const LoginEmailTextForm({
    super.key,
    required this.label,
    required this.hint,
    required this.validator,
    required this.controller,
    this.isValid = true,
    required this.emailNotifier,
    required this.email,
  });

  final String label, hint, email;
  final String? Function(String? value) validator;
  final TextEditingController controller;
  final bool isValid;

  final ValueNotifier<String> emailNotifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: emailNotifier,
      builder: (context, emailValue, _) {
        return TextFormField(
          validator: validator,
          controller: controller,
          onChanged: (val) => emailNotifier.value = val,
          keyboardType: TextInputType.emailAddress,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            suffixIcon: emailValue.isEmpty
                ? null
                : Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                isValid ? 'assets/icons/success.svg' : 'assets/icons/about.svg',
                width: 24,
                height: 24,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: emailValue.isEmpty
                    ? AppColors.hintText
                    : (isValid ? Colors.green : Colors.red),
                width: emailValue.isEmpty ? 1.5 : 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: emailValue.isEmpty
                    ? AppColors.hintText
                    : (isValid ? Colors.green : Colors.red),
                width: emailValue.isEmpty ? 1.5 : 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: AppColors.white,
            hintText: hint,
            hintStyle: TextStyle(
              height: 1,
              fontSize: 14,
              color: AppColors.hintText,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 36.sp),
          ),
        );
      },
    );
  }
}
