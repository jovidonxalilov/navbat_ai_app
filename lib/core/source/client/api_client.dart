import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:navbat_ai_app/data/model/profile_model.dart';

class ApiClient {

  final FirebaseFirestore firestore;

  ApiClient({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<ProfileModel?> getProfile() async {
   try
        {
          final String userId = FirebaseAuth.instance.currentUser!.uid;
          final profile = await firestore.collection('web_admin').doc(userId).get();
          if (profile.exists) {
            return ProfileModel.fromJson(profile.data()!, profile.id);
          }
        } catch (e) {
     print("Fetch user profile error: $e");
   }
    return null;
  }

  Stream<UserModel> getUserStreamByPhone() {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    return firestore.collection('web_admin').doc(userId).snapshots().map((doc) {
      final data = doc.data();
      print("data: $data");
      return UserModel.fromJson({...data!, 'id': doc.id});
    });
  }

}