class UserRepositoryException implements Exception {
  static const String emailAlreadyInUse = "email-already-in-use";
  static const String userNotFound = "user-not-found";
  static const String wrongPassword = "wrong-password";
  static const String weakPassword = "weak-password";
  static const String invalidEmail = "invalid-email";
  static const String unexpectedError = "unexpected-error";
  static const String unauthenticated = "unauthenticated";

  final String message;

  const UserRepositoryException(this.message);

  @override
  String toString() {
    return message;
  }
}
