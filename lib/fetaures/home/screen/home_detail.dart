import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navbat_ai_app/fetaures/common/text_widget.dart';
import 'package:navbat_ai_app/fetaures/home/manager/home_bloc.dart';
import 'package:navbat_ai_app/fetaures/home/manager/home_state.dart';

import '../../../core/navigation/routes.dart';
import '../../common/bottom_navigation_bar_widget.dart';
import '../../common/notification_service.dart';

class HomeDetail extends StatelessWidget {
  HomeDetail({super.key});
  String? previousStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextWidget(text: "NavbatAiApp", color: Colors.black, fontSize: 20),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          final user = state.profile;
          if (state.status == HomeStatus.idle && user != null) {
            if (user.status != previousStatus) {
              previousStatus = user.status;

              if (user.status == "kutmoqda") {
                NotificationService.showStatusNotification(
                  "Navbat: ${user.navbat}",
                  "Sizga navbat qo'shildi",
                );
              } else if (user.status == "tayyorlanmoqda") {
                NotificationService.showStatusNotification(
                  "Navbat: ${user.navbat}",
                  "Buyurtmangiz tayyorlanmoqda",
                );
              } else if (user.status == "tayyorlandi") {
                NotificationService.showStatusNotification(
                  "Navbat: ${user.navbat}",
                  "Buyurtmangiz tayyor boʻldi!",
                );
              }
            }
          }
        },
        builder: (context, state) {
          final user = state.profile;

          if (state.status == HomeStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == HomeStatus.idle && user != null) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: TextWidget(
                              text: user.navbat.toString(),
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Telefon va Status
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: "Telefon raqam",
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                              const SizedBox(height: 4),
                              TextWidget(
                                text: user.phone,
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: user.status == "tayyorlandi"
                                ? Colors.green.shade100
                                : user.status == "tayyorlanmoqda"
                                ? Colors.orange.shade100
                                : Colors.red.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextWidget(
                            text: user.status,
                            color: user.status == "tayyorlandi"
                                ? Colors.green
                                : user.status == "tayyorlanmoqda"
                                ? Colors.orange
                                : Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (user.status != "tayyorlandi")
                      LinearProgressIndicator(
                        value: user.status == "tayyorlanmoqda" ? 0.7 : 0.3,
                        backgroundColor: Colors.grey[200],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          user.status == "tayyorlanmoqda"
                              ? Colors.orange
                              : Colors.red,
                        ),
                      ),
                  ],
                ),
              )
            );
          }

          if (state.status == HomeStatus.error) {
            return const Center(
              child: TextWidget(text: "Malumot kelmadi", color: Colors.black),
            );
          }

          return const Center(
            child: TextWidget(text: "Malumot topilmadi", color: Colors.black),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        selectIndex: 0,
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

