import 'package:navbat_ai_app/data/model/profile_model.dart';

enum HomeStatus {loading, idle, error}

class HomeState {
  final HomeStatus status;
  final UserModel? profile;

  HomeState({required this.status, required this.profile});

  factory HomeState.initial() {
    return HomeState(status: HomeStatus.loading, profile: null);
  }

  HomeState copyWith({
    HomeStatus? status,
    UserModel? profile
}) {
    return HomeState(status: status ?? this.status, profile: profile ?? this.profile);
  }
}