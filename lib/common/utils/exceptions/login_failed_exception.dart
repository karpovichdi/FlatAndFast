class AuthFailedException implements Exception {
  String? message;

  AuthFailedException({this.message});

  @override
  String toString() {
    return message ?? '';
  }
}
