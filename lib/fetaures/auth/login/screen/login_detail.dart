import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../common/login_email_text_form.dart';
import '../../../common/login_password_text_form.dart';
import '../../../common/value_listenable_builder.dart';
import '../../sign_up/manager/auth_bloc.dart';
import '../../sign_up/manager/auth_event.dart';
import '../../sign_up/manager/auth_state.dart';

class LoginDetail extends StatelessWidget {
  LoginDetail({super.key});

  final ValueNotifier<String> emailNotifier = ValueNotifier('');
  final ValueNotifier<String> passwordNotifier = ValueNotifier('');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isEmailValid(String email) => email.endsWith('@gmail.com');

  bool isPasswordValid(String password) => password.length >= 8;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(
          child: Text(
            "Login",
            style: TextStyle(color: AppColors.black, fontSize: 22),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                context.go('/home');
              } else if (state is AuthFailure)  {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Center(
                      child: Dialog(
                        backgroundColor: Colors.white,
                        child: Container(
                          width: 341.w,
                          height: 292.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.w, vertical: 36.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/about.svg",
                                width: 78.w,
                                height: 78.h,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                "Ro'yxatdan O'tib Bo'lmadi",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 30.h),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Center(
                                  child: Text(
                                    "Qayta Urinish",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: AppColors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: ValueListenableBuilder<String>(
                      valueListenable: emailNotifier,
                      builder: (context, email, _) {
                        final isValid = isEmailValid(email);
                        return LoginEmailTextForm(
                          email: email,
                          emailNotifier: emailNotifier,
                          isValid: isValid,
                          label: "",
                          hint: "Enter your email address",
                          validator: (value) => null,
                          controller: _emailController,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ValueListenableBuilder<String>(
                      valueListenable: passwordNotifier,
                      builder: (context, password, _) {
                        final isValid = isPasswordValid(password);
                        return LoginPasswordTextForm(
                          password: password,
                          isValid: isValid,
                          passwordNotifier: passwordNotifier,
                          label: "",
                          hint: "Enter your password",
                          validator: (value) => null,
                          controller:
                          _passwordController,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: double.infinity,
                  ),
                  ValueListenableBuilder2<String, String>(
                    first: emailNotifier,
                    second: passwordNotifier,
                    builder: (context, email, password, _) {
                      final isValid =
                          isEmailValid(email) && isPasswordValid(password);
                      return SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(LoginRequested(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isValid
                                ? AppColors.black
                                : AppColors.buttonBorder,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 50),
                  TextButton(
                      onPressed: () {
                        context.push(Routes.signUp);
                      },
                      child: Center(
                        child: Text("Sign Up"),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

