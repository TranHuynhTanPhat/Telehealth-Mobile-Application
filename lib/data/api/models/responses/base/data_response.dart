class DataResponse {
  dynamic data;
  dynamic message;
  bool success;
  int? code;
  DataResponse({
    this.data,
    this.message,
    this.code,
    this.success = true,
  });
}
