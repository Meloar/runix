import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:runix_project/core/constants/firebase_constants.dart';
import 'package:runix_project/core/failure.dart';
import 'package:runix_project/core/providers/firebase_providers.dart';
import 'package:runix_project/core/type_defs.dart';
import 'package:runix_project/models/user_model.dart';

final profileRepositoryProvider = Provider((ref) {
  return ProfileRepository(firestore: ref.watch(firestoreProvider));
});

class ProfileRepository {
  final FirebaseFirestore _firestore;
  ProfileRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  FutureVoid editProfile(UserModel user) async {
    try {
      return right(_users.doc(user.uid).update(user.toMap()));
    } on FirebaseException catch (e) {
      return left(Failure(e.message!.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
