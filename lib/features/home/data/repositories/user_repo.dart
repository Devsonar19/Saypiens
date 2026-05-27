import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/app_constants.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({FirebaseFirestore? firestore})
      : _firestore = firestore
      ?? FirebaseFirestore.instance;

  Future<void> addSaypien(SaypienUserModel user) async {
    try {
      final data = user.toMap();
      data['joinedAt'] = FieldValue.serverTimestamp();

      await _firestore
          .collection(AppConstants.saypiensCollection)
          .add(data);

    } on FirebaseException catch (e) {
      throw Exception('Database error: ${e.message}');
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}