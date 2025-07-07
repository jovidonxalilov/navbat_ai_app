import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navbat_ai_app/data/model/profile_model.dart';
import 'package:navbat_ai_app/data/repository/user_repository.dart';
import 'package:navbat_ai_app/fetaures/home/manager/home_event.dart';
import 'package:navbat_ai_app/fetaures/home/manager/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final UserRepository _repo;
  StreamSubscription<UserModel>? _userSubscription;

  HomeBloc({required UserRepository repo}): _repo = repo,
  super(HomeState.initial()) {
    on<HomeStarted>((event, emit) async {
      emit(state.copyWith(status: HomeStatus.loading));

      await _userSubscription?.cancel();

      _userSubscription = _repo.getUsersStream().listen((user) {
          add(HomeLoading(user));
      });
    });

    on<HomeLoading>(_load);
    add(HomeStarted());
  }

  Future<void> _load(HomeLoading event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      emit(state.copyWith(status: HomeStatus.idle, profile: event.user));
    } catch (e) {
      print("xato blocda: $e");
      emit(state.copyWith(status: HomeStatus.error));
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}