import 'package:flutter/cupertino.dart';
import '../../core/source/auth/auth_local_data_source.dart';
import '../../core/source/auth/data_source.dart';
import '../model/auth_model.dart';
import '../model/profile_model.dart';

class AuthRepository extends ChangeNotifier {
  final AuthDatasource authDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepository({
    required this.authDatasource,
    required this.authLocalDatasource,
  });

  Future<AuthModel?> getAuth() async {
    return await authLocalDatasource.getAuth();
  }

  Future<AuthModel> register({
    required String email,
    required String password,
    required ProfileModel profile,
  }) async {
    try {
      final authModel = await authDatasource.register(
        email: email,
        password: password,
        profile: profile,
      );
      await authLocalDatasource.saveAuth(authModel);
      return authModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final authModel = await authDatasource.login(
        email: email,
        password: password,
      );
      await authLocalDatasource.saveAuth(authModel);
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<ProfileModel?> getUserProfile() async {
    // final auth = await getAuth();
    // if (auth == null) return null;
    final profile = await authDatasource.fetchUserProfile();
    return profile;
  }
}