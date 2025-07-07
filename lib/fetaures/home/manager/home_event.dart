import 'package:navbat_ai_app/data/model/profile_model.dart';

sealed class HomeEvent{}

class HomeLoading extends HomeEvent {
  final UserModel user;
  HomeLoading(this.user);
}

class HomeStarted extends HomeEvent{}