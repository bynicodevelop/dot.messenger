import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dot_messenger/exceptions/user_repository_exception.dart';
import 'package:dot_messenger/models/authenticated_user_model.dart';
import 'package:dot_messenger/models/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum FollowStatusEnum {
  follow,
  unfollow,
}

class UserRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  const UserRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Future<void> _updateProfile(Map<String, dynamic> data) async {
    final Map<String, dynamic> userUpdateInfo = {};

    if (data['username'] != null) {
      userUpdateInfo['username'] = data['username'];
    }

    if (data['avatar'] != null) {
      userUpdateInfo['avatar'] = data['avatar'];
    }

    if (userUpdateInfo.isNotEmpty) {
      await firebaseFirestore
          .collection("users")
          .doc(data['uid'])
          .update(userUpdateInfo);
    }
  }

  Future<AuthenticatedUserModel> getAuthenticatedUser(User user) async {
    final DocumentSnapshot<Map<String, dynamic>> userDoc =
        await firebaseFirestore.collection("users").doc(user.uid).get();

    final Map<String, dynamic> userData = userDoc.data() ?? {};

    return AuthenticatedUserModel.fromMap({
      'uid': user.uid,
      'username': userData['username'] ?? "",
      'email': user.email ?? "",
      'avatar': userData['avatar'] ?? "",
      'description': userData['description'] ?? "",
    });
  }

  Stream<AuthenticatedUserModel> get user {
    return firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user == null) {
        return AuthenticatedUserModel.empty();
      }

      return await getAuthenticatedUser(user);
    });
  }

  Future<AuthenticatedUserModel> get authenticatedProfile async {
    User? user = firebaseAuth.currentUser!;

    return await getAuthenticatedUser(user);
  }

  Future<void> createAccount(Map<String, dynamic> userData) async {
    try {
      log("Creating account");
      await firebaseAuth.createUserWithEmailAndPassword(
        email: userData['email'],
        password: userData['password'],
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw const UserRepositoryException(
            UserRepositoryException.weakPassword);
      } else if (e.code == 'email-already-in-use') {
        throw const UserRepositoryException(
            UserRepositoryException.emailAlreadyInUse);
      } else if (e.code == 'invalid-email') {
        throw const UserRepositoryException(
            UserRepositoryException.invalidEmail);
      } else {
        throw const UserRepositoryException(
            UserRepositoryException.unexpectedError);
      }
    }
  }

  Future<void> login(Map<String, dynamic> userData) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: userData['email'],
        password: userData['password'],
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw const UserRepositoryException(
            UserRepositoryException.userNotFound);
      } else if (e.code == 'wrong-password') {
        throw const UserRepositoryException(
            UserRepositoryException.wrongPassword);
      } else {
        throw const UserRepositoryException(
            UserRepositoryException.unexpectedError);
      }
    }
  }

  Future<void> updateProfile(Map<String, dynamic> userData) async {
    final User user = firebaseAuth.currentUser!;

    userData['uid'] = user.uid;

    try {
      if (userData["email"] != null &&
          userData["email"].isNotEmpty &&
          userData["email"] != user.email) {
        await user.updateEmail(userData["email"]);
      }

      await _updateProfile(userData);
    } on FirebaseAuthException catch (e) {
      log(e.code.toString());

      if (e.code == 'email-already-in-use') {
        throw const UserRepositoryException(
          UserRepositoryException.emailAlreadyInUse,
        );
      } else if (e.code == 'invalid-email') {
        throw const UserRepositoryException(
          UserRepositoryException.invalidEmail,
        );
      } else {
        throw const UserRepositoryException(
          UserRepositoryException.unexpectedError,
        );
      }
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  Future<ProfileModel> connectUser(Map<String, dynamic> data) async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    final String uid = data["uid"];

    final DocumentReference<Map<String, dynamic>> contactUserRef =
        firebaseFirestore.collection("users").doc(uid);

    final QuerySnapshot contactUserDocumentSnapshot = await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .collection("contacts")
        .where(
          "userRef",
          isEqualTo: contactUserRef,
        )
        .get();

    if (contactUserDocumentSnapshot.docs.isNotEmpty) {
      return ProfileModel.empty();
    }

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .collection("contacts")
        .add({
      "userRef": contactUserRef,
    });

    final DocumentSnapshot<Map<String, dynamic>> contactUser =
        await contactUserRef.get();

    return ProfileModel.fromMap({
      "uid": contactUser.id,
      ...contactUser.data()!,
    });
  }

  Future<List<ProfileModel>> get contacts async {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('User is not logged in');
    }

    final QuerySnapshot<Map<String, dynamic>> contactUserDocumentSnapshot =
        await firebaseFirestore
            .collection("users")
            .doc(user.uid)
            .collection("contacts")
            .get();

    return (await Future.wait(
            contactUserDocumentSnapshot.docs.map((contact) async {
      final data = contact.data();

      final DocumentSnapshot<Map<String, dynamic>> userDocumentSnapshot =
          await data["userRef"].get();

      return ProfileModel.fromMap({
        "uid": userDocumentSnapshot.id,
        ...userDocumentSnapshot.data()!,
      });
    })))
        .toList();
  }
}
