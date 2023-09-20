import 'package:dio/dio.dart';
import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/image_request.dart';
import 'package:healthline/data/api/models/responses/image_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class FileService extends BaseService{
  Future<ImageResponse> uploadImage(ImageRequest request) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        request.imagePath,
      ),
      "upload_preset": request.uploadPreset,
    });
    final response = await postUpload(UPLOAD, formData: formData);
    return ImageResponse.fromJson(response.data);
  }
}