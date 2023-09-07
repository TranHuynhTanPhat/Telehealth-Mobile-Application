class ApiResponse {
  ApiResponse({this.data, this.message, this.statusCode, required error});
  int? statusCode;
  String? message;
  String? error;
  dynamic data;

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        message: json["message"],
        data: json["data"],
        error: json["error"],
        statusCode: json["status"],
      );

  Map<String, dynamic> toJson() =>
      {"data": data, "message": message, "status": statusCode, "error": error};
}
