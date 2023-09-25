class DataResponse {
  dynamic data;
  dynamic message;
  bool success;
  int? code;
  DataResponse({
    required this.data,
    required this.message,
    this.code,
    this.success = true,
  });
}
