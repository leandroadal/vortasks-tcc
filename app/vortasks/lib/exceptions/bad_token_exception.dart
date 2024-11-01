class BadTokenException implements Exception {
  final String message;

  BadTokenException(this.message);

  @override
  String toString() {
    return message;
  }
}
