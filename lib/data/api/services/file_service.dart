import 'package:dio/dio.dart';
import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/file_request.dart';
import 'package:healthline/data/api/models/responses/file_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class FileService extends BaseService {
  Future<FileResponse> uploadAvatarUser(FileRequest request) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        request.imagePath!,
      ),
      "public_id": request.publicId!,
    });
    final response =
        await putUpload(ApiConstants.UPLOAD_AVATAR_USER, formData: formData);
    return FileResponse.fromMap(response.data);
  }

  Future<FileResponse> uploadAvatarDoctor(FileRequest request) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        request.imagePath!,
      ),
    });
    final response = await putUpload(ApiConstants.UPLOAD_AVATAR_DOCTOR,
        formData: formData, isDoctor: true);
    return FileResponse.fromMap(response.data);
  }

  Future<String> downloadFile(
      {required String filePath, required String url}) async {
    final response = await download(filePath: filePath, url: url);
    return response;
  }
}
