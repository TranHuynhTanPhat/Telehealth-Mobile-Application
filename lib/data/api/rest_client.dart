// ignore_for_file: no_leading_underscores_for_local_identifiers, constant_identifier_names
import 'dart:io';

import 'package:alice/alice.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healthline/data/api/models/responses/login_response.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/storage/app_storage.dart';
import 'package:healthline/utils/log_data.dart';
import 'package:healthline/utils/sentry_log_error.dart';

class RestClient {
  static const CONNECT_TIME_OUT = 60 * 1000;
  static const RECEIVE_TIME_OUT = 60 * 1000;
  static const ENABLE_LOG = true;
  static const ACCESS_TOKEN_HEADER = 'Authorization';
  static const LANGUAGE = 'Accept-Language';

  Alice alice = Alice(
    showNotification: false,
    showInspectorOnShake: false,
    darkTheme: false,
    maxCallsCount: 1000,
  );

  // singleton
  static final RestClient instance = RestClient._internal();

  factory RestClient() {
    return instance;
  }

  RestClient._internal();

  late Map<String, dynamic> headers;
  late CookieJar cookieJar;

  Future<void> init(
      {String? platform,
      String? deviceId,
      String? language,
      String? appVersion,
      String? accessToken}) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String appDocPath = appDocDir.path;
    cookieJar = PersistCookieJar(
      ignoreExpires: true,
      storage: FileStorage("$appDocPath/.cookies/"),
    );

    // cookieJar = CookieJar();
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
    instance.headers.remove(ACCESS_TOKEN_HEADER);
  }

  BaseOptions getDioBaseOption() {
    return BaseOptions(
      connectTimeout: const Duration(seconds: CONNECT_TIME_OUT),
      receiveTimeout: const Duration(seconds: RECEIVE_TIME_OUT),
      headers: instance.headers,
      responseType: ResponseType.json,
    );
  }

  Dio getDio({bool isUpload = false}) {
    var dio = Dio(instance.getDioBaseOption());
    dio.interceptors.add(alice.getDioInterceptor());

    dio.interceptors.add(CookieManager(instance.cookieJar));

    if (ENABLE_LOG) {
      dio.interceptors.add(LogInterceptor(
          requestBody: true, responseBody: true, logPrint: logPrint));
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!isUpload) {
            /// check path
            if (!options.path.contains('http')) {
              options.path =
                  dotenv.get('BASE_URL', fallback: '') + options.path;
            }

            /// check access token
            LoginResponse? user = await AppStorage().getUser();
            if (user == null || user.jwtToken == null) {
              return handler.next(options);
            }

            bool isExpired = JwtDecoder.isExpired(user.jwtToken!);

            /// if access token expired ---> refresh token
            /// else continue
            /// dont rt when path contain LOG_IN or SIGN_UP or REFRESH_TOKEN or LOG_OUT

            if (isExpired &&
                !options.path.contains(ApiConstants.USER_REFRESH_TOKEN) &&
                !options.path.contains(ApiConstants.USER_LOG_IN) &&
                !options.path.contains(ApiConstants.USER_LOG_OUT) &&
                !options.path.contains(ApiConstants.USER)) {
              try {
                /// refresh token if success continue
                /// else logout
                final response = await dio.post(
                    dotenv.get('BASE_URL', fallback: '') +
                        ApiConstants.USER_REFRESH_TOKEN);
                if (response.statusCode == 200) {
                  if (response.data != false) {
                    options.headers['Authorization'] =
                        "Bearer ${response.data["jwtToken"]}";
                    AppStorage()
                        .saveUser(user: user.copyWith(jwtToken: response.data));
                  } else {
                    logout();
                  }
                } else {
                  logout();
                }
                return handler.next(options);
              } on DioException catch (error) {
                logout();
                SentryLogError().additionalMessage(error, SentryLevel.error);
                return handler.reject(error, true);
              }
            } else {
              options.headers['Authorization'] = "Bearer ${user.jwtToken}";
              return handler.next(options);
            }
          } else {
            logPrint('CALL_CLOUDINARY_API');

            /// check path
            if (!options.path.contains('http')) {
              options.path =
                  dotenv.get('CLOUDINARY_API', fallback: '') + options.path;
            }
          }
        },
        onResponse: (Response response, handler) async {
          logPrint("RESPONSE");
          logPrint(response.headers);
          try {
            String refreshToken = getRefreshToken(response.headers.toString());
            if (refreshToken.isNotEmpty) {
              AppStorage().saveRefreshToken(refresh: refreshToken);
              await instance.cookieJar.saveFromResponse(
                  Uri.parse('${dotenv.get('BASE_URL', fallback: '')}/'), []);
            }
          } catch (e) {
            logPrint(e);
          }

          return handler.next(response);
        },
        onError: (DioException error, handler) async {
          logPrint("ERROR");
          logPrint(error.message);
          SentryLogError().additionalException("${error}REST_CLIENT");
          return handler.next(error);
        },
      ),
    );

    return dio;
  }

  String getRefreshToken(String headers) {
    int refreshTokenStart = headers.indexOf("refresh_token=");
    int refreshTokenEnd = headers.indexOf(";", refreshTokenStart);
    String refreshToken = headers
        .substring(refreshTokenStart, refreshTokenEnd)
        .replaceAll('refresh_token=', '');
    return refreshToken.trim();
  }

  Future<void> logout() async {
    clearToken();
    await AppStorage().clearUser();
    await AppStorage().clearRefreshToken();
    await getDio().delete(
        dotenv.get('BASE_URL', fallback: '') + ApiConstants.USER_LOG_OUT);
    instance.cookieJar.deleteAll();
  }

  void runHttpInspector() {
    alice.showInspector();
  }
}
