/// Merepresentasikan error dari API, termasuk error_code custom
/// yang sudah didefinisikan di backend (bootstrap/app.php),
/// supaya UI bisa menampilkan pesan yang tepat per kasus.
class ApiException implements Exception {
  final String message;
  final String? errorCode;
  final int? statusCode;
  final Map<String, List<String>>? validationErrors;

  ApiException({
    required this.message,
    this.errorCode,
    this.statusCode,
    this.validationErrors,
  });

  bool get isEmailNotVerified => errorCode == 'EMAIL_NOT_VERIFIED';
  bool get isUnauthenticated => errorCode == 'UNAUTHENTICATED';
  bool get isValidationError => validationErrors != null;

  @override
  String toString() => message;
}