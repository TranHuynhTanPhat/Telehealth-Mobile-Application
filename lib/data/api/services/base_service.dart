import 'package:dio/dio.dart';
import 'package:healthline/data/api/exceptions/api_exception.dart';
import 'package:healthline/data/api/models/responses/base/api_respone.dart';
import 'package:healthline/data/api/models/responses/base/data_response.dart';
import 'package:healthline/data/api/rest_client.dart';

abstract class BaseService {
  Future<DataResponse> get(String path, {Map<String, dynamic>? params}) async {
    // ignore: prefer_typing_uninitialized_variables
    final response;
    if (params != null) {
      response = await RestClient.getDio().get(path, queryParameters: params);
    } else {
      response = await RestClient.getDio().get(path);
    }
    return await _handleResponse(response);
  }

  Future<DataResponse> post(String path, {data}) async {
    final response = await RestClient.getDio().post(path, data: data);
    return await _handleResponse(response);
  }

  Future<DataResponse> put(String path, {data}) async {
    final response = await RestClient.getDio().put(path, data: data);
    return await _handleResponse(response);
  }

  Future<DataResponse> delete(String path, {data}) async {
    final response = await RestClient.getDio().delete(path, data: data);
    return await _handleResponse(response);
  }

  Future<DataResponse> postUpload(String path, {data}) async {
    final response =
        await RestClient.getDio(isUpload: true).post(path, data: data);
    return await _handleResponse(response);
  }

  Future<DataResponse> _handleResponse(Response response) async {
    switch (response.statusCode) {
      case 200:
      case 201:
        return DataResponse(response.data);
      default:
        var apiResponse = ApiResponse.fromJson(response.data);
        throw ApiException(
          statusCode: apiResponse.statusCode,
          message: apiResponse.message,
        );
    }
  }
}
