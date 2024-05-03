import 'dart:developer';

import 'package:pizza_app/features/login/data/models/user.dart';
import 'package:pizza_app/features/login/domain/entities/user_entity.dart';
import 'package:pizza_app/features/login/domain/repos/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseUserRepo extends UserRepository {
  final FirebaseAuth? _firebaseAuth;
  final userCollection = FirebaseFirestore.instance.collection("users");

  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<MyUser?> get user {
    return _firebaseAuth!.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        yield MyUser.empty;
      } else {
        yield await userCollection.doc(firebaseUser.uid).get().then((value) =>
            MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
      }
    });
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth!.signOut();
  }

  @override
  Future<void> setUserData(MyUser user) async {
    try {
      await userCollection.doc(user.userId).set(user.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth!.createUserWithEmailAndPassword(
          email: myUser.email, password: password);
      myUser.userId = user.user!.uid;
      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
