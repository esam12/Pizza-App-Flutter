import 'package:firebase_auth/firebase_auth.dart';
import 'package:pizza_app/core/utils/errors/failure.dart';
import 'package:pizza_app/features/auth/data/models/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class AuthRemoteDataSource {
  Stream<User?> get currentUserSession;

  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  FirebaseAuth firebaseAuth;
  AuthRemoteDataSourceImp(this.firebaseAuth);

  @override
  Stream<User?> get currentUserSession => firebaseAuth.authStateChanges();

  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (response.user!.uid.isEmpty) {
        throw ServerFailure('User is null!');
      }
      final userModel =
          UserModel(id: response.user!.uid, email: email, name: '');
      return UserModel.fromJson(userModel.toJson());
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(e.message.toString());
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (response.user!.uid.isEmpty) {
        throw ServerFailure('User is null!');
      }
      final userModel =
          UserModel(id: response.user!.uid, email: email, name: name);
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
      // Save the user data to Firebase under 'users' node
      await databaseReference
          .child('users')
          .child(userModel.id)
          .set(userModel.toJson());
      return UserModel.fromJson(userModel.toJson());
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(e.message.toString());
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    late final userData;
    try {
      if (currentUserSession != null) {
        userData = await currentUserSession.first;
      }
      return UserModel.fromJson(userData.first);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
