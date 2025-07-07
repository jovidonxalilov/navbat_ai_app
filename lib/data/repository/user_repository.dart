import 'package:navbat_ai_app/core/source/client/api_client.dart';
import 'package:navbat_ai_app/data/model/profile_model.dart';

class UserRepository {
  final ApiClient client;

  UserRepository({required this.client});

  Future<ProfileModel?> getProfile() async {
    final response = await client.getProfile();
    return response;
  }
  Stream<UserModel> getUsersStream() => client.getUserStreamByPhone();
}