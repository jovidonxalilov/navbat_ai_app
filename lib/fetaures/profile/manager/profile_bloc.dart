import 'package:bloc/bloc.dart';
import 'package:navbat_ai_app/fetaures/profile/manager/prfile_event.dart';
import 'package:navbat_ai_app/fetaures/profile/manager/profile_state.dart';

import '../../../data/repository/auth_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final AuthRepository _repo;
  ProfileBloc({required AuthRepository repo}): _repo = repo,
        super(ProfileState.initial()) {
    on<ProfileLoad>(_load);
  }

  Future<void> _load(ProfileLoad event, Emitter<ProfileState> emit) async {
    try {
      emit(state.copyWith(status: ProfileStatus.loading));
      final profile = await _repo.getUserProfile();
      emit(state.copyWith(status: ProfileStatus.idle, profile: profile));
    } catch (e) {
      emit(state.copyWith(status: ProfileStatus.error, errorMessage: e.toString()));
    }
  }
}

