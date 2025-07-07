import '../../../data/model/profile_model.dart';

enum ProfileStatus { idle, loading, error, errorMessage }

class ProfileState {
  final  ProfileModel? profile;
  final ProfileStatus status;
  final String? errorMessage;

  ProfileState({
    required this.profile,
    required this.status,
    this.errorMessage,
  });

  factory ProfileState.initial() {
    return ProfileState(
      profile: null,
      status: ProfileStatus.idle,
      errorMessage: null,
    );
  }

  ProfileState copyWith({
    // List<ProfileModel>? profile,
    ProfileModel? profile,
    ProfileStatus? status,
    String? errorMessage,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
