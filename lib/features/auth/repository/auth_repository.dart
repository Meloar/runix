import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:runix_project/core/constants/firebase_constants.dart';
import 'package:runix_project/core/failure.dart';
import 'package:runix_project/core/providers/firebase_providers.dart';
import 'package:runix_project/core/type_defs.dart';
import 'package:runix_project/models/user_model.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<UserModel> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel userModel = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email!,
        name: userCredential.user!.email!
            .substring(0, userCredential.user!.email!.indexOf('@')),
        address: 'Please change your address!',
        cart: [],
      );

      await _users.doc(userCredential.user!.uid).set(userModel.toMap());

      return right(userModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.message!.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
          (event) => UserModel.fromMap(event.data() as Map<String, dynamic>),
        );
  }

  FutureEither<UserModel> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      UserModel userModel = await getUserData(userCredential.user!.uid).first;
      return right(userModel);
    } on FirebaseException catch (e) {
      return left(Failure(e.message!.toString()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
  }
}
