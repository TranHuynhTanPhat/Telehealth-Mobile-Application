class ApiException implements Exception {
  final int? statusCode;
  final String? status;
  final dynamic message;
  final dynamic error;

  ApiException({this.statusCode, this.status, this.message, this.error});
}
