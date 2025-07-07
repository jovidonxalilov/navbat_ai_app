import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_colors.dart';

class LoginPasswordTextForm extends StatelessWidget {
  LoginPasswordTextForm({
    super.key,
    required this.label,
    required this.hint,
    required this.validator,
    required this.controller,
    required this.isValid,
    required this.password,
    required this.passwordNotifier,
  });

  final String label, hint, password;
  final String? Function(String? value) validator;
  final TextEditingController controller;
  final bool isValid;
  final ValueNotifier<String> passwordNotifier;

  final ValueNotifier<bool> _isObscure = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isObscure,
      builder: (context, obscure, _) {
        return TextFormField(
          validator: validator,
          controller: controller,
          obscureText: obscure,
          onChanged: (val) => passwordNotifier.value = val,
          keyboardType: TextInputType.visiblePassword,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            suffixIcon: passwordNotifier.value.isEmpty
                ? null
                : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () {
                      _isObscure.value = !_isObscure.value;
                    },
                    child: SvgPicture.asset(
                      obscure
                          ? 'assets/icons/eye_off.svg'
                          : 'assets/icons/eye.svg',
                      width: 22,
                      height: 22,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: SvgPicture.asset(
                    isValid
                        ? 'assets/icons/success.svg'
                        : 'assets/icons/about.svg',
                    width: 22,
                    height: 22,
                  ),
                ),
              ],
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: passwordNotifier.value.isEmpty
                    ? AppColors.hintText
                    : (isValid ? Colors.green : Colors.red),
                width: passwordNotifier.value.isEmpty ? 1.5 : 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: passwordNotifier.value.isEmpty
                    ? AppColors.hintText
                    : (isValid ? Colors.green : Colors.red),
                width: passwordNotifier.value.isEmpty ? 1.5 : 2,
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
