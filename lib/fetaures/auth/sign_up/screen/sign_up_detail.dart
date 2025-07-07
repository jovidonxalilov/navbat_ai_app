import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/routes.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../data/model/profile_model.dart';
import '../../../common/elevated_button_widget.dart';
import '../manager/auth_bloc.dart';
import '../manager/auth_event.dart';
import '../manager/auth_state.dart';
import '../../text_form_field.dart';

class SignUpDetail extends StatelessWidget {
  SignUpDetail({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Sign Up",
            style: TextStyle(color: AppColors.black, fontSize: 22),
          ),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthAuthenticated) {
          _emailController.clear();
          _passwordController.clear();
          _birthDateController.clear();
          _genderController.clear();
          _firstNameController.clear();
          _lastNameController.clear();
          _phoneController.clear();
          context.go(Routes.profile);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(SnackBar(content: Text(state.message)));
        }
      }, builder: (context, state) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextFormField(
                    controller: _emailController,
                    hintText: "Email",
                    keyboardType: TextInputType.emailAddress,
                    colorStyle: Colors.black,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Email kiriting";
                      final pattern = RegExp(r'^[a-zA-Z].*@gmail\.com$');
                      if (!pattern.hasMatch(value)) {
                        return "Email boshida kamida bitta harf bo‘lishi va @gmail.com bilan tugashi kerak";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    controller: _passwordController,
                    hintText: "Parol",
                    keyboardType: TextInputType.text,
                    colorStyle: Colors.black,
                    hideText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Parolni kiriting";
                      if (value.length < 6) return "Parol kamida 6 ta belgi bo'lishi kerak";
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    controller: _firstNameController,
                    hintText: "First Name",
                    keyboardType: TextInputType.text,
                    colorStyle: AppColors.black,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Ism kiriting";
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    controller: _lastNameController,
                    hintText: "Last Name",
                    keyboardType: TextInputType.text,
                    colorStyle: AppColors.black,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Familiya kiriting";
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  // MyTextFormField(
                  //   controller: _genderController,
                  //   hintText: "Jinsi (masalan: erkak)",
                  //   keyboardType: TextInputType.text,
                  //   colorStyle: AppColors.black,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) return "Jinsni kiriting";
                  //     return null;
                  //   },
                  // ),
                  // SizedBox(height: 10),
                  // BirthDateField(
                  //   controller: _birthDateController,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) return "Tug‘ilgan sanani kiriting";
                  //     try {
                  //       DateTime.parse(value);
                  //     } catch (_) {
                  //       return "To'g'ri tug'ilgan sana kiriting (YYYY-MM-DD)";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(height: 10),
                  MyTextFormField(
                    controller: _phoneController,
                    hintText: "Telefon raqami",
                    keyboardType: TextInputType.phone,
                    colorStyle: AppColors.black,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Telefon raqam kiriting";
                      if (value.length < 9) return "To'g'ri telefon raqam kiriting";
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButtonWidget(
                    text: "Ro'yxatdan Otish",
                    callback: () {
                      if (_formKey.currentState!.validate()) {
                        final profile = ProfileModel(
                          id: "drverbvte",
                          lastName: _lastNameController.text.trim(),
                          firstName: _firstNameController.text.trim(),
                          navbat: 0,
                          status: 'yangi',
                          time: DateTime.now(),
                          phone: _phoneController.text.trim(),
                        );
                        context.read<AuthBloc>().add(SignUpRequested(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          profile: profile,
                        ));
                      }
                    },
                  ),
                  SizedBox(height: 50),
                  TextButton(
                    onPressed: () {
                      context.push(Routes.login);
                    },
                    child: Center(
                      child: Text("Login"),
                    ),
                  ),
                ],
              ),

            ),
          ),
        );
      }),
    );
  }
}
