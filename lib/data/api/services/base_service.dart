import 'package:dio/dio.dart';
import 'package:healthline/data/api/exceptions/api_exception.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/rest_client.dart';
import 'package:healthline/utils/log_data.dart';

/// Request require Cookie => baseUrl + path
abstract class BaseService {
  // final String baseUrl = dotenv.get('BASE_URL', fallback: '');
  Future<DataResponse> get(String path,
      {data, Map<String, dynamic>? params, bool isDoctor = false}) async {
    // ignore: prefer_typing_uninitialized_variables
    final response;
    if (params != null) {
      response = await RestClient()
          .getDio(isDoctor: isDoctor)
          .get(path, data: data, queryParameters: params);
    } else {
      response =
          await RestClient().getDio(isDoctor: isDoctor).get(path, data: data);
    }
    return await _handleResponse(response);
  }

  Future<DataResponse> post(String path, {data, bool isDoctor = false}) async {
    final response =
        await RestClient().getDio(isDoctor: isDoctor).post(path, data: data);
    return await _handleResponse(response);
  }

  Future<DataResponse> put(String path, {data, bool isDoctor = false}) async {
    final response =
        await RestClient().getDio(isDoctor: isDoctor).put(path, data: data);
    return await _handleResponse(response);
  }

  Future<DataResponse> delete(String path,
      {data, bool isDoctor = false}) async {
    final response =
        await RestClient().getDio(isDoctor: isDoctor).delete(path, data: data);
    return await _handleResponse(response);
  }

  Future<DataResponse> patch(String path, {data, bool isDoctor = false}) async {
    final response =
        await RestClient().getDio(isDoctor: isDoctor).patch(path, data: data);
    return await _handleResponse(response);
  }

  Future<DataResponse> putUpload(String path,
      {formData, bool isDoctor = false}) async {
    final response = await RestClient()
        .getDio(isUpload: true, isDoctor: isDoctor)
        .put(path, data: formData);
    return await _handleResponse(response, isUpload: true);
  }

  Future<String> download(
      {required String filePath, required String url}) async {
    await RestClient().getDio().download(
      url,
      filePath,
      onReceiveProgress: (count, total) {
        logPrint('---Download----Rec: $count, Total: $total');
      },
    );
    return filePath;
  }

  Future<DataResponse> _handleResponse(Response response,
      {bool isUpload = false}) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (isUpload) {
          return DataResponse(
              data: response.data, message: response.statusMessage, code: response.statusCode);
        }
        try {
          return DataResponse(
              data: response.data['data'],
              message: response.statusMessage,
              code: response.statusCode);
        } catch (e) {
          throw 'error base service';
        }
      default:
        var apiResponse = ApiException.fromJson(response.data);
        throw ApiException(
          statusCode: apiResponse.statusCode,
          message: apiResponse.message,
        );
    }
  }
}
