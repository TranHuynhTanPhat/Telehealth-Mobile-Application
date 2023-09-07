// ignore_for_file: no_leading_underscores_for_local_identifiers, constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/sentry_log_error.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestClient {
  static const CONNECT_TIME_OUT = 30000;
  static const RECEIVE_TIME_OUT = 3000;
  static const ENABLE_LOG = true;
  static const ACCESS_TOKEN_HEADER = 'Authorization';
  static const LANGUAGE = 'Accept-Language';

  // singleton
  static final RestClient instance = RestClient._internal();

  factory RestClient() {
    return instance;
  }

  RestClient._internal();

  late Map<String, dynamic> headers;

  void init(
      {String? platform,
      String? deviceId,
      String? language,
      String? appVersion,
      String? accessToken}) {
    headers = {
      'Content-Type': 'application/json',
      'X-Version': appVersion,
      'X-Platform': platform,
      'x-device-id': deviceId
    };
    if (accessToken != null) setToken(accessToken);
    setLanguage(language!);
  }

  void setToken(String token) {
    headers[ACCESS_TOKEN_HEADER] = "Bearer $token";
  }

  void setLanguage(String language) {
    headers[LANGUAGE] = language;
  }

  void clearToken() {
    headers.remove(ACCESS_TOKEN_HEADER);
  }

  BaseOptions getDioBaseOption() {
    return BaseOptions(
      // baseUrl: isUpload ? UPLOAD_PHOTO_URL : customUrl ?? instance.baseUrl,
      // Đoạn này dùng để config timeout api từ phía client, tránh việc call 1 API
      // bị lỗi trả response quá lâu.
      connectTimeout: const Duration(seconds: CONNECT_TIME_OUT),
      receiveTimeout: const Duration(seconds: RECEIVE_TIME_OUT),

      headers: instance.headers,
      responseType: ResponseType.json,
    );
  }

  static Dio getDio({bool isUpload = false}) {
    var dio = Dio(instance.getDioBaseOption());

    if (ENABLE_LOG) {
      dio.interceptors.add(LogInterceptor(
          requestBody: true, responseBody: true, logPrint: logPrint));
    }

    dio.interceptors
        .add(QueuedInterceptorsWrapper(onRequest: (options, handler) async {
      final _prefs = await SharedPreferences.getInstance();

      if (!options.path.contains('http')) {
        // Cấu hình đường path để call api, thành phần gồm
        // - Enviroment.api: Enpoint api theo môi trường, có thể dùng package dotenv
        // để cấu hình biến môi trường. Ví dụ: https://api-tech.com/v1
        // - options.path: đường dẫn cụ thể API. Ví dụ: "user/user-info"

        options.path = dotenv.get('BASE_URL', fallback: '') + options.path;
      }

      // Lấy các token được lưu tạm từ local storage
      String? accessToken = _prefs.getString('accessToken');
      String? refreshToken = _prefs.getString('refreshToken');

      // Kiểm tra xem user có đăng nhập hay chưa. Nếu chưa thì call handler.next(options)
      // để trả data về tiếp client
      if (accessToken == null || refreshToken == null) {
        return handler.next(options);
      }

      // Tính toán thời gian token expired
      bool isExpired = JwtDecoder.isExpired(accessToken);

      if (isExpired) {
        try {
          final response = await dio.post(REFRESH_TOKEN);
          if (response.statusCode == 200) {
            // ! EXPIRED SESSION
            if (response.data != false) {
              options.headers['Authorization'] =
                  "Bearer ${response.data["jwtToken"]}";
            } else {
              logout();
            }
          } else {
            logout();
          }
          return handler.next(options);
        } on DioException catch (error) {
          logout();
          return handler.reject(error, true);
        }
      } else {
        // Gắn access_token vào header, gửi kèm access_token trong header mỗi khi call API
        options.headers['Authorization'] = "Bearer $accessToken";
        return handler.next(options);
      }
    }, onResponse: (Response response, handler) {
      // Do something with response data
      return handler.next(response);
    }, onError: (DioException error, handler) async {
      // Ghi log những lỗi gửi về Sentry hoặc Firebase crashlytics
      try {
        throw error;
      } catch (error, stackTrace) {
        SentryLogError().additionalData(error, stackTrace);
      }
      if (error.response?.statusCode == 401) {
        // Đăng xuất khi hết session
        logout();
      }

      return handler.next(error);
    }));

    return dio;
  }

  static Future<void> logout() async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.remove('accessToken');
    _prefs.remove('expiredTime');
    _prefs.remove('refreshToken');
  }
}
