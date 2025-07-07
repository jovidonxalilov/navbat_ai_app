
import 'package:equatable/equatable.dart';
import '../../../../data/model/profile_model.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class AppStarted extends AuthEvent {}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final ProfileModel profile;

  SignUpRequested({
    required this.email,
    required this.password,
    required this.profile,
  });

  @override
  List<Object?> get props => [email, password, profile];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LogoutRequested extends AuthEvent {}



