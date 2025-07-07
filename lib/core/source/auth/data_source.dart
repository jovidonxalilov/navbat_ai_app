  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:dio/dio.dart';
  import 'package:firebase_auth/firebase_auth.dart';

  import '../../../data/model/auth_model.dart';
  import '../../../data/model/profile_model.dart';

  class AuthDatasource {
    final String _myApiKey = "AIzaSyBNe30rn5LLcPFakRS-h-be8luHlIyz8BU";

    final Dio dio = Dio(BaseOptions(
      baseUrl: "https://identitytoolkit.googleapis.com/v1",
      headers: {
        "Content-Type": "application/json",
      },
    ));

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<AuthModel> register({
      required String email,
      required String password,
      required ProfileModel profile,
    }) async {
      try {
        final data = {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        };

        final response = await dio.post(
          "/accounts:signUp",
          queryParameters: {"key": _myApiKey},
          data: data,
        );

        final decodeData = response.data;

        if (decodeData["error"] != null) {
          throw Exception(decodeData["error"]["message"]);
        }

        final authModel = AuthModel.fromJson(decodeData);

        await firestore.collection('user').doc(authModel.localId).set(profile.toMap());

        return authModel;
      } catch (e) {
        print("Register error: $e");
        rethrow;
      }
    }

    Future<AuthModel> login({
      required String email,
      required String password,
    }) async {
      try {
        final data = {
          "email": email,
          "password": password,
          "returnSecureToken": true,
        };

        final response = await dio.post(
          "/accounts:signInWithPassword",
          queryParameters: {"key": _myApiKey},
          data: data,
        );

        final decodeData = response.data;

        if (decodeData["error"] != null) {
          throw Exception(decodeData["error"]["message"]);
        }

        final authModel = AuthModel.fromJson(decodeData);

        return authModel;
      } catch (e) {
        print("Login error: $e");
        rethrow;
      }
    }

    Future<ProfileModel?> fetchUserProfile() async {
      try {
        final String userId = FirebaseAuth.instance.currentUser!.uid;
        final doc = await firestore.collection('user').doc(userId).get();
        if (doc.exists) {
          return ProfileModel.fromJson(doc.data()!, doc.id);
        }
      } catch (e) {
        print("Fetch user profile error: $e");
      }
      return null;
    }
  }