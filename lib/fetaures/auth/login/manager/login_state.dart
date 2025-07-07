// import 'package:equatable/equatable.dart';
//
// enum LoginStatus { idle, loading, error, success }
//
// class LoginState extends Equatable {
//   final LoginStatus? status;
//
//   const LoginState({required this.status});
//
//   factory LoginState.initial() {
//     return LoginState(status: LoginStatus.loading);
//   }
//
//   LoginState copyWith({
//     LoginStatus? status,
//   }) {
//     return LoginState(status: status ?? this.status);
//   }
//
//   @override
//   List<Object?> get props => [status];
// }
