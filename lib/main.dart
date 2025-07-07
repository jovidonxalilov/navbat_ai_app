import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:navbat_ai_app/core/source/client/api_client.dart';
import 'package:navbat_ai_app/data/repository/user_repository.dart';
import 'package:navbat_ai_app/fetaures/home/manager/home_bloc.dart';
import 'package:provider/provider.dart';
import 'core/navigation/router.dart';
import 'core/source/auth/auth_local_data_source.dart';
import 'core/source/auth/data_source.dart';
import 'data/repository/auth_repository.dart';
import 'fetaures/auth/sign_up/manager/auth_bloc.dart';
import 'fetaures/common/notification_service.dart';
import 'fetaures/profile/manager/prfile_event.dart';
import 'fetaures/profile/manager/profile_bloc.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initFCM();
  }

  void _initFCM() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print("📲 FCM Token: $fcmToken");
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MultiProvider(
        providers: [
          Provider<AuthRepository>(
            create: (context) => AuthRepository(
              authDatasource: context.read<AuthDatasource>(),
              authLocalDatasource: context.read<AuthLocalDatasource>(),
            ),
          ),
          BlocProvider(create: (_) => AuthBloc()),
          BlocProvider(create: (context) => ProfileBloc(repo: context.read())..add(ProfileLoad())),
          Provider(create: (context) => ApiClient(),),
          Provider(create: (context) => UserRepository(client: context.read()),),
          BlocProvider(create: (context) => HomeBloc(repo: context.read()),)
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: router,
        ),
      ),
    );
  }
}




