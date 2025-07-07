import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/navigation/routes.dart';
import '../../../core/utils/app_colors.dart';
import '../sign_up/manager/auth_bloc.dart';
import '../sign_up/manager/auth_state.dart';

class SplashDetail extends StatelessWidget {
  const SplashDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          await Future.delayed(Duration(seconds: 3));
          if (state is AuthSuccess) {
            context.go(Routes.profile);
          } else if (state is AuthInitial || state is AuthFailure || state is AuthError) {
            context.go(Routes.login);
          }
        },
        child: const Center(
          child: FlutterLogo(size: 100),
        ),
      ),
    );
  }
}
