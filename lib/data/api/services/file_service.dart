import 'package:dio/dio.dart';
import 'package:healthline/data/api/api_constants.dart';
import 'package:healthline/data/api/models/requests/file_request.dart';
import 'package:healthline/data/api/models/responses/file_response.dart';
import 'package:healthline/data/api/services/base_service.dart';

class FileService extends BaseService {
  Future<FileResponse> updateFile(FileRequest request) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        request.imagePath!,
      ),
      "public_id": request.publicId!,
    });
    final response =
        await postUpload(ApiConstants.FILE_UPLOAD, formData: formData);
    return FileResponse.fromMap(response.data);
  }

  Future<String> downloadFile(
      {required String filePath, required String url}) async {
    final response = await download(filePath: filePath, url: url);
    return response;
  }
}
