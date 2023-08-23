class ApiException implements Exception {
  final int? statusCode;
  final String? status;
  final String? message;
  final dynamic error;

  ApiException({this.statusCode, this.status, this.message, this.error});
}
