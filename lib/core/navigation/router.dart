import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navbat_ai_app/core/navigation/routes.dart';
import 'package:navbat_ai_app/fetaures/auth/login/screen/login_detail.dart';
import 'package:navbat_ai_app/fetaures/auth/sign_up/screen/sign_up_detail.dart';
import 'package:navbat_ai_app/fetaures/auth/splash/splash_detail.dart';
import 'package:navbat_ai_app/fetaures/home/screen/home_detail.dart';
import 'package:navbat_ai_app/fetaures/profile/profile_detail.dart';

import '../../data/repository/auth_repository.dart';
import '../../fetaures/profile/manager/prfile_event.dart';
import '../../fetaures/profile/manager/profile_bloc.dart';
import '../source/auth/auth_local_data_source.dart';
import '../source/auth/data_source.dart';

final router = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(path: Routes.login, builder: (context, state) => LoginDetail()),
    GoRoute(path: Routes.signUp, builder: (context, state) => SignUpDetail()),
    GoRoute(path: Routes.splash, builder: (context, state) => SplashDetail()),
    GoRoute(
      path: Routes.profile,
      builder: (context, state) => BlocProvider(
        create: (context) => ProfileBloc(
          repo: AuthRepository(
            authDatasource: AuthDatasource(),
            authLocalDatasource: AuthLocalDatasource(),
          ),
        )..add(ProfileLoad()),
        child: ProfileDetail(),
      ),
    ),
    GoRoute(path: Routes.home, builder: (context, state) => HomeDetail()),
  ],
);
