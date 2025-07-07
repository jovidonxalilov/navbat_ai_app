import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/navigation/routes.dart';
import '../../core/utils/app_colors.dart';
import '../auth/sign_up/manager/auth_bloc.dart';
import '../auth/sign_up/manager/auth_event.dart' show LogoutRequested;
import '../common/bottom_navigation_bar_widget.dart';
import '../common/text_widget.dart';
import 'manager/profile_bloc.dart';
import 'manager/profile_state.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
              context.go(Routes.login);
            },
            icon: Icon(Icons.logout),
            color: AppColors.red,
          )
        ],
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state.status == ProfileStatus.error) {
            return Center(child: Text("Xatolik: ${state.errorMessage}"));
          } else if (state.profile != null) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: "${state.profile!.firstName}, ",
                          color: AppColors.white,
                          fontSize: 17,
                        ),
                        TextWidget(
                          text: state.profile!.lastName,
                          color: AppColors.white,
                          fontSize: 17,
                        )
                      ],
                    ),
                    SizedBox(height: 6),
                    TextWidget(
                      text: state.profile!.phone,
                      color: AppColors.white,
                      fontSize: 17,
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text("Foydalanuvchi topilmadi"));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              context.push(Routes.home);
              break;
            case 1:
              context.push(Routes.profile);
              break;
          }
        },
      ),
    );
  }
}
